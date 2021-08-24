import 'package:optional/optional.dart';

abstract class IdentityFactory {

  /**
   * It returns a unique valid Id.
   *
   * @return a unique valid Id
   */
  Future<Optional<String>> nextId();

}