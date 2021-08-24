import 'package:faunadb_data/faunadb_data.dart';
import 'package:test/test.dart';

void main() {

  test("getFaunaDbConfig contains a map",(){
    var result = getFaunaDbConfig();

    expect(result is Map, isTrue);
  });

  test("can set application key",(){
    String appKey = "some-key";
    setApplicationDbKey(appKey);

    expect(getApplicationDBKey(),equals(appKey));
  });

}