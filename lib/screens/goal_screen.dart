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
                goalProvider.deleteGoal(goal.id!);
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
              final newGoal = GoalModel(
                title: _goalTitleController.text,
                targetAmount: double.parse(_targetAmountController.text),
                currentAmount: 0,
                deadline: DateTime.now().add(const Duration(days: 30)),
              );
              Provider.of<GoalProvider>(context, listen: false).addGoal(newGoal);
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
