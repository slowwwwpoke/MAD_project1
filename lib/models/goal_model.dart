class GoalModel {
  final int id;
  final String title;
  final double targetAmount;
  double currentAmount;
  final DateTime deadline;
  bool isCompleted;

  GoalModel({
    required this.id,
    required this.title,
    required this.targetAmount,
    required this.currentAmount,
    required this.deadline,
    this.isCompleted = false,
  });

  // Convert GoalModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'deadline': deadline.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  // Create GoalModel from JSON
  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'],
      title: json['title'],
      targetAmount: json['targetAmount'],
      currentAmount: json['currentAmount'],
      deadline: DateTime.parse(json['deadline']),
      isCompleted: json['isCompleted'],
    );
  }
}
