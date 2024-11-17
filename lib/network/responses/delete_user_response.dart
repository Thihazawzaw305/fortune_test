import 'package:json_annotation/json_annotation.dart';

part 'delete_user_response.g.dart';

@JsonSerializable()
class DeleteUserResponse {
  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "status")
  int status;

  DeleteUserResponse(this.message, this.status);

  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteUserResponseToJson(this);
}
