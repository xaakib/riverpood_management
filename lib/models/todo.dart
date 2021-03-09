import 'package:uuid/uuid.dart';

var _uuid = Uuid();

class Todo {
  final String id;
  final String description;

  Todo({this.description, String id}) : id = id ?? _uuid.v4();
}
