import 'package:flutter/material.dart';
import '../models/goal_model.dart';
import '../services/database_helper.dart';

class GoalProvider with ChangeNotifier {
  List<GoalModel> _goals = [];
  List<GoalModel> get goals => _goals;

  Future<void> loadGoals() async {
    final db = await DatabaseHelper().database;
    final data = await db.query('goals');
    _goals = data.map((e) => GoalModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addGoal(GoalModel goal) async {
    final db = await DatabaseHelper().database;
    await db.insert('goals', goal.toMap());
    loadGoals();
  }

  Future<void> deleteGoal(int id) async {
    final db = await DatabaseHelper().database;
    await db.delete('goals', where: 'id = ?', whereArgs: [id]);
    loadGoals();
  }
}
