import 'package:faunadb_data/faunadb_data.dart';
import 'package:faunadb_http/query.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    setCurrentUserDbKey("fnAERYcfGSACSWqCqp1Ss_VflovuFLka-ke-CnNe");
  });

  test("getData extension can return a map",() async {
    final client = getFaunaClient();

   var faunaResponse =  await client.query(Get(Ref(Collection("Pilots"), "269789402020971013")));

   var optionalResult = faunaResponse.getData();

   expect(optionalResult.isPresent, equals(true));
   var result = (optionalResult.value as Map).cast<String, dynamic>();
   expect(result['name'], equals("Flash Gordon"));
  });
}