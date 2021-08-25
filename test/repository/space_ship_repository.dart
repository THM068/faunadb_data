import 'package:faunadb_data/faunadb_data.dart';
import 'package:faunadb_data/src/fauna/faunadb_exception.dart';
import 'package:faunadb_http/src/fql/page.dart';

import '../model/space_ship.dart';

class SpaceShipRepository extends FaunaRepository<SpaceShip> {
  
  SpaceShipRepository() : super("Spaceships", "all_spaceships");

  @override
  Future<Page> findAll(PaginationOptions po, Function deserialize) {
    throw UnimplementedError();
  }
  
  
}