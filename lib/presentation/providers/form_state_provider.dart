import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';

enum FormStatus { checking, completed, notCompleted }

class FormState {
  final FormStatus formStatus;
  final int section;
  final double loadingBar;
  final int percentageCompleted;

  FormState(
      {this.formStatus = FormStatus.checking,
      this.section = 0,
      this.loadingBar = 0.0,
      this.percentageCompleted = 0});

  FormState copyWith({
    FormStatus? formStatus,
    int? section,
    double? loadingBar,
    int? percentageCompleted,
  }) =>
      FormState(
          formStatus: formStatus ?? this.formStatus,
          section: section ?? this.section,
          loadingBar: loadingBar ?? this.loadingBar,
          percentageCompleted: percentageCompleted ?? this.percentageCompleted);
}

class FormNotifier extends StateNotifier<FormState> {
  final CodeStatus codeStatus;
  FormNotifier({required this.codeStatus}) : super(FormState()) {
    checkCodeStatus();
  }

  changeSection() {
    state = state.copyWith(
        section: state.section + 1, loadingBar: state.loadingBar + 0.16);

    final percentage = calcPercentage();
    state = state.copyWith(percentageCompleted: percentage);
  }

  checkCodeStatus() {
    if (codeStatus == CodeStatus.notValid) return resetSection();
    if (codeStatus == CodeStatus.valid) {
      changeSection();
    }
  }
  

  resetSection() {
    state = state.copyWith(
      section: 0,
      loadingBar: 0.0,
      percentageCompleted: 0,
    );
  }

  calcPercentage() {
    switch (state.section) {
      case 1:
        return 20;
      case 2:
        return 40;
      case 3:
        return 50;
      case 4:
        return 70;
      case 5:
        return 80;
      case 6:
        return 100;
    }
  }
}

final formProvider = StateNotifierProvider<FormNotifier, FormState>((ref) {
  final codeStatus = ref.watch(codeStatusProvider);
  return FormNotifier(codeStatus: codeStatus);
});
