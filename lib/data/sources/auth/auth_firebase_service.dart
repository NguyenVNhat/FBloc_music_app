import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc_project/data/models/auth/create_user_request.dart';
import 'package:flutter_bloc_project/data/models/auth/signin_user_request.dart';
import 'package:flutter_bloc_project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthFirebaseService {
  Future<Either> signin(SigninUserRequest request);
  Future<Either> signup(CreateUserRequest request);
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserRequest request) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      if (result.user?.uid != null) {
        sl<SharedPreferences>().setString('userId', result.user?.uid ?? '');
      }
      return Right("Signup Success");
    } on FirebaseException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else {
        message = e.code;
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserRequest request) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      return Right("Signup Success");
    } on FirebaseException catch (e) {
      String message = '';
      if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else if (e.code == 'operation-not-allowed') {
        message = 'Email/password accounts are not enabled.';
      } else if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else {
        message = e.code;
      }

      return Left(message);
    }
  }
}
