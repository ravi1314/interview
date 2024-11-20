import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<CounterInitialsEvent>((event, emit) {
      emit(CounterInitial());
    });
    on<CounterIncrementEvent>(counterIncrementEvent);
    on<CounterDecrementEvent>(counterDecrementEvent);
  }
  int value = 0;

  FutureOr<void> counterIncrementEvent(
      CounterIncrementEvent event, Emitter<CounterState> emit) {
    value = value + 1;
    emit(CounterIncrementState(val: value));  
  }

  FutureOr<void> counterDecrementEvent(
      CounterDecrementEvent event, Emitter<CounterState> emit) {
    value = value - 1;
    emit(CounterDecrementState(val: value));
  }
}
