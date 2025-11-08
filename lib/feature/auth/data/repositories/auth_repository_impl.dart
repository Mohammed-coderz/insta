import '../../../../../core/network/api_response.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResponse<LoginEntity>> login({
    required Map<String, dynamic> body,
  }) async {
    return await remoteDataSource.login(body: body);
  }

  @override
  Future<ApiResponse<LoginEntity>> signup({
    required Map<String, dynamic> body,
  }) async {
    return await remoteDataSource.signup(body: body);
  }
}
