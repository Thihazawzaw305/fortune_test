
import 'package:fortune_test/data/user_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_response.g.dart';
@JsonSerializable()
class RegisterResponse {


  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "user")
  UserVO user;

  @JsonKey(name: "status")
  int status;


  RegisterResponse(
      this.message,
      this.status,
      this.user
      );

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);


}