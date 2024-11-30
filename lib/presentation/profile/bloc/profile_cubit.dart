import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/auth/get_user.dart';
import 'package:spotify/presentation/profile/bloc/profile_state.dart';
import 'package:spotify/service_locator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  Future<void> getUser() async {
    var result = await sl<GetUserUseCase>().call();

    result.fold(
      (error) {
        emit(ProfileLoadFailed());
      },
      (user) {
        emit(ProfileLoaded(userEntity: user));
      },
    );
  }
}
