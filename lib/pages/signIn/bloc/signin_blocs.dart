import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spider_learnings_bloc_pattern/pages/signIn/bloc/signin_events.dart';
import 'package:spider_learnings_bloc_pattern/pages/signIn/bloc/signin_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState()) {
    //on method is a type of event class
    //and takes event handlers parameters
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
  }
  void _emailEvent(EmailEvent event, Emitter<SignInState> emit) {
    print("my emai is ${event.email}");

    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit) {
    print("my emai is ${event.password}");

    emit(state.copyWith(password: event.password));
  }
}
