class Town {
  int id;
  String? name;

  Town({
    required this.id,
    this.name,
  });

  factory Town.from(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    return Town(
      id: id,
      name: name ?? '',
    );
  }

  @override
  String toString() {
    if (name == null) return '';
    return name!;
  }
}
