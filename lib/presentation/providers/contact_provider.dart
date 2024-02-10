import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:tutorados_app/inputs/inputs.dart';

class ContactDataState {
  final Input currentAddress;
  final Input homeAddress;
  final Input cellPhoneNumber;
  final Input homePhoneNumber;
  final Email email;
  final Email tutorsEmail;
  final bool isValid;
  final bool isFormPosted;
  final bool isPosting;

  ContactDataState({
    this.currentAddress = const Input.pure(),
    this.homeAddress = const Input.pure(),
    this.cellPhoneNumber = const Input.pure(),
    this.homePhoneNumber = const Input.pure(),
    this.email = const Email.pure(),
    this.tutorsEmail = const Email.pure(),
    this.isValid = false,
    this.isFormPosted = false,
    this.isPosting = false,
  });

  ContactDataState copyWith({
    Input? currentAddress,
    Input? homeAddress,
    Input? cellPhoneNumber,
    Input? homePhoneNumber,
    Email? email,
    Email? tutorsEmail,
    bool? isValid,
    bool? isFormPosted,
    bool? isPosting,
  }) =>
      ContactDataState(
        currentAddress: currentAddress ?? this.currentAddress,
        homeAddress: homeAddress ?? this.homeAddress,
        cellPhoneNumber: cellPhoneNumber ?? this.cellPhoneNumber,
        homePhoneNumber: homePhoneNumber ?? this.homePhoneNumber,
        email: email ?? this.email,
        tutorsEmail: tutorsEmail ?? this.tutorsEmail,
        isValid: isValid ?? this.isValid,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isPosting: isPosting ?? this.isPosting,
      );
}

class ContactDataNotifier extends StateNotifier<ContactDataState> {
  ContactDataNotifier() : super(ContactDataState());

  onCurrentAddressChanged(String value) {
    final newValue = Input.dirty(value);
    state = state.copyWith(currentAddress: newValue);
  }

  onHomeAddressChanged(String value) {
    final newValue = Input.dirty(value);
    state = state.copyWith(homeAddress: newValue);
  }

  onCellPhoneNumberChanged(String value) {
    final newValue = Input.dirty(value);
    state = state.copyWith(cellPhoneNumber: newValue);
  }

  onHomePhoneNumberChanged(String value) {
    final newValue = Input.dirty(value);
    state = state.copyWith(homePhoneNumber: newValue);
  }

  onEmailChanged(String value) {
    final newValue = Email.dirty(value);
    state = state.copyWith(email: newValue);
  }

  onTutorsEmailChanged(String value) {
    final newValue = Email.dirty(value);
    state = state.copyWith(tutorsEmail: newValue);
  }

  onFormSubmit() {
    _touchEveryField();
    if (!state.isValid) return;
    print('Enviando datos...');
  }

  _touchEveryField() {
    final currentAddress = Input.dirty(state.currentAddress.value);
    final homeAdress = Input.dirty(state.homeAddress.value);
    final cellPhoneNumber = Input.dirty(state.cellPhoneNumber.value);
    final homePhoneNumber = Input.dirty(state.homePhoneNumber.value);
    final email = Email.dirty(state.email.value);
    final tutorsEmail = Email.dirty(state.tutorsEmail.value);

    state = state.copyWith(
        isFormPosted: true,
        currentAddress: currentAddress,
        homeAddress: homeAdress,
        cellPhoneNumber: cellPhoneNumber,
        homePhoneNumber: homePhoneNumber,
        email: email,
        tutorsEmail: tutorsEmail,
        isValid: Formz.validate([
          currentAddress,
          homeAdress,
          cellPhoneNumber,
          homePhoneNumber,
          email,
          tutorsEmail
        ]));
  }
}

final contactDataProvider =
    StateNotifierProvider.autoDispose<ContactDataNotifier, ContactDataState>(
        (ref) {
  return ContactDataNotifier();
});
