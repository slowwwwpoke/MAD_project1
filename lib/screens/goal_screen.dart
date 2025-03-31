import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/goal_model.dart';
import '../providers/goal_provider.dart';

class GoalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final goalProvider = Provider.of<GoalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings Goals'),
      ),
      body: ListView.builder(
        itemCount: goalProvider.goals.length,
        itemBuilder: (context, index) {
          final goal = goalProvider.goals[index];
          double progress = (goal.currentAmount / goal.targetAmount) * 100;
          return ListTile(
            title: Text(goal.title),
            subtitle: Text('${progress.toStringAsFixed(1)}% completed'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog(context, goal, goalProvider);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddGoalDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, GoalModel goal, GoalProvider goalProvider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this goal?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Dismiss dialog
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              goalProvider.deleteGoal(goal.id!);
              Navigator.pop(ctx); // Close dialog after deletion
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context) {
    final _goalTitleController = TextEditingController();
    final _targetAmountController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add New Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _goalTitleController,
              decoration: const InputDecoration(labelText: 'Goal Title'),
            ),
            TextField(
              controller: _targetAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Target Amount'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_goalTitleController.text.isEmpty ||
                  _targetAmountController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }
              final newGoal = GoalModel(
                title: _goalTitleController.text,
                targetAmount: double.parse(_targetAmountController.text),
                currentAmount: 0,
                deadline: DateTime.now().add(const Duration(days: 30)),
              );
              Provider.of<GoalProvider>(context, listen: false).addGoal(newGoal);
              Navigator.pop(ctx); // Close dialog after adding goal
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
