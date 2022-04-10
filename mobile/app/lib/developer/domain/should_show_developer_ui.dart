class ShouldShowDeveloperEntryPoint {
  ShouldShowDeveloperEntryPoint(
    // ignore: avoid_positional_boolean_parameters
    bool shouldShow,
  ) : _shouldShowDeveloperEntryPoint = shouldShow;

  final bool _shouldShowDeveloperEntryPoint;

  bool call() {
    return _shouldShowDeveloperEntryPoint;
  }
}
