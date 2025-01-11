class Event {
  final String id;
  final DateTime date;

  Event({
    required this.id,
    required this.date,
  });

  factory Event.from(Map<String, dynamic> json) {
    final id = json['id'].toString();
    final date = DateTime.tryParse(json['date']);

    return Event(
      id: id,
      date: date ?? DateTime.now(), // change this logic to make date required
    );
  }
}
