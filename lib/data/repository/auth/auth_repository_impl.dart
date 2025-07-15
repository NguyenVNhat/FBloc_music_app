import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/models/auth/create_user_request.dart';
import 'package:flutter_bloc_project/data/models/auth/signin_user_request.dart';
import 'package:flutter_bloc_project/data/sources/auth/auth_firebase_service.dart';
import 'package:flutter_bloc_project/domain/repository/auth/auth.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signin(SigninUserRequest request) async {
    return await sl.get<AuthFirebaseService>().signin(request);
  }

  @override
  Future<Either> signup(CreateUserRequest request) async {
    return await sl.get<AuthFirebaseService>().signup(request);
  }
}
