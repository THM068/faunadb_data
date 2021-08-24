
import 'package:faunadb_data/faunadb_data.dart';
import 'package:optional/optional.dart';
import 'package:test/test.dart';

import 'model/pilot.dart';
import 'repository/pilot_repository.dart';

  void main() {
    late PilotRepository pilotRepository;

    setUp(() {
      setCurrentUserDbKey("fnAERYcfGSACSWqCqp1Ss_VflovuFLka-ke-CnNe");
      pilotRepository = new PilotRepository();
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


  }
