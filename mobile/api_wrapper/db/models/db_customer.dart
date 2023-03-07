class DbCustomer {
  DbCustomer({
    required this.id,
    required this.apiKey,
    required this.activeControllerId,
  });

  final int id;
  final int activeControllerId;
  final String apiKey;
}
