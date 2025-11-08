import '../../../../../core/network/api_response.dart';
import '../entities/login_entity.dart';
import '../repositories/auth_repository.dart';

class SignupUsecase {
  AuthRepository authRepository;

  SignupUsecase({required this.authRepository});

  Future<ApiResponse<LoginEntity>> call({
    required Map<String, dynamic> body,
  }) async {
    return await authRepository.signup(body: body);
  }
}
