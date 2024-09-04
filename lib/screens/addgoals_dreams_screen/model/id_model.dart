class GoalModelIdName {
  final String id;
  final String name;

  GoalModelIdName({
    required this.id,
    required this.name,
  });

  factory GoalModelIdName.fromJson(Map<String, dynamic> json) {
    return GoalModelIdName(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
