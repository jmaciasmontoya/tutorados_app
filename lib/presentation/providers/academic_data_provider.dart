import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/inputs/inputs.dart';

class AcademicDataState {
  final Input highSchool;
  final double average;
  final double scoreCeneval;
  final bool isValid;
  final bool isFormPosted;
  final bool isPosting;
  final String messageAverage;

  AcademicDataState(
      {this.highSchool = const Input.pure(),
      this.average = 0.0,
      this.scoreCeneval = 0.0,
      this.isValid = false,
      this.isFormPosted = false,
      this.isPosting = false,
      this.messageAverage = ''});

  AcademicDataState copyWith({
    Input? highSchool,
    double? average,
    double? scoreCeneval,
    bool? isValid,
    bool? isFormPosted,
    bool? isPosting,
    String? messageAverage,
  }) =>
      AcademicDataState(
        highSchool: highSchool ?? this.highSchool,
        average: average ?? this.average,
        scoreCeneval: scoreCeneval ?? this.scoreCeneval,
        isValid: isValid ?? this.isValid,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isPosting: isPosting ?? this.isPosting,
        messageAverage: messageAverage ?? this.messageAverage,
      );
}

class AcademicDataNotifier extends StateNotifier<AcademicDataState> {
  AcademicDataNotifier() : super(AcademicDataState());

  onHighSchoolChanged(String value) {
    final newValue = Input.dirty(value);
    state = state.copyWith(highSchool: newValue);
  }

  onAverageChanged(double value) {
    if(value == null) {
      state = state.copyWith(messageAverage: 'El campo es requrido');
    }
    // try {
    //   final newValue = double.parse(value);
    // } catch (e) {
    //   state = state.copyWith(messageAverage: 'Solo se aceptan números');
    // }

    // if (value.runtimeType != double) {}

    // final newAverage = InputDouble.dirty(newValue);
    // state = state.copyWith(average: newAverage);
  }

  onScoreCeneval(String value) {
    // final newValue = double.parse(value);
    // final newScore = InputDouble.dirty(newValue);
    // state = state.copyWith(scoreCeneval: newScore);
  }

  onFormSubmit() {
    _touchEveryField();
    if (!state.isValid) return;
    print('Enviando datos...');
  }

  _touchEveryField() {
    // final highShool = Input.dirty(state.highSchool);
    // final average = InputDouble.dirty(state.average.value);
    // final scoreCeneval = InputDouble.dirty(state.scoreCeneval.value);

  //   state = state.copyWith(
  //       isFormPosted: true,
  //       highSchool: highShool,
  //       average: average,
  //       scoreCeneval: scoreCeneval,
  //       isValid: Formz.validate([highShool, average, scoreCeneval]));
  }
}

final academicDataProvider =
    StateNotifierProvider.autoDispose<AcademicDataNotifier, AcademicDataState>(
        (ref) {
  return AcademicDataNotifier();
});
