import 'package:dio/dio.dart';
import 'package:fortune_test/network/api_constant.dart';
import 'package:fortune_test/network/responses/delete_user_response.dart';
import 'package:fortune_test/network/responses/register_response.dart';
import 'package:fortune_test/network/responses/login_response.dart'; // Import the LoginResponse class
import 'package:fortune_test/network/responses/user_list_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'the_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class TheApi {
  factory TheApi(Dio dio) = _TheApi;

  @POST(REGISTER)
  Future<RegisterResponse> registerUser(@Body() Map<String, dynamic> body);

  @POST(LOGIN)
  Future<LoginResponse> loginUser(
      @Body() Map<String, dynamic> body); // Login API method

  @GET(
      GETUSERLIST) // Assume 'USER_LIST' is the endpoint for fetching the user list
  Future<UserListResponse> getUserList(@Header('Authorization') String token);

  @DELETE(DELETEUSER)
  Future<DeleteUserResponse> deleteUser(@Header('Authorization') String token,
      @Path("userId") int userId);

  @PUT(UPDATEUSERDETAILS)
  Future<RegisterResponse> upDateUser(
      @Header('Authorization') String token,
      @Path("userId") int userId,
      @Body() Map<String, dynamic> body);

}
