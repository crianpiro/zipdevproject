import 'package:zipdev/models/dto/event.dart';
import 'package:zipdev/models/dto/result_model.dart';
import 'package:zipdev/models/entities/user_model.dart';

abstract class SecurityRepository {
  Future<Result<Event<UserModel>>> sigIn(String username, String password);
  Future<Result<Event<UserModel>>> signUp(UserModel user, String password);
}

abstract class SecurityUseCase{
  Future<Result<Event<UserModel>>> sigIn(String username, String password);
  Future<Result<Event<UserModel>>> signUp(UserModel user, String password);
}

class SecurityUseCaseImpl implements SecurityUseCase {

  final SecurityRepository _securityRepository;

  SecurityUseCaseImpl(this._securityRepository);


  @override
  Future<Result<Event<UserModel>>> sigIn(String username, String password) async{
    return _securityRepository.sigIn(username, password);
  }

  @override
  Future<Result<Event<UserModel>>> signUp(UserModel user, String password) async{
    return _securityRepository.signUp(user, password);
  }
  
  
}
