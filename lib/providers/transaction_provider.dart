import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction_model.dart';
import 'dart:convert';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  TransactionProvider() {
    _loadTransactions();
  }

  // Load transactions from SharedPreferences
  void _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? transactionsString = prefs.getString('transactions');
    
    if (transactionsString != null) {
      List<dynamic> transactionList = json.decode(transactionsString);
      _transactions = transactionList
          .map((data) => TransactionModel.fromJson(data))
          .toList();
    }
    notifyListeners();
  }

  // Add a new transaction
  void addTransaction(TransactionModel transaction) async {
    _transactions.add(transaction);
    await _saveTransactions();
    notifyListeners();
  }

  // Remove a transaction by ID
  void removeTransaction(int id) async {
    _transactions.removeWhere((transaction) => transaction.id == id);
    await _saveTransactions();
    notifyListeners();
  }

  // Update a transaction
  void updateTransaction(TransactionModel updatedTransaction) async {
    final index = _transactions.indexWhere((transaction) => transaction.id == updatedTransaction.id);
    if (index != -1) {
      _transactions[index] = updatedTransaction;
      await _saveTransactions();
      notifyListeners();
    }
  }

  // Save transactions to SharedPreferences
  Future<void> _saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> transactionsJson = _transactions.map((transaction) => transaction.toJson()).toList();
    String transactionsString = json.encode(transactionsJson);
    await prefs.setString('transactions', transactionsString);
  }
  void deleteTransaction(int id) {
  _transactions.removeWhere((transaction) => transaction.id == id);
  _saveTransactions(); // Save updated list to SharedPreferences
  notifyListeners();
}
}
