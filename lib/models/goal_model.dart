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

  // Convert Goal to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'targetAmount': targetAmount,
        'currentAmount': currentAmount,
        'deadline': deadline.toIso8601String(),
      };

  // Create Goal from JSON
  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
        id: json['id'],
        title: json['title'],
        targetAmount: json['targetAmount'],
        currentAmount: json['currentAmount'],
        deadline: DateTime.parse(json['deadline']),
      );
}
