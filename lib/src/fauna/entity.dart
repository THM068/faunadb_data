abstract class Entity<T> {

  Map<String, dynamic> model();

  String getId();

  T fromJson(Map<String, dynamic> model);

}