import 'package:flutter/material.dart';
import 'package:gestion_inventario/models/product_model.dart';
import 'package:gestion_inventario/services/product_service.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ProductService _productService = ProductService();

  ProductCard({Key? key, required this.product}) : super(key: key);

  // Método para recortar la descripción
  String getShortDescription(String description, {int maxLength =60}) {
    return description.length > maxLength
        ? '${description.substring(0, maxLength)}...'
        : description;
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirmar eliminación"),
          content: const Text("¿Estás seguro de que deseas eliminar este producto?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
                try {
                  await _productService.deleteProduct(product.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Producto eliminado correctamente")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error al eliminar el producto: $e")),
                  );
                }
              },
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Navega a los detalles del producto
          Navigator.pushNamed(context, '/productDetails', arguments: product);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Información del producto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      getShortDescription(product.description), // Muestra la descripción recortada
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Stock: ${product.stock} unidades',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${product.price.toStringAsFixed(2)}€',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // Botones para editar y eliminar
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 28.0),
                    onPressed: () {
                      Navigator.pushNamed(context, '/UpdateProduct', arguments: product);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 28.0),
                    onPressed: () => _confirmDelete(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}