
part of 'print_bloc.dart';


abstract class PrintState extends Equatable{
    const PrintState();

  @override
  List<Object> get props => [];  
}

class PrintInitial extends PrintState {}
class PrintLoading extends PrintState {}

class PrintSuccess extends PrintState {
  final String displayName;

  const PrintSuccess(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Authenticated { displayName: $displayName }';
}

class PrintFailure extends PrintState {}
