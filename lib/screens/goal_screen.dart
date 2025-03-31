import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/goal_model.dart';
import '../providers/goal_provider.dart';

class GoalScreen extends StatefulWidget {
  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  @override
  void initState() {
    super.initState();
    // Load goals from SharedPreferences when the screen is loaded
    Provider.of<GoalProvider>(context, listen: false).loadGoals();
  }

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
            leading: Checkbox(
              value: goal.isCompleted,
              onChanged: (value) {
                goalProvider.toggleGoalCompletion(index);
              },
            ),
            title: Text(
              goal.title,
              style: TextStyle(
                decoration: goal.isCompleted ? TextDecoration.lineThrough : null, // Strike-through if completed
              ),
            ),
            subtitle: Text('${progress.toStringAsFixed(1)}% completed'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _showCustomAmountDialog(context, goalProvider, index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    goalProvider.deleteGoal(goal.id);
                  },
                ),
              ],
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
                id: DateTime.now().millisecondsSinceEpoch,
                title: _goalTitleController.text,
                targetAmount: double.parse(_targetAmountController.text),
                currentAmount: 0,
                deadline: DateTime.now().add(const Duration(days: 30)),
                isCompleted: false,
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

  void _showCustomAmountDialog(
      BuildContext context, GoalProvider goalProvider, int index) {
    final _amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Amount to Goal'),
        content: TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Amount to Add'),
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
              double amountToAdd = double.parse(_amountController.text);
              goalProvider.updateGoalProgress(index, amountToAdd);
              Navigator.pop(ctx);
            },
            child: const Text('Add Amount'),
          ),
        ],
      ),
    );
  }
}
