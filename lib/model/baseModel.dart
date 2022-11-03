import 'dart:collection';
abstract class BaseModel<T> {
  T fromMap(LinkedHashMap<dynamic, dynamic> json);
  Map<String,dynamic> toJson();
}