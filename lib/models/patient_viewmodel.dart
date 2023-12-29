class PatientViewModel {
  final int id;
  final String name;
  final DateTime createdAt;
  final bool assisted;

  const PatientViewModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.assisted,
  });

  factory PatientViewModel.fromJson(Map<String, dynamic> json) {
    return PatientViewModel(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      assisted: json['assisted'],
    );
  }
}
