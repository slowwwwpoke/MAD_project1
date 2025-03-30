import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    double totalIncome = 0;
    double totalExpense = 0;

    for (var transaction in transactionProvider.transactions) {
      if (transaction.type == 'Income') {
        totalIncome += transaction.amount;
      } else {
        totalExpense += transaction.amount;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Financial Overview')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Income vs. Expenses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(sections: [
                  PieChartSectionData(
                      value: totalIncome, title: 'Income', color: Colors.green),
                  PieChartSectionData(
                      value: totalExpense, title: 'Expense', color: Colors.red),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
