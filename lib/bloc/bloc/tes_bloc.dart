import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tes_event.dart';
part 'tes_state.dart';

class TesBloc extends Bloc<TesEvent, TesState> {
  TesBloc() : super(TesInitial()) {
    on<TesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
