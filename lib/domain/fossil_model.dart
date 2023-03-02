class Fossil {
  final String? id;
  final String? name;
  final String? imageUrl;

  Fossil({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Fossil.fromMap(Map<String, dynamic> json) => Fossil(
        id: json['id'],
        name: json['name'],
        imageUrl: json['imageurl'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageurl': imageUrl,
    };
  }

  @override
  String toString() {
    return 'Fossil{id:$id, name: $name, imageUrl: $imageUrl,}';
  }
}
