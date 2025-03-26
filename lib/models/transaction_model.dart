class TransactionModel {
  final int? id;
  final String type; // Income or Expense
  final String category;
  final double amount;
  final String note;
  final DateTime date;

  TransactionModel({
    this.id,
    required this.type,
    required this.category,
    required this.amount,
    required this.note,
    required this.date,
  });

  // Convert to map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'category': category,
      'amount': amount,
      'note': note,
      'date': date.toIso8601String(),
    };
  }

  // Create object from map
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      type: map['type'],
      category: map['category'],
      amount: map['amount'],
      note: map['note'],
      date: DateTime.parse(map['date']),
    );
  }
}
