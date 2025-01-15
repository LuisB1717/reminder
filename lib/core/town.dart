class Town {
  int id;
  String name;

  Town({
    required this.id,
    required this.name,
  });

  factory Town.from(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'].toString();
    return Town(
      id: id,
      name: name,
    );
  }
  @override
  String toString() {
    return name;
  }
}
