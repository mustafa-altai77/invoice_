
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoice/repositories/user_repository.dart';

part 'print_state.dart';
part 'print_event.dart';


class PrintBloc extends Bloc<PrintEvent, PrintState>
{
  // final UserRepository _userRepository;

  PrintBloc()://{@required UserRepository? userRepository})// :assert(_userRepository!=null),_userRepository=userRepository , super(PrintInitial());
  //  : assert(userRepository != null),
  //       _userRepository = userRepository??UserRepository(),
        super(PrintInitial());
        
  @override
  Stream<PrintState> mapEventToState(PrintEvent event) async*{
    if (event is PrintPdf) {
      yield* _mapPrintStartedToState();
    } else if (event is PrintReprent) {
      yield* _mapPrintLoggedInToState();
    } 
  }
 

    Stream<PrintState> _mapPrintStartedToState() async* {
      yield PrintLoading();
  }

  Stream<PrintState> _mapPrintLoggedInToState() async* {
    yield PrintLoading();
  }

  Stream<PrintState> _mapPrintLoggedOutToState() async* {
    yield PrintFailure();
    // _userRepository.logOut();
  }

}

