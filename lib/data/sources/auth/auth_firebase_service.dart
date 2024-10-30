import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserRequest request);

  Future<void> signin();
}

class AuthFirebaseServiceImplementation extends AuthFirebaseService {
  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<Either> signup(CreateUserRequest request) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      return const Right("signup was successful");
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == "weak-password") {
        message = "The password provided is too weak.";
      } else if (e.code == "email-already-in-use") {
        message = "The account already exists for that email.";
      }

      return Left(message);
    }
  }
}
