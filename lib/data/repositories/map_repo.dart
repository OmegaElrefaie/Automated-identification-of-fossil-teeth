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

  // Future<String> addMap(MapModel map) async {
  //   final docRef = _db.collection('Maps').doc();
  //   await docRef.set(map.toMap());
  //   return docRef.id;

  // }
  Future<String> addMap(MapModel map) async {
    final docRef = _db.collection('Maps').doc();
    try {
      await docRef.set(map.toMap());
      return docRef.id;
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'permission-denied':
          throw 'Error: You do not have permission to add a new map';
        case 'invalid-argument':
          throw 'Error: Invalid argument provided for adding new map';
        default:
          throw 'Error: Failed to add new map. Please try again later';
      }
    } catch (e) {
      throw 'Error: Failed to add new map. Please try again later';
    }
  }

  Future<void> deleteMap(String id) {
    return _db.collection('Maps').doc(id).delete();
  }

  static MapRepository get instance => _instance;
}
