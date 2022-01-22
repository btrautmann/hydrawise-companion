import 'package:irri/core/utilities/typedefs.dart';

extension ObjectExtensions<I extends Object?> on I {
  T? map<T>(ValueTransformer<I, T> transform) {
    if (this == null) {
      return null;
    }
    return transform(this);
  }
}
