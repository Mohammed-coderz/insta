import '../../../../../core/network/api_response.dart';
import '../entities/login_entity.dart';

abstract class AuthRepository {
  Future<ApiResponse<LoginEntity>> login({required Map<String, dynamic> body});
  Future<ApiResponse<LoginEntity>> signup({required Map<String, dynamic> body});
}
