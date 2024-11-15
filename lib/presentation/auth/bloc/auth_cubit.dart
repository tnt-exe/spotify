import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthCubit extends HydratedCubit<String?> {
  AuthCubit() : super(null);

  void logIn(String uid) => emit(uid);
  void logOut() => emit(null);

  @override
  String? fromJson(Map<String, dynamic> json) {
    return json["uid"] as String?;
  }

  @override
  Map<String, dynamic>? toJson(String? state) {
    return {
      "uid": state,
    };
  }
}
