import 'package:faunadb_http/faunadb_http.dart';
import 'package:optional/optional.dart';

extension EnhanceFaunaResponse on FaunaResponse {

  Optional<Object> getData() {
    var data = this.toJson();
    var resource = data['resource'];
    if(resource != null) {
      return Optional.of(resource['data'].object);
    }
    return Optional.empty();
  }
}