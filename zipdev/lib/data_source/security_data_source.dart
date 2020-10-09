
import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart' as http;
import 'package:zipdev/data/security_repository.dart';
import 'package:zipdev/models/dto/payload_event.dart';
import 'package:zipdev/models/entities/user_model.dart';
import 'package:zipdev/models/dto/result_model.dart';
import 'package:zipdev/models/dto/event.dart';

import 'api_base_source.dart';

class SecurityDataSourceImpl extends ApiBaseSource
    implements SecurityDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SecurityDataSourceImpl(String baseUrl, {http.Client client, String token})
      : super(baseUrl, client, token);

  @override
  Future<Result<Event<UserModel>>> sigIn(
      String username, String password) async {
    Result<Event<UserModel>> _result;
    PayloadEvent<UserModel> resp = PayloadEvent({"payLoad": "injected"});
    UserModel user = new UserModel(
      username: username,
    );

    final result = await _firebaseAuth
        .signInWithEmailAndPassword(email: username, password: password)
        .catchError((onError) {
      _result = _firebaseGetError(onError);
    });

    if(_result == null){
      user.uid = result.user.uid;
      user.name = result.user.displayName;
      resp.response = user;
      _result = new Result<Event<UserModel>>.success(
        Event("200", 200, "Succesfull Transaction", "", resp));
    }
    
    return _result;
  }

  @override
  Future<Result<Event<UserModel>>> signUp(
      UserModel user, String password) async {
    Result<Event<UserModel>> _result;
    PayloadEvent<UserModel> resp = PayloadEvent({"payLoad": "injected"});

    final result = await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: user.username, password: password)
        .catchError((onError) {
      _result = _firebaseGetError(onError);
    });

    if (_result == null){
      _firebaseAuth.currentUser.updateProfile(displayName: user.name);
      user.uid = result.user.uid;
      user.name = result.user.displayName;
      resp.response = user;
      _result = new Result<Event<UserModel>>.success(
          Event("200", 200, "Succesfull Transaction", "", resp));
    }
    
    return _result;
  }

  Result<dynamic> _firebaseGetError(dynamic error) {
    if (error.toString().contains("email-already-in-use")) {
      return new Result<Event<UserModel>>.error(
          message: "The email address is already in use by another account.",
          code: 401);
    } else if (error.toString().contains("invalid-email")) {
      return new Result<Event<UserModel>>.error(
          message: "The email address is not valid.", code: 401);
    } else if (error.toString().contains("operation-not-allowed")) {
      return new Result<Event<UserModel>>.error(
          message: "The email/password accounts are not enabled..", code: 401);
    } else if (error.toString().contains("weak-password")) {
      return new Result<Event<UserModel>>.error(
          message: "The password is not strong enough.", code: 401);
    }else if (error.toString().contains("invalid-email")) {
      return new Result<Event<UserModel>>.error(
          message: "The email address is not valid", code: 401);
    }else if (error.toString().contains("user-disabled")) {
      return new Result<Event<UserModel>>.error(
          message: "The user corresponding to the given email has been disabled.", code: 401);
    }else if (error.toString().contains("user-not-found")) {
      return new Result<Event<UserModel>>.error(
          message: "There is no user corresponding to the given email.", code: 401);
    }else if (error.toString().contains("wrong-password")) {
      return new Result<Event<UserModel>>.error(
          message: "The password is invalid for the given email.", code: 401);
    } else {
      return new Result<Event<UserModel>>.error(
          message: "Unexpected error.", code: 401);
    }
  }
}
