 
import 'package:cloud_firestore/cloud_firestore.dart'; 

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<double>> getTaxValues() async {
    try {
      final parameterDocument =
          await _firestore.collection('parametros').doc('taxes').get();
      final List<double> taxes = [];

      if (parameterDocument.exists) {
        final t = parameterDocument.data() as Map;
        t.entries.forEach((element) {
          taxes.add(double.parse(element.value));
        });
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
