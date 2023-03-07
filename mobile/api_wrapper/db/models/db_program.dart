class DbProgram {
  DbProgram({
    required this.id,
    required this.customerId,
    required this.name,
    required this.frequency,
  });

  final int id;
  final int customerId;
  final String name;
  final List<int> frequency;
}
