import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _selectedType = 'Expense';
  String? _selectedCategory;
  final List<String> _expenseCategories = ['Food', 'Rent', 'Entertainment', 'Other'];

  void _addTransaction() {
    final double? amount = double.tryParse(_amountController.text);

    if (amount == null || (_selectedType == 'Expense' && _selectedCategory == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid data!')),
      );
      return;
    }

    final newTransaction = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch,  // Use the current timestamp as the ID
      type: _selectedType,
      category: _selectedType == 'Income' ? 'Income' : _selectedCategory!,
      amount: amount,
      note: _noteController.text,
      date: DateTime.now(),
    );

    Provider.of<TransactionProvider>(context, listen: false).addTransaction(newTransaction);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Transaction Type Dropdown
            DropdownButton<String>(
              value: _selectedType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue!;
                  if (_selectedType == 'Income') {
                    _selectedCategory = null; // Clear category if switching to income
                  }
                });
              },
              items: ['Expense', 'Income'].map<DropdownMenuItem<String>>((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Category Dropdown (Hidden for Income)
            if (_selectedType == 'Expense')
              DropdownButton<String>(
                value: _selectedCategory,
                hint: const Text('Select Category'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                items: _expenseCategories.map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),

            const SizedBox(height: 16),

            // Amount Input
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter amount'),
            ),

            const SizedBox(height: 16),

            // Notes Input (Optional)
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Notes (optional)'),
            ),

            const SizedBox(height: 32),

            // Save Button
            ElevatedButton(
              onPressed: _addTransaction,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
