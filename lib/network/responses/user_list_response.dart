import 'package:json_annotation/json_annotation.dart';

import '../../data/user_vo.dart';

part 'user_list_response.g.dart';

@JsonSerializable()
class UserListResponse {

  @JsonKey(name: "users")
  final List<UserVO> users;

  @JsonKey(name: "status")
  final String status;

  UserListResponse({
    required this.users,
    required this.status,
  });

  // From JSON
  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$UserListResponseToJson(this);
}
