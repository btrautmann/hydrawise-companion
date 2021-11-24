import 'package:result_type/result_type.dart';

/// A [Result] type for domain functions to return that have a potential
/// to fail for any reason
typedef UseCaseResult<SuccessType, FailureType>
    = Result<SuccessType, FailureType>;
