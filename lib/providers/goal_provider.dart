import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/goal_model.dart';

class GoalProvider with ChangeNotifier {
  final List<GoalModel> _goals = [];

  List<GoalModel> get goals => _goals;

  // Load Goals from SharedPreferences
  Future<void> loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('goals');
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      _goals.clear();
      _goals.addAll(jsonList.map((item) => GoalModel.fromJson(item)));
      notifyListeners();
    }
  }

  // Save Goals to SharedPreferences
  Future<void> _saveGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList = _goals.map((item) => item.toJson()).toList();
    prefs.setString('goals', jsonEncode(jsonList));
  }

  // Add Goal and Save
  void addGoal(GoalModel goal) {
    _goals.add(goal);
    _saveGoals();
    notifyListeners();
  }

  // Update Goal and Save
  void updateGoal(int index, double amount) {
    _goals[index].currentAmount += amount;
    _saveGoals();
    notifyListeners();
  }

  // Delete Goal and Save
  void deleteGoal(int id) {
    _goals.removeWhere((goal) => goal.id == id);
    _saveGoals();
    notifyListeners();
  }
}
