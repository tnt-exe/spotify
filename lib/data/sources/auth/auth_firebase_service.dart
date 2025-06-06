import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/sign_in_request.dart';
import 'package:spotify/data/models/auth/user.dart';
import 'package:spotify/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either<String, String?>> signinGoogle();

  Future<Either<String, String?>> signup(CreateUserRequest request);

  Future<Either<String, String?>> signin(SignInRequest request);

  Future<Either<String, UserEntity>> getUser();
}

class AuthFirebaseServiceImplementation extends AuthFirebaseService {
  @override
  Future<Either<String, String?>> signin(SignInRequest request) async {
    try {
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      return Right(result.user?.uid);
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == "invalid-email") {
        message = "The email provided is invalid.";
      } else if (e.code == "wrong-password") {
        message = "Wrong password provided for that user.";
      } else if (e.code == "invalid-credential") {
        message = "The email provided is invalid.";
      } else if (e.code == "network-request-failed") {
        message = "Network error";
      }

      return Left(message);
    }
  }

  @override
  Future<Either<String, String?>> signup(CreateUserRequest request) async {
    try {
      UserCredential userData =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userData.user?.uid)
          .set({
        "name": request.fullName,
        "email": userData.user?.email,
      });

      return Right(userData.user?.uid);
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == "weak-password") {
        message = "The password provided is too weak.";
      } else if (e.code == "email-already-in-use") {
        message = "The account already exists for that email.";
      } else if (e.code == "invalid-email") {
        message = "The email provided is invalid.";
      } else if (e.code == "network-request-failed") {
        message = "Network error";
      }

      return Left(message);
    }
  }

  @override
  Future<Either<String, UserEntity>> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection("Users")
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageUrl =
          firebaseAuth.currentUser?.photoURL ?? AppUrls.defaultAvatar;

      UserEntity userEntity = userModel.toEntity();

      return Right(userEntity);
    } catch (e) {
      return const Left("An error occurred");
    }
  }

  @override
  Future<Either<String, String?>> signinGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      final userData = await FirebaseAuth.instance.signInWithCredential(cred);

      var user = await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      if (user.data() == null) {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(userData.user?.uid)
            .set({
          "name": userData.user?.displayName,
          "email": userData.user?.email,
        });
      }

      return Right(userData.user?.uid);
    } catch (e) {
      return const Left(
          "There is an error occurred while trying to log you in");
    }
  }
}
