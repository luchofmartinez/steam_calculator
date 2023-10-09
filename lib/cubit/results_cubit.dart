import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'results_state.dart';

class ResultsCubit extends Cubit<ResultsState> {
  ResultsCubit() : super(ResultsInitial());

  void calculateTotal(double gameAmount, String location, String payment){
    emit(ResultsCalculating());
    Future.delayed(const Duration(seconds: 2));
    emit(ResultsCalculated());
  }
}
