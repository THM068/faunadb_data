
import 'package:faunadb_data/faunadb_data.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import 'package:optional/optional.dart';
import 'package:test/test.dart';

import 'model/pilot.dart';
import 'model/space_ship.dart';
import 'repository/pilot_repository.dart';
import 'repository/space_ship_repository.dart';

  void main() {
    late PilotRepository pilotRepository;
    late SpaceShipRepository spaceshipRepository;

    setUp(() {
      setCurrentUserDbKey("fnAERYcfGSACSWqCqp1Ss_VflovuFLka-ke-CnNe");
      pilotRepository = new PilotRepository();
      spaceshipRepository = new SpaceShipRepository();
    });

    test("repository can create a new Id",() async {
      Optional<String> optionalId = await pilotRepository.nextId();
      optionalId.map((v) => print(v));
      expect(optionalId.value, isNotNull);
      expect(optionalId.value, isNotEmpty);
    });

    test("repository can find a pilot",() async {
      String expected = "Flash Gordon";
      String id = "269789402020971013";
      Optional<Pilot> pilotOptional = await pilotRepository.find(id, getPilotFromJson);
      Pilot pilot = pilotOptional.value;

      expect(pilot.name, equals(expected));
      expect(pilot.id, equals(id));
    });

    test("repository can save a pilot",() async {
      Optional<String> optionalId = await pilotRepository.nextId();
      String id = optionalId.value;
      Pilot pilot = new Pilot(id, "Test Pilot");

      Pilot result = await pilotRepository.save(pilot, getPilotFromJson);

      expect(result.name, equals("Test Pilot"));
      expect(result.id, equals(id));
    });

    test("can save a spaceship that reference a pilot",() async {
      Optional<String> optionalId = await pilotRepository.nextId();
      Ref pilotRef = Ref(Collection("Spaceships"), "269789402020971013");

      SpaceShip spaceShip = new SpaceShip(optionalId.value, "Lightning Rod", pilotRef);

      SpaceShip resultSpaceShip = await spaceshipRepository.save(spaceShip, getSpaceFromJson);

      expect(resultSpaceShip.id, equals(optionalId.value));
      expect(resultSpaceShip.name, equals("Lightning Rod"));
      expect(resultSpaceShip.pilot.id, equals(pilotRef.id));
    });

    test("can get all pilots",() async {
      PaginationOptions po = PaginationOptions(size: Optional.of(2));

      Page result  = await pilotRepository.findAll(po, getPilotFromJson);
      print(result.after);
      print(result.before);
      print(result.data);
      expect(result.data, isNotNull);
    });


  }
