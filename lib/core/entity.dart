class Entity {
  final String id;
  final String name;
  final String town;
  final DateTime date;

  Entity({
    required this.id,
    required this.name,
    required this.town,
    required this.date,
  });

  factory Entity.from(Map<String, dynamic> json) {
    return Entity(
      id: json['id'],
      name: json['name'],
      town: json['town'],
      date: DateTime.parse(json['date']),
    );
  }
}
