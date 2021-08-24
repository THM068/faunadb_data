
import 'package:optional/optional_internal.dart';

class PaginationOptions {
  Optional<int>? size;
  Optional<String>? before;
  Optional<String>? after;

  /**
   * It creates a new PaginationOptions object with the given parameters.
   *
   * @param size the max number of elements to return in the requested Page
   * @param before the before cursor – if any, it indicates to return the previous Page of results before this Id (exclusive)
   * @param after the after cursor –  if any, it indicates to return the next Page of results after this Id (inclusive)
   */
  PaginationOptions({this.size, this.before, this.after});


}