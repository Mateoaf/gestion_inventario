import 'package:cloud_firestore/cloud_firestore.dart';

/// Servicio para eliminar artículos de Firebase
class DeleteService {
  /// Elimina un artículo de la colección "articulos" en Firestore
  Future<void> deleteItem(String id) async {
    try {
      await FirebaseFirestore.instance.collection('articulos').doc(id).delete();
    } catch (e) {
      print("Error al eliminar el artículo: $e");
    }
  }
}
