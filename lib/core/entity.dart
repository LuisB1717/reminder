class Entity {
  final String id;
  final String name;
  final int? town;
  final DateTime date;
  final String address;

  Entity({
    required this.id,
    required this.name,
    required this.date,
    required this.address,
    this.town,
  });

  factory Entity.from(Map<String, dynamic> json) {
    final id = json['id'].toString();
    final name = json['name'];
    final town = json['town'];
    final date = DateTime.tryParse(json['date']);
    final address = json['address'];

    return Entity(
      id: id,
      name: name,
      town: town,
      date: date ?? DateTime.now(),
      address: address,
    );
  }
}
