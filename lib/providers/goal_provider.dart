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
    final List<Map<String, dynamic>> jsonList = _goals.map((goal) => goal.toJson()).toList();
    prefs.setString('goals', jsonEncode(jsonList));
  }

  // Add Goal and Save
  void addGoal(GoalModel goal) {
    _goals.add(goal);
    _saveGoals();
    notifyListeners();
  }

  // Update Goal Progress with Contribution Limit and Save
  void updateGoalProgress(int index, double amount) {
    final goal = _goals[index];

    // Prevent updating a completed goal
    if (goal.isCompleted) return;

    // Prevent contributing more than the goal's target amount
    if (goal.currentAmount + amount > goal.targetAmount) {
      goal.currentAmount = goal.targetAmount;
    } else {
      goal.currentAmount += amount;
    }

    // Check if goal is completed
    if (goal.currentAmount >= goal.targetAmount) {
      goal.isCompleted = true;
    }

    _saveGoals();
    notifyListeners();
  }

  // Delete Goal and Save
  void deleteGoal(int id) {
    _goals.removeWhere((goal) => goal.id == id);
    _saveGoals();
    notifyListeners();
  }

  // Mark goal as completed and Save
  void toggleGoalCompletion(int index) {
    _goals[index].isCompleted = !_goals[index].isCompleted;
    _saveGoals();
    notifyListeners();
  }
}
