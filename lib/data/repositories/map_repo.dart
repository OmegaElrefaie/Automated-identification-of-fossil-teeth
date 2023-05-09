import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/map_model.dart';

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

  Future<String> addMap(MapModel map) async {
    final docRef = _db.collection('Maps').doc();
    await docRef.set(map.toMap());
    return docRef.id;
  }

  Future<void> updateMap(MapModel map) {
    final docRef = _db.collection('Maps').doc();

    return _db.collection('Maps').doc(docRef.id.toString()).update(map.toMap());
  }

  Future<void> deleteMap(String id) {
    return _db.collection('Maps').doc(id).delete();
  }

  static MapRepository get instance => _instance;
}
