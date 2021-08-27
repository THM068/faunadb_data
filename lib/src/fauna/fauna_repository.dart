
import 'package:faunadb_data/faunadb_data.dart';
import 'package:faunadb_data/src/fauna/faunadb_exception.dart';
import 'package:faunadb_data/src/fauna/repository.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import 'package:optional/optional.dart';
import 'entity.dart';
import 'identity_factory.dart';

abstract class FaunaRepository<T extends Entity> implements Repository<T>, IdentityFactory {

  final String collection;
  final String all_items_index;

  FaunaRepository(this.collection, this.all_items_index);

  FaunaClient _client() => getFaunaClient();


  @override
  Future<Optional<String>> nextId() async {
    final client = _client();
    try {
      var value = await client.query(NewId());
      return Optional.of(value.toJson()['resource']);
    }
    catch(e) {
      return Optional.empty();
    }
    finally {
      client.close();
    }
  }

  @override
  Future<Optional<T>> find(String id, Function deserialize) async {
    final client = _client();
    try {
      var faunaResponse = await client.query(Get(Ref(Collection(collection), id)));
      var data = faunaResponse.toJson();
      var resource = data['resource'];
      if(resource != null) {
        T t =   deserialize(resource['data'].object);
        return Optional.of(t);
      }
      return Optional.empty();
    }
    catch(e) {
      print(e);
      return Optional.empty();
    }
    finally {
      client.close();
    }
  }

  @override
  Future<T> save(T entity, Function deserialize) async {
    final client = _client();
    try {
      final faunaResponse = await client.query(saveQuery(entity.getId() ,
                          Obj(entity.model())) );
      var data = faunaResponse.toJson();
      final resource = data['resource'];
      T t =  deserialize(resource['data'].object);
      return t;
    }
    catch(e) {
      throw FaunaDbException('Failed to save object to the database $e');
    }
    finally {
      client.close();
    }
  }

  @override
  Future<Optional<T>> remove(String id, Function deserialize) async {
    final client = _client();

    try {
      var faunaResponse = await client.query(Delete(Ref(Collection(collection),id)) );
      var data = faunaResponse.toJson();
      final resource = data['resource'];
      if(resource != null) {
        T t =  deserialize(resource['data'].object);
        return Optional.of(t);
      }
      throw FaunaDbException('Resource not found for id $id');
    }
    catch(e) {
      throw FaunaDbException('Error occured : reason $e');
    }
    finally {
      client.close();
    }
  }

  Expr saveQuery(String id, Expr data) {
    Expr query =If(
        Exists(Ref(Collection(collection), id)),
        Replace(Ref(Collection(collection), id), Obj({'data': data})),
        Create(Ref(Collection(collection), id), Obj({'data': data}))
    );
    return query;
  }

  @override
  Future<Page> findAll(PaginationOptions po, Function deserialize) async {
    final client = _client();
    try {
      final paginate = _paginate(po);
      final faunaResponse = await client.query(Map_(
          paginate,
          Lambda('nextRef', Select('data', Get(Var('nextRef'))))
      ));
      final data = faunaResponse.toJson();
      final resource = data['resource'];
      var listResult = List<T>.empty(growable: true);
      if(resource != null) {
        List dataObjects = resource['data'];
        for(var item in dataObjects) {
          T t =  deserialize(item.object);
          listResult.add(t);
        }
      }
      var after = (resource['after']?.length == null ) ? CursorType.EMPTY : resource['after']?.length > 0 ? resource['after'][0] : CursorType.EMPTY;
      var before = (resource['before']?.length == null ) ? CursorType.EMPTY : resource['before']?.length > 0 ? resource['before'][0] : CursorType.EMPTY;
      return Page(before, after, listResult);
    }
    catch(e) {
        throw FaunaDbException('An error has occurred $e');
    }
    finally {
      client.close();
    }
  }

  Paginate _paginate(PaginationOptions po) {
    if(_isOptionHasValue(po.size) && _isOptionHasValue(po.before)) {
      var size = po.size?.value;
      Object before = Ref(Collection(collection), po.before?.value);
      return Paginate(Match(Index(all_items_index)), size: size, before: before );
    }
    else if(_isOptionHasValue(po.size) && _isOptionHasValue(po.after)) {
      var size = po.size?.value;
      Object after = Ref(Collection(collection), po.after?.value);
      return Paginate(Match(Index(all_items_index)), size: size, after: after );
    }
    else if(_isOptionHasValue(po.size) && !_isOptionHasValue(po.before) && !_isOptionHasValue(po.after)){
      var size = po.size?.value;
      return Paginate(Match(Index(all_items_index)), size: size );
    }
    else {
      return Paginate(Match(Match(Index(all_items_index))));
    }
  }

  bool _isNull(Object? ob) {
    return ob == null;
  }

  bool _isOptionHasValue(Object? ob) {
    return !_isNull(ob) && (ob as Optional).isPresent;
  }

}