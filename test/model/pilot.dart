import 'package:faunadb_data/src/fauna/entity.dart';

class Pilot extends Entity<Pilot> {
  final String id;
  final String name;

  Pilot(this.id, this.name,);

  @override
  Pilot fromJson(Map<String, dynamic> model) {
    return Pilot(model['id'], model['name']);
  }

  @override
  String getId() {
    return this.id;
  }

  @override
  Map<String, dynamic> model() {
    Map<String,dynamic> model =  {
      "id" : this.id,
      "name": this.name,
    };
    return model;
  }

  static String collection() => "Pilots";

  static String allPilotsIndex() => "all_pilots";
}

Pilot getPilotFromJson(Map<String, dynamic> json) {
  return Pilot(json['id'] as String, json['name'] as String);
}