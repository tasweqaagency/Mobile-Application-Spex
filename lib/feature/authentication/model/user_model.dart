import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class User {
  @JsonKey(name: 'user_id')
  @HiveField(1)
  int id;
  @HiveField(2)
  String name;
  @HiveField(3)
  String email;
  // @HiveField(4)
  // String fcmToken;
  // @HiveField(5)
  // String role;
  // @HiveField(6)
  // String password;

  User(this.id, this.name, this.email);
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
