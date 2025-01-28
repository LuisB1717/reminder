class Event {
  final String id;
  final DateTime date;
  final String? type;
  final String? entityId;

  Event({
    required this.id,
    required this.date,
    this.type,
    this.entityId,
  });

  factory Event.from(Map<String, dynamic> json) {
    final id = json['id'].toString();
    final date = DateTime.tryParse(json['date']);
    final type = json['type'];
    final entityId = json['entity_id'];

    return Event(
      id: id,
      date: date ?? DateTime.now(),
      type: type,
      entityId: entityId,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'type': type,
        'entity_id': entityId,
      };
}
