class District {
  final String id;
  final String? name;

  District({
    required this.id,
    this.name,
  });

  factory District.from(Map<String, dynamic> json) {
    final id = json['id'].toString();
    final name = json['name'].toString();

    return District(
      id: id,
      name: name,
    );
  }

  @override
  String toString() {
    if (name == null) return '';
    return name!;
  }
}
