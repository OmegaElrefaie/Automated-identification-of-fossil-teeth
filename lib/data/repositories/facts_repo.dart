import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/domain/facts_model.dart';

Stream<List<Facts>> fetchFacts() {
  return FirebaseFirestore.instance
      .collection('facts')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Facts(
                text: doc['title'],
                image: doc['image'],
              ))
          .toList());
}
