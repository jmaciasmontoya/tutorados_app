import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/entities/entities.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/tutor/tutor_data.dart';

class StudentState {
  final String id;
  final Student? student;
  final bool isLoading;

  StudentState({
    this.id = '',
    this.student,
    this.isLoading = true,
  });

  StudentState copyWith({
    String? id,
    Student? student,
    bool? isLoading,
  }) =>
      StudentState(
          id: id ?? this.id,
          student: student ?? this.student,
          isLoading: isLoading ?? this.isLoading);
}

class StudentNotifier extends StateNotifier<StudentState> {
  final String id;
  final TutorData tutorData;
  StudentNotifier({required this.id, required this.tutorData})
      : super(StudentState(id: id)) {
        getStudent();
      }

  Future<void> getStudent() async {
    try {
      final student = await tutorData.getStudent(id);
      state = state.copyWith(
        student: student,
        isLoading: false,
      );
    } catch (error) {
      throw Exception();
    }
  }
}

final studentProvider =
    StateNotifierProvider.autoDispose.family<StudentNotifier, StudentState, String>(
        (ref, studentId) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';
  final tutorData = TutorData(accessToken: accessToken);
  return StudentNotifier(id: studentId, tutorData: tutorData);
});
