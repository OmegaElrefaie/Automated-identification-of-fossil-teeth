import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/map_model.dart';

// Map repository
MapRepository factRepo = MapRepository.instance;

class MapRepository {
  static final MapRepository _instance = MapRepository._internal();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  factory MapRepository() {
    return _instance;
  }

  MapRepository._internal();

  Stream<List<MapModel>> getMaps() {
    return _db.collection('Maps').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => MapModel.fromMap(doc.data())).toList());
  }

  Future<void> addMap(MapModel map) {
    return _db.collection('Maps').add(map.toMap());
  }

  // Future<void> updateMap(MapModel map) {
  //   return _db
  //       .collection('Maps')
  //       .doc(map.id)
  //       .update(map.toMap());
  // }

  Future<void> deleteMap(String id) {
    return _db.collection('Maps').doc(id).delete();
  }

  // Add the instance getter here
  static MapRepository get instance => _instance;
}
