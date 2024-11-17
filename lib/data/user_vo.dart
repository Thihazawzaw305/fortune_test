
import 'package:json_annotation/json_annotation.dart';
part 'user_vo.g.dart';
@JsonSerializable()
class UserVO {

  @JsonKey(name: "userId")
  int userId ;

  @JsonKey(name: "username")
  String userName;

  @JsonKey(name: "password")
  String password;

  @JsonKey(name: "role")
  String? role;

  @JsonKey(name: "profilePhoto")
  String? profilePhoto;

  @JsonKey(name: "profilePhotoLink")
  String? profilePhotoLink;


  UserVO(
      this.userId,
      this.userName,
      this.password,
      this.profilePhoto,
      this.role,
      this.profilePhotoLink

      );


  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);
  Map<String, dynamic> toJson() => _$UserVOToJson(this);



}