import 'package:freezed_annotation/freezed_annotation.dart';

part 'controller.freezed.dart';
part 'controller.g.dart';

@freezed
class Controller with _$Controller {
  factory Controller({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'last_contact') required int lastContact,
    @JsonKey(name: 'serial_number') required String serialNumber,
    @JsonKey(name: 'controller_id') required int id,
    @JsonKey(name: 'status') required String status,
  }) = _Controller;

  factory Controller.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ControllerFromJson(json);
}
