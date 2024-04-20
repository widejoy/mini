import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class ChatMessage {
  @HiveField(0)
  late String message;
}
