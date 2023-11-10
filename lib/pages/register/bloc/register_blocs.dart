import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spider_learnings_bloc_pattern/pages/register/bloc/register_events.dart';
import 'package:spider_learnings_bloc_pattern/pages/register/bloc/register_states.dart';

class RegisterBlocs extends Bloc<RegisterEvent, RegisterStates> {
  RegisterBlocs() : super(RegisterStates()) {
    on<UserNameEvent>(_userNameEvent);
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<RePasswordEvent>(_rePasswordEvent);
  }
  void _userNameEvent(UserNameEvent event, Emitter<RegisterStates> emit) {
    print("${event.UserName}");
    emit(state.copyWith(userName: event.UserName));
  }

  void _emailEvent(EmailEvent event, Emitter<RegisterStates> emit) {
    print("${event.email}");
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<RegisterStates> emit) {
    print("${event.password}");
    emit(state.copyWith(password: event.password));
  }

  void _rePasswordEvent(RePasswordEvent event, Emitter<RegisterStates> emit) {
    print("${event.rePassword}");
    emit(state.copyWith(rePassword: event.rePassword));
  }
}
