part of 'counter_bloc.dart';

abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

class CounterInitial extends CounterState {}


class CounterActionState extends CounterState{
  
}

class CounterIncrementState extends CounterState {
  final int val;

  CounterIncrementState({required this.val});
}
class CounterDecrementState extends CounterState {
  final int val;

  CounterDecrementState({required this.val});
}
