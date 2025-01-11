class Event {
  final String id;
  final DateTime date;

  Event({
    required this.id,
    required this.date,
  });

  factory Event.from(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      date: DateTime.parse(json['date']),
    );
  }
}
