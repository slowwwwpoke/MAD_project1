class TransactionModel {
  final int id;
  final String category;
  final double amount;
  final String type; // 'Income' or 'Expense'
  final DateTime date;
  final String? note; // Optional description

  TransactionModel({
    required this.id,
    required this.category,
    required this.amount,
    required this.type,
    required this.date,
    this.note,
  });

  // Convert transaction to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'type': type,
      'date': date.toIso8601String(),  // Convert DateTime to string for storage
      'note': note,
    };
  }

  // Create a TransactionModel from a JSON Map
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as int,
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      date: DateTime.parse(json['date'] as String), // Convert string back to DateTime
      note: json['note'] as String?,
    );
  }
}
