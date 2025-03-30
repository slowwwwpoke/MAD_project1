import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Icon(
          transaction.type == 'Income' ? Icons.arrow_upward : Icons.arrow_downward,
          color: transaction.type == 'Income' ? Colors.green : Colors.red,
        ),
        title: Text(transaction.category),
        subtitle: Text(transaction.note ?? 'No notes'),
        trailing: Text(
          '\$${transaction.amount.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
