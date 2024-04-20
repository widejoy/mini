import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String email;

  @HiveField(1)
  String username;

  UserModel({required this.email, required this.username});
}
