import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';

abstract class AuthFirebaseService {
  Future<void> signup(CreateUserRequest request);

  Future<void> signin();
}

class AuthFirebaseServiceImplementation extends AuthFirebaseService {
  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<void> signup(CreateUserRequest request) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
    } on FirebaseAuthException catch (e) {}
  }
}
