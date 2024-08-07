import '../mapper/auth_data_mapper.dart';
import '../models/auth_data_model.dart';
import '../../domain/entities/auth_data_entity.dart';
import '../data_sources/remote/auth_data_source.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImp({required this.authRemoteDataSource});

  @override
  Future<AuthDataEntity> userLogin(String username, String password) async {
    AuthDataModel authDataModel =
        (await authRemoteDataSource.userLoginAction(username, password));
    return authDataModel.toAuthDataEntity;
  }
}
