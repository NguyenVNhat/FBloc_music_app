import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/core/usecases/usecase.dart';
import 'package:flutter_bloc_project/data/models/auth/signin_user_request.dart';
import 'package:flutter_bloc_project/domain/repository/auth/auth.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class SigninUseCase implements UseCase<Either, SigninUserRequest> {
  @override
  Future<Either> call({SigninUserRequest? params}) async {
    return sl<AuthRepository>().signin(params!);
  }
}
