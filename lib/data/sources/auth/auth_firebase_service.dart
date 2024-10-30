import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/sign_in_request.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserRequest request);

  Future<Either> signin(SignInRequest request);
}

class AuthFirebaseServiceImplementation extends AuthFirebaseService {
  @override
  Future<Either> signin(SignInRequest request) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      return const Right("signin was successful");
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == "invalid-email") {
        message = "The email provided is invalid.";
      } else if (e.code == "wrong-password") {
        message = "Wrong password provided for that user.";
      } else if (e.code == "invalid-credential") {
        message = "The email provided is invalid.";
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserRequest request) async {
    try {
      var userData = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      FirebaseFirestore.instance.collection("Users").add({
        "name": request.fullName,
        "email": userData.user?.email,
      });

      return const Right("signup was successful");
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == "weak-password") {
        message = "The password provided is too weak.";
      } else if (e.code == "email-already-in-use") {
        message = "The account already exists for that email.";
      } else if (e.code == "invalid-email") {
        message = "The email provided is invalid.";
      }

      return Left(message);
    }
  }
}
