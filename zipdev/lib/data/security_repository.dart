import 'package:zipdev/domain/security_use_case.dart';
import 'package:zipdev/models/dto/event.dart';
import 'package:zipdev/models/dto/result_model.dart';
import 'package:zipdev/models/entities/user_model.dart';

abstract class SecurityDataSource {
  Future<Result<Event<UserModel>>> sigIn(String username, String password);
  Future<Result<Event<UserModel>>> signUp(UserModel user, String password);
}

class SecurityRepositoryImpl implements SecurityRepository {
  final SecurityDataSource _securityDataSource;

  SecurityRepositoryImpl(this._securityDataSource);

  @override
  Future<Result<Event<UserModel>>> sigIn(String username, String password) {
    return _securityDataSource.sigIn(username, password);
  }
  
    @override
    Future<Result<Event<UserModel>>> signUp(UserModel user, String password) {
    return _securityDataSource.signUp(user, password);
  }
  
}