
import 'package:faunadb_data/src/fauna/pagination_option.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'entity.dart';
import 'package:optional/optional.dart';
abstract class Repository<T extends Entity> {

  /**
   * <p>It saves the given Entity into the Repository.</p>
   *
   * <p>If an Entity with the same Id already exists in
   * the Repository, it will be replaced with the one
   * supplied.</p>
   *
   * @param entity the Entity to be saved
   * @return the saved Entity
   */
   Future<T> save(T entity, Function deserialize);

  /**
   * <p>It saves all the given Entities into the Repository.</p>
   *
   * <p>If an Entity with the same Id already exists in
   * the Repository for any of the given Entities, it
   * will be replaced with the one supplied.</p>
   *
   * @param entities the Entities to be saved
   * @return the saved Entities
   */
//  Future<List<T>> saveAll(List<T> entities);

  /**
   * It finds an Entity for the given Id.
   *
   * @param id the Id of the Entity to be found
   * @return the Entity if found or an empty result if not
   */
  Future<Optional<T>> find(String id, Function deserialize);

  /**
   * It retrieves a {@link Page} of {@link Post} entities
   * for the given {@link PaginationOptions}.
   *
   * @param po the {@link PaginationOptions} to determine which {@link Page} of results to return
   * @return a {@link Page} of Entities
//   */
  Future<Page> findAll(PaginationOptions po, Function deserialize);

  /**
   * It finds the Entity for the given Id and
   * removes it. If no Entity can be found for
   * the given Id an empty result is returned.
   *
   * @param id the Id of the Entity to be removed
   * @return the removed Entity if found or an empty result if not
   */
  Future<Optional<T>> remove(String id, Function deserialize);

}