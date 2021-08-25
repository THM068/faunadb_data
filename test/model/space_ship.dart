import 'package:faunadb_data/faunadb_data.dart';
import 'package:faunadb_http/query.dart';

class SpaceShip extends Entity<SpaceShip> {
  final String id;
  final String name;
  final Ref pilot;

  SpaceShip(this.id, this.name, this.pilot);

  @override
  SpaceShip fromJson(Map<String, dynamic> model) {
     return getSpaceFromJson(model);
  }

  @override
  String getId() {
    return this.id;
  }

  @override
  Map<String, dynamic> model() {
    return {
      "id": this.id,
      "name": this.name,
      "pilot": this.pilot
    };
  }

}

SpaceShip getSpaceFromJson(Map<String, dynamic> json) {
  return SpaceShip(
      json['id'] as String,
      json['name'] as String,
      json['pilot'].asRef(),
  );
}