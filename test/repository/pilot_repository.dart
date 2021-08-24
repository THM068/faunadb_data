
import 'package:faunadb_data/src/fauna/fauna_repository.dart';
import 'package:faunadb_data/src/fauna/pagination_option.dart';
import 'package:faunadb_http/src/fql/page.dart';
import 'package:optional/optional_internal.dart';

import '../model/pilot.dart';

class PilotRepository extends FaunaRepository<Pilot> {
  PilotRepository() : super("Pilots", "all_pilots");

  @override
  Future<Page> findAll(PaginationOptions po, Function deserialize) {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Pilot fromJson(Map<String, dynamic> model) {
    return Pilot(model['id'] as String, model['name'] as String);
  }

  @override
  Future<Optional<Pilot>> remove(String id, Function deserialize) {
    // TODO: implement remove
    throw UnimplementedError();
  }


}