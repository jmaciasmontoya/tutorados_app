import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorados_app/inputs/inputs.dart';

class SocioeconomicDataState {
  final bool work;
  final Input workplace;
  final bool economicalSupport;
  final Input livesWith;
  final bool anotherOption;

  SocioeconomicDataState(
      {this.work = false,
      this.workplace = const Input.pure(),
      this.economicalSupport = false,
      this.livesWith = const Input.dirty('Solo'),
      this.anotherOption = false});

  SocioeconomicDataState copyWith({
    bool? work,
    Input? workplace,
    bool? economicalSupport,
    Input? livesWith,
    bool? anotherOption,
  }) =>
      SocioeconomicDataState(
        work: work ?? this.work,
        workplace: workplace ?? this.workplace,
        economicalSupport: economicalSupport ?? this.economicalSupport,
        livesWith: livesWith ?? this.livesWith,
        anotherOption: anotherOption ?? this.anotherOption,
      );
}

class SocioeconomicDataNotifier extends StateNotifier<SocioeconomicDataState> {
  SocioeconomicDataNotifier() : super(SocioeconomicDataState());

  onOptionWorkChanged(bool value) {
    state = state.copyWith(work: value);
  }

  onEconomicalSupportOptionChanged(bool value) {
    state = state.copyWith(economicalSupport: value);
  }

  onLiveWithChanged(String value) {
    final newValue = Input.dirty(value);
    state = state.copyWith(livesWith: newValue);
  }

}

final socioeconomicDataProvider = StateNotifierProvider.autoDispose<
    SocioeconomicDataNotifier, SocioeconomicDataState>((ref) {
  return SocioeconomicDataNotifier();
});
