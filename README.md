This is a simple library that gives you CRUD operations for FAUNA.

## Usage

A example that shows how to save a Pilot to fauna:

Define an entity class
```Dart

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

```
Add Repository
```Dart
import 'package:faunadb_data/src/fauna/fauna_repository.dart';

import '../model/pilot.dart';

class PilotRepository extends FaunaRepository<Pilot> {
  PilotRepository() : super("Pilots", "all_pilots");
  //all_pilots is an index you need to create on Fauna
}

```

```dart
import 'package:faunadb_data/faunadb_data.dart';
//Saving an object
main() async {
  PilotRepository pilotRepository = new PilotRepository();
  setCurrentUserDbKey("<FAUNA_DB_KEY>");
  Optional<String> optionalId = await pilotRepository.nextId();
  String id = optionalId.value;
  Pilot pilot = new Pilot(id, "Test Pilot");

  Pilot result = await pilotRepository.save(pilot, getPilotFromJson);
  
  //See the test folder on github for more examples
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
