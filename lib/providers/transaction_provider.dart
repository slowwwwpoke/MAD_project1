import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../services/database_helper.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  Future<void> loadTransactions() async {
    final db = await DatabaseHelper().database;
    final data = await db.query('transactions');
    _transactions = data.map((e) => TransactionModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    final db = await DatabaseHelper().database;
    await db.insert('transactions', transaction.toMap());
    loadTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    final db = await DatabaseHelper().database;
    await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
    loadTransactions();
  }
}
