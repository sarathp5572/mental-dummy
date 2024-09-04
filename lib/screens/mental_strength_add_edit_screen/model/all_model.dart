class AllModel {
  final String id;
  final String value;
  final bool? already;

  AllModel({
    required this.id,
    required this.value,
    this.already,
  });

  // Factory method to create AllModel instance from a map
  factory AllModel.fromJson(Map<String, dynamic> json) {
    return AllModel(
      id: json['id'] as String,
      value: json['value'] as String,
      already: json['already'] as bool,
    );
  }

  // Convert AllModel instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'already': already,
    };
  }
}
