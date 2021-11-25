import 'package:freezed_annotation/freezed_annotation.dart';

part 'frequency.freezed.dart';

@freezed
class Frequency with _$Frequency {
  factory Frequency({
    @JsonKey(name: 'monday') required bool monday,
    @JsonKey(name: 'tuesday') required bool tuesday,
    @JsonKey(name: 'wednesday') required bool wednesday,
    @JsonKey(name: 'thursday') required bool thursday,
    @JsonKey(name: 'friday') required bool friday,
    @JsonKey(name: 'saturday') required bool saturday,
    @JsonKey(name: 'sunday') required bool sunday,
  }) = _Frequency;
}

extension FrequencyX on Frequency {
  bool hasAtLeastOneDay() {
    return monday ||
        tuesday ||
        wednesday ||
        thursday ||
        friday ||
        saturday ||
        sunday;
  }

  Map<int, bool> toWeekdayMap() {
    return {
      1: monday,
      2: tuesday,
      3: wednesday,
      4: thursday,
      5: friday,
      6: saturday,
      7: sunday,
    };
  }

  static Frequency none() {
    return Frequency(
      monday: false,
      tuesday: false,
      wednesday: false,
      thursday: false,
      friday: false,
      saturday: false,
      sunday: false,
    );
  }
}