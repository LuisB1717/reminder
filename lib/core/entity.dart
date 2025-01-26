class Entity {
  final String id;
  final String name;
  final String? town;
  final DateTime date;
  final String address;
  final String? district;
  final String? phone;

  Entity({
    required this.id,
    required this.name,
    required this.date,
    required this.address,
    this.town,
    this.district,
    this.phone,
  });

  factory Entity.from(Map<String, dynamic> json) {
    final id = json['id'].toString();
    final name = json['name'];
    final town = json['town'] is Map ? json['town']['name'] : json['town'];
    final date = DateTime.tryParse(json['date']);
    final address = json['address'];
    final district =
        json['district'] is Map ? json['district']['name'] : json['district'];
    final phone = json['phone'];

    return Entity(
      id: id,
      name: name,
      town: town,
      date: date ?? DateTime.now(),
      address: address,
      district: district,
      phone: phone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'town': town,
      'date': date.toIso8601String(),
      'address': address,
      'department': '13',
      'province': '1304',
      'district': district,
      'phone': phone,
    };
  }
}
