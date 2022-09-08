import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:school_project/models/user.dart';
import 'package:school_project/services/user.dart';

part 'home_user_event.dart';

part 'home_user_state.dart';

class HomeUserBloc extends Bloc<HomeUserEvent, HomeUserState> {
  final HomeUserService _userService;

  HomeUserBloc(this._userService) : super(HomeUserLoadingState()) {
    on<HomeUserLoadApiEvent>((event, emit) async {
      emit(HomeUserLoadingState());
      final dataUser = await _userService.getUser();
      emit(HomeUserLoadedState(dataUser.user ?? UserClass()));
    });
  }
}
