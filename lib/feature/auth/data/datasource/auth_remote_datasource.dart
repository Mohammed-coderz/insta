import 'package:untitled7/core/const/app_constants.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_response.dart';
import '../../domain/entities/login_entity.dart';
import '../model/login_model.dart';

abstract class AuthRemoteDatasource {
  Future<ApiResponse<LoginEntity>> login({required Map<String, dynamic> body});
  Future<ApiResponse<LoginEntity>> signup({required Map<String, dynamic> body});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  @override
  Future<ApiResponse<LoginEntity>> login({
    required Map<String, dynamic> body,
  }) async {
    final response = await ApiClient.postData<LoginEntity>(
      endpoint: AppConstants.Login_URL,
      body: body,
      fromJsonT: (data) => LoginModel.fromJson(data as Map<String, dynamic>),
    );
    return response;
  }

  @override
  Future<ApiResponse<LoginEntity>> signup({
    required Map<String, dynamic> body,
  }) async {
    final response = await ApiClient.postData<LoginEntity>(
      endpoint: AppConstants.Reg_URL,
      body: body,
      fromJsonT: (data) => LoginModel.fromJson(data as Map<String, dynamic>),
    );
    return response;
  }

}
