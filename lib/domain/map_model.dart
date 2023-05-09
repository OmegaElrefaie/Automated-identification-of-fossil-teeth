// Map model
class MapModel {
  final String title;
  final String description;
  final double lat;
  final double long;
  final String imageUrl;

  MapModel({
    required this.title,
    required this.description,
    required this.lat,
    required this.long,
    required this.imageUrl,
  });

  // Convert Map object to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'lat': lat,
      'long': long,
      'imageUrl': imageUrl,
    };
  }

  // Create Map object from Firestore Map
  static MapModel fromMap(Map<String, dynamic> map) {
    return MapModel(
      title: map['title'],
      description: map['description'],
      lat: map['lat'],
      long: map['long'],
      imageUrl: map['imageUrl'],
    );
  }
}
