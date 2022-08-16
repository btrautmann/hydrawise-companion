class DbCustomer {
  DbCustomer({
    required this.customerId,
    required this.timezone,
    required this.activeControllerId,
  });

  final int customerId;
  final String timezone;
  final int activeControllerId;
}
