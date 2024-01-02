class PatientViewModel {
  final int id;
  final String name;
  final DateTime? createdAt;
  final bool assisted;
  final DateTime? updatedAt;

  const PatientViewModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.assisted,
    required this.updatedAt,
  });

  factory PatientViewModel.fromJson(Map<String, dynamic> json) {
    return PatientViewModel(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        assisted: json['assisted'],
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null);
  }
}
