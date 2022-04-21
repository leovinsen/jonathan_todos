import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tesc_state.dart';

class TescCubit extends Cubit<TescState> {
  TescCubit() : super(TescInitial());
}
