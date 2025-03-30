import 'package:flutter/material.dart';
import '../models/goal_model.dart';

class GoalProvider with ChangeNotifier {
  final List<GoalModel> _goals = [];

  List<GoalModel> get goals => _goals;

  void addGoal(GoalModel goal) {
    _goals.add(goal);
    notifyListeners();
  }

  void updateGoal(int index, double amount) {
    _goals[index].currentAmount += amount;
    notifyListeners();
  }

  void deleteGoal(int id) {
    _goals.removeWhere((goal) => goal.id == id);
    notifyListeners();
  }
}
