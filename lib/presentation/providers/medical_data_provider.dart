import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/inputs/inputs.dart';

class MedicalDataState {
  final Input socialSecurityNumber;
  final Input bloodType;
  final bool disease;
  final bool disability;
  final bool allergy;
  final bool sustance;
  final bool visual;
  final bool intellectual;
  final bool auditory;
  final bool physical;
  final List<String> disabilities;
  final bool alcohol;
  final bool cigar;
  final bool drugs;
  final List<String> sustances;

  MedicalDataState(
      {this.socialSecurityNumber = const Input.pure(),
      this.bloodType = const Input.pure(),
      this.disease = false,
      this.disability = false,
      this.allergy = false,
      this.sustance = false,
      this.visual = false,
      this.intellectual = false,
      this.auditory = false,
      this.physical = false,
      this.disabilities = const [],
      this.alcohol = false,
      this.cigar = false,
      this.drugs = false,
      this.sustances = const []});

  MedicalDataState copyWith({
    Input? socialSecurityNumber,
    Input? bloodType,
    bool? disease,
    bool? disability,
    bool? allergy,
    bool? sustance,
    bool? visual,
    bool? intellectual,
    bool? auditory,
    bool? physical,
    bool? alcohol,
    bool? cigar,
    bool? drugs,
    List<String>? disabilities,
    List<String>? sustances,
  }) =>
      MedicalDataState(
        socialSecurityNumber: socialSecurityNumber ?? this.socialSecurityNumber,
        bloodType: bloodType ?? this.bloodType,
        disease: disease ?? this.disease,
        disability: disability ?? this.disability,
        allergy: allergy ?? this.allergy,
        sustance: sustance ?? this.sustance,
        visual: visual ?? this.visual,
        intellectual: intellectual ?? this.intellectual,
        auditory: auditory ?? this.auditory,
        physical: physical ?? this.physical,
        disabilities: disabilities ?? this.disabilities,
        alcohol: alcohol ?? this.alcohol,
        cigar: cigar ?? this.cigar,
        drugs: drugs ?? this.drugs,
        sustances: sustances ?? this.sustances,
      );
}

class MedicalDataNotifier extends StateNotifier<MedicalDataState> {
  MedicalDataNotifier() : super(MedicalDataState());

  diseaseIsSelected(bool value) {
    state = state.copyWith(disease: value);
  }

  allergyIsSelected(bool value) {
    state = state.copyWith(allergy: value);
  }

  disabilityIsSelected() {
    final List<String> disabilitiesUpdated = List.from(state.disabilities);
    disabilitiesUpdated.clear();

    state = state.copyWith(
        disability: false,
        visual: false,
        intellectual: false,
        auditory: false,
        physical: false,
        disabilities: disabilitiesUpdated);
  }

  visualSelected() {
    final List<String> disabilitiesUpdated = List.from(state.disabilities);

    if (!state.visual) {
      disabilitiesUpdated.add('Visual');

      state = state.copyWith(
          visual: true, disability: true, disabilities: disabilitiesUpdated);
      return;
    }

    disabilitiesUpdated.remove('Visual');
    state = state.copyWith(visual: false, disabilities: disabilitiesUpdated);
  }

  intellectualSelected() {
    final List<String> disabilitiesUpdated = List.from(state.disabilities);

    if (!state.intellectual) {
      disabilitiesUpdated.add('Intelectual');

      state = state.copyWith(
          intellectual: true,
          disability: true,
          disabilities: disabilitiesUpdated);
      return;
    }

    disabilitiesUpdated.remove('Intelectual');

    state =
        state.copyWith(intellectual: false, disabilities: disabilitiesUpdated);
    verifyDisabilities();
  }

  auditorySelected() {
    final List<String> disabilitiesUpdated = List.from(state.disabilities);

    if (!state.auditory) {
      disabilitiesUpdated.add('Auditiva');

      state = state.copyWith(
          auditory: true, disability: true, disabilities: disabilitiesUpdated);
      return;
    }

    disabilitiesUpdated.remove('Auditiva');
    state = state.copyWith(auditory: false, disabilities: disabilitiesUpdated);
    verifyDisabilities();
  }

  physicalSelected() {
    final List<String> disabilitiesUpdated = List.from(state.disabilities);

    if (!state.physical) {
      disabilitiesUpdated.add('Física/Motriz');

      state = state.copyWith(
          physical: true, disability: true, disabilities: disabilitiesUpdated);
      verifyDisabilities();
      return;
    }

    disabilitiesUpdated.remove('Física/Motriz');
    state = state.copyWith(physical: false, disabilities: disabilitiesUpdated);
    verifyDisabilities();
  }

  sustancesIsSelected() {
    final List<String> sustancesUpdated = List.from(state.sustances);
    sustancesUpdated.clear();

    state = state.copyWith(
        sustance: false,
        alcohol: false,
        cigar: false,
        drugs: false,
        sustances: sustancesUpdated);
  }

  alcoholSelected() {
    final List<String> sustancesUpdated = List.from(state.sustances);

    if (!state.alcohol) {
      sustancesUpdated.add('Alcohol');

      state = state.copyWith(
          alcohol: true, sustance: true, sustances: sustancesUpdated);
      return;
    }

    sustancesUpdated.remove('Alcohol');

    state = state.copyWith(alcohol: false, sustances: sustancesUpdated);
    verifySustances();
  }

  cigarSelected() {
    final List<String> sustancesUpdated = List.from(state.sustances);

    if (!state.cigar) {
      sustancesUpdated.add('Cigarro');

      state = state.copyWith(
          cigar: true, sustance: true, sustances: sustancesUpdated);
      return;
    }

    sustancesUpdated.remove('Cigarro');

    state = state.copyWith(cigar: false, sustances: sustancesUpdated);
    verifySustances();
  }

  drugsSelected() {
    final List<String> sustancesUpdated = List.from(state.sustances);

    if (!state.drugs) {
      sustancesUpdated.add('Drogas');

      state = state.copyWith(
          drugs: true, sustance: true, sustances: sustancesUpdated);
      return;
    }

    sustancesUpdated.remove('Drogas');

    state = state.copyWith(drugs: false, sustances: sustancesUpdated);
    verifySustances();
  }

  verifySustances() {
    if (!state.alcohol && !state.cigar && !state.drugs) {
      state = state.copyWith(sustance: false);
    }
  }

  verifyDisabilities() {
    if (!state.visual &&
        !state.intellectual &&
        !state.auditory &&
        !state.physical) {
      state = state.copyWith(disability: false);
    }
  }
}

final medicalDataProvider =
    StateNotifierProvider<MedicalDataNotifier, MedicalDataState>((ref) {
  return MedicalDataNotifier();
});
