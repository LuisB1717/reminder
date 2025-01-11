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
    final id = json['id'].toString();
    final name = json['name'];
    final town = json['town'];
    final date = DateTime.tryParse(json['date']);

    return Entity(
      id: id,
      name: name,
      town: town,
      date: date ?? DateTime.now(),
    );
  }
}
