import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:tutorados_app/admin/admin_data.dart';
import 'package:tutorados_app/inputs/inputs.dart';
import 'package:tutorados_app/presentation/providers/providers.dart';
import 'package:tutorados_app/tutor/admin_error.dart';

class RegisterTutorFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Name name;
  final LastName lastName;
  final Email email;
  final bool userRegistred;
  final String message;
  final Map tutorInfo;

  RegisterTutorFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.name = const Name.pure(),
      this.lastName = const LastName.pure(),
      this.email = const Email.pure(),
      this.userRegistred = false,
      this.message = '',
      this.tutorInfo = const {}});

  RegisterTutorFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Name? name,
    LastName? lastName,
    Email? email,
    bool? userRegistred,
    String? message,
    Map? tutorInfo,
  }) =>
      RegisterTutorFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          name: name ?? this.name,
          lastName: lastName ?? this.lastName,
          email: email ?? this.email,
          userRegistred: userRegistred ?? this.userRegistred,
          message: message ?? this.message,
          tutorInfo: tutorInfo ?? this.tutorInfo);
}

class RegisterTutorNotifier extends StateNotifier<RegisterTutorFormState> {
  final AdminData adminData;
  RegisterTutorNotifier({required this.adminData})
      : super(RegisterTutorFormState());

  onNameChange(String value) {
    final newName = Name.dirty(value);
    state = state.copyWith(
        name: newName,
        isValid: Formz.validate([newName, state.lastName, state.email]));
  }

  onLastNameChange(String value) {
    final newLastName = LastName.dirty(value);
    state = state.copyWith(
        lastName: newLastName,
        isValid: Formz.validate([newLastName, state.name, state.email]));
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state =  state.copyWith(email: newEmail, isValid: Formz.validate([newEmail]));
  }
  
  closeModal() {
    state = state.copyWith(email: const Email.pure(), isValid: false, tutorInfo: const {}, message: '', userRegistred: false);
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    await sendData();

    state = state.copyWith(isPosting: false);
  }

  sendData() async {
    try {
      final tutorInfo = await adminData.registerTutor(
          state.name.value, state.lastName.value, state.email.value);
      state = state.copyWith(tutorInfo: tutorInfo, userRegistred: true);
    } on AdminError catch (error) {
      state = state.copyWith(message: error.message, userRegistred: false);
    }
    state = state.copyWith(message: '', userRegistred: false);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final name = Name.dirty(state.name.value);
    final lastName = LastName.dirty(state.lastName.value);
    state = state.copyWith(
        isFormPosted: true,
        email: email,
        name: name,
        lastName: lastName,
        isValid: Formz.validate([email, name, lastName]));
  }
}

final registerTutorProvider = StateNotifierProvider.autoDispose<
    RegisterTutorNotifier, RegisterTutorFormState>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';
  final AdminData adminData = AdminData(accessToken: accessToken);
  return RegisterTutorNotifier(adminData: adminData);
});
