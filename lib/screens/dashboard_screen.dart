import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/transaction_provider.dart';
import '/widgets/transaction_tile.dart';
import 'goal_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';
import 'add_transaction_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child:
                transactionProvider.transactions.isEmpty
                    ? const Center(
                      child: Text(
                        'No transactions added yet!',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                    : ListView.builder(
                      itemCount: transactionProvider.transactions.length,
                      itemBuilder: (context, index) {
                        final transaction =
                            transactionProvider.transactions[index];
                        return Dismissible(
                          key: Key(transaction.id.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) {
                            // Delete the transaction
                            transactionProvider.deleteTransaction(
                              transaction.id,
                            );

                            // Show a confirmation snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Transaction deleted successfully!',
                                ),
                                action: SnackBarAction(
                                  label: 'UNDO',
                                  onPressed: () {
                                    transactionProvider.addTransaction(
                                      transaction,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          child: TransactionTile(transaction: transaction),
                        );
                      },
                    ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
        unselectedItemColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[400]
                : Colors.grey[700],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ReportsScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => GoalScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SettingsScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Goals'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransactionScreen()),
          );
        },
        child: Icon(
          Icons.add,
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87,
        ),
      ),
    );
  }
}
