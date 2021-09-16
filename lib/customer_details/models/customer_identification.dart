import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_identification.freezed.dart';
part 'customer_identification.g.dart';

@freezed
class CustomerIdentification with _$CustomerIdentification {
  factory CustomerIdentification({
    @JsonKey(name: 'controller_id') required int activeControllerId,
    @JsonKey(name: 'customer_id') required int customerId,
    @JsonKey(name: 'api_key') required String apiKey,
    @JsonKey(name: 'last_status_update') required int lastStatusUpdate
  }) = _CustomerIdentification;

  factory CustomerIdentification.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CustomerIdentificationFromJson(json);
}
