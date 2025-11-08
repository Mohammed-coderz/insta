import '../../../../../core/network/api_response.dart';
import '../entities/login_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  AuthRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  Future<ApiResponse<LoginEntity>> call({
    required Map<String, dynamic> body,
  }) async {
    return await loginRepository.login(body: body);
  }
}
