
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, double>>> getTaxValues() async {
    try {
      final querySnap = await _firestore.collection('taxes').get();
      final List<Map<String, double>> taxes = [];

      if (querySnap.docs.isNotEmpty) {
        for (var doc in querySnap.docs) {
          var tax = doc.data();
          tax.forEach((key, value) {
            if (value == true) {
              taxes.add({doc.id: double.parse(tax.values.first)});
            }  
          });
        } 
        return taxes;
      } else {
        return List.empty();
      }
    } catch (e) {
      print(e);
      return List.empty();
    }
  }
}
