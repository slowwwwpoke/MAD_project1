class GoalModel {
  final int? id;
  final String title;
  final double targetAmount;
  double currentAmount;
  final DateTime deadline;

  GoalModel({
    this.id,
    required this.title,
    required this.targetAmount,
    required this.currentAmount,
    required this.deadline,
  });
}
