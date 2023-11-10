import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_events.dart';
import 'app_states.dart';

class AppBlocs extends Bloc<AppEvent, AppState> {
  AppBlocs() : super(AppState()) {
    on<TriggerAppEvent>((event, emit) {
      print("my tapped index is ${event.index}");
      emit(AppState(index: event.index));
    });
  }
}
