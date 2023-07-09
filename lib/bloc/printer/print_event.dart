
part of 'print_bloc.dart';

abstract class PrintEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class PrintStarted extends PrintEvent {}

class PrintPdf extends PrintEvent {}

class PrintReprent extends PrintEvent {}

class TestEvent extends PrintEvent {}

