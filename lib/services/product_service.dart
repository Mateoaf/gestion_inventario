import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_inventario/models/product_model.dart';

class ProductService {
  final CollectionReference productosCollection =
      FirebaseFirestore.instance.collection('productos');

  // Método para obtener productos
  /*Stream<List<Product>> getProducts() {
    return productosCollection.snapshots().map((querySnapshot) {
      try {
        final products = querySnapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
        print('Productos recuperados: ${products.length}');
        return products;
      } catch (e) {
        print('Error al mapear los productos: $e');
        return [];
      }
    });
  }*/

  Stream<List<Product>> getProducts() {
    return productosCollection.snapshots().map((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print('Documento recuperado: ${doc.data()}'); // Imprime el contenido del documento
      }
      return querySnapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
    });
  }

  // Agrega un producto a la colección
  Future<void> addProduct(Map<String, dynamic> data) async {
    await productosCollection.add(data);
  }
  // Actualiza un producto a partir del ID de documento
  Future<void> updateProduct(String id, Map<String, dynamic> data) {
    return productosCollection.doc(id).update(data);
  }
    // Método para eliminar un producto.
  Future<void> deleteProduct(String id) async {
    await productosCollection.doc(id).delete();
  }
}
