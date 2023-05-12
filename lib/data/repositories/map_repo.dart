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
    final docRef = _db
        .collection('Maps')
        .doc(); //returns a refrence to the new document created with unique id.
    await docRef.set(map
        .toMap()); //an object from MapModel is being converted using toMap to store on firestore.
    return docRef.id;
  }

  Future<void> deleteMap(String id) {
    return _db.collection('Maps').doc(id).delete();
  }

  static MapRepository get instance => _instance;
}
