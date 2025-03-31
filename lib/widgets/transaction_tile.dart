import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context, listen: false);

    return ListTile(
      leading: Icon(
        transaction.type == 'Income' ? Icons.arrow_upward : Icons.arrow_downward,
        color: transaction.type == 'Income' ? Colors.green : Colors.red,
      ),
      title: Text(
        transaction.category,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${transaction.note}\n${transaction.date.toLocal().toString().split(' ')[0]}',
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Theme.of(context).brightness == Brightness.dark ? Colors.red[300] : Colors.red,
        ),
        onPressed: () {
          transactionProvider.deleteTransaction(transaction.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transaction deleted!')),
          );
        },
      ),
    );
  }
}
