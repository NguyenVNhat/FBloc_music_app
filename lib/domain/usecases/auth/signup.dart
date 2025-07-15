import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/core/usecases/usecase.dart';
import 'package:flutter_bloc_project/data/models/auth/create_user_request.dart';
import 'package:flutter_bloc_project/domain/repository/auth/auth.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class SignupUseCase implements UseCase<Either, CreateUserRequest> {
  @override
  Future<Either> call({CreateUserRequest? params}) async {
    return sl<AuthRepository>().signup(params!);
  }
}
