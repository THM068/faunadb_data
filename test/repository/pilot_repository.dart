
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



}