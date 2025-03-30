class TransactionModel {
  final String type;
  final String category;
  final double amount;
  final String? note;
  final DateTime date;

  TransactionModel({
    required this.type,
    required this.category,
    required this.amount,
    this.note,
    required this.date,
  });
}
