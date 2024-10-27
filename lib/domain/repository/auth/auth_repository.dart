import 'package:spotify/data/models/auth/create_user_request.dart';

abstract class AuthRepository {
  Future<void> signup(CreateUserRequest request);

  Future<void> signin();
}
