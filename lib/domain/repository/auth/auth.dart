import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/models/auth/create_user_request.dart';
import 'package:flutter_bloc_project/data/models/auth/signin_user_request.dart';

abstract class AuthRepository {
  Future<Either> signin(SigninUserRequest request);
  Future<Either> signup(CreateUserRequest request);
}
