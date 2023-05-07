class FoosilMap {
  final String title;
  final String description;
  final double lat;
  final double long;
  final String imageUrl;

  FoosilMap({
    required this.title,
    required this.description,
    required this.lat,
    required this.long,
    required this.imageUrl,
  });

  factory FoosilMap.fromJson(Map<String, dynamic> json) {
    return FoosilMap(
      title: json['title'] as String,
      description: json['description'] as String,
      lat: json['Lat'] as double,
      long: json['Long'] as double,
      imageUrl: json['imageurl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'Lat': lat,
      'Long': long,
      'imageurl': imageUrl,
    };
  }
}
