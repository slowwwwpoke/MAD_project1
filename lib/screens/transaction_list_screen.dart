import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction_model.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var transactionProvider = Provider.of<TransactionProvider>(context);
    List<TransactionModel> transactions = transactionProvider.transactions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions List'),
      ),
      body: transactions.isEmpty
          ? const Center(
              child: Text(
                'No transactions found.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(
                      transaction.type == 'Income' ? Icons.arrow_upward : Icons.arrow_downward,
                      color: transaction.type == 'Income' ? Colors.green : Colors.red,
                    ),
                    title: Text(transaction.category),
                    subtitle: Text(
                      '${transaction.note}\n${transaction.date}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: Text(
                      '\$${transaction.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: transaction.type == 'Income' ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      _showTransactionDetails(context, transaction);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add_transaction'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showTransactionDetails(BuildContext context, TransactionModel transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(transaction.category),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Type: ${transaction.type}'),
            Text('Amount: \$${transaction.amount.toStringAsFixed(2)}'),
            Text('Description: ${transaction.note}'),
            Text('Date: ${transaction.date}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
