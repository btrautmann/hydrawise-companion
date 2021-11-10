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
