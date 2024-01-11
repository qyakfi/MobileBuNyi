import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bunyicake/constant/firestore_constants.dart';

class KatProvider {
  final FirebaseFirestore firebaseFirestore;

  KatProvider({required this.firebaseFirestore});

  Future<void> updateProdFirestore(String collectionPath, String path, Map<String, String> dataNeedUpdate) {
    return firebaseFirestore.collection(collectionPath).doc(path).update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getProdStreamFireStore(String pathCollection, int limit, String? textSearch) {
    if (textSearch?.isNotEmpty == true) {
      return firebaseFirestore
          .collection(pathCollection)
          .limit(limit)
          .where(FirestoreConstants.nama, isEqualTo: textSearch)
          .snapshots();
    } else {
      return firebaseFirestore.collection(pathCollection).limit(limit).snapshots();
    }
  }
}