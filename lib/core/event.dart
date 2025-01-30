class Event {
  final String? id;
  final DateTime date;
  final String? type;
  final String? recurrence;
  final Map<String, dynamic>? entity;

  Event({
    this.id,
    required this.date,
    this.type,
    this.recurrence,
    this.entity,
  });

  factory Event.from(Map<String, dynamic> json) {
    final id = json['id'].toString();
    final date = DateTime.tryParse(json['date']);
    final type = json['type'];
    final entity = json['entity'] != null
        ? {
            'name': json['entity']['name'] ?? '',
            'address': json['entity']['address'] ?? '',
          }
        : null;

    return Event(
      id: id,
      date: date ?? DateTime.now(),
      type: type,
      entity: entity,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'type': type,
        'recurrence': 'annual',
      };
}
