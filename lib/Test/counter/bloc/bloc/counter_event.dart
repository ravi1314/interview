part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class CounterInitialsEvent extends CounterEvent {}

// Make the integer non-nullable
class CounterIncrementEvent extends CounterEvent {
  
}

class CounterDecrementEvent extends CounterEvent {
  
}
