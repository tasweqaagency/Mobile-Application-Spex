
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class User {
  @HiveField(1)
  String id;
  @HiveField(2)
  String name;
  @HiveField(3)
  String phone;
  @HiveField(4)
  String fcmToken;
  @HiveField(5)
  String role;
  @HiveField(6)
  String password;

  User(
     this.id,
     this.name,
     this.phone,
      this.fcmToken,
     this.role,
     this.password,
  );
  factory User.fromJson(Map<String,dynamic> json)=>_$UserFromJson(json);

  Map<String,dynamic> toJson()=>_$UserToJson(this);

}
