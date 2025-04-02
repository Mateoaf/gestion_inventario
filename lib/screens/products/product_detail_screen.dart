import 'package:flutter/material.dart';
import 'package:gestion_inventario/models/product_model.dart';
import 'package:gestion_inventario/widgets/header.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const Header(), // Cabecera personalizada
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductInfo(), // Información del producto
                  const SizedBox(height: 36),
                  _buildActionButtons(context), // Botones "Volver" y "Editar" con la misma estética
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para mostrar la información del producto
  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          'Precio: ${product.price.toStringAsFixed(2)}€',
          style: const TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          'Stock: ${product.stock} unidades',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 24),
        const Text(
          'Descripción',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  //Creacion de botones
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context), // Acción de "Volver"
          child: const Text('Volver'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/UpdateProduct',
              arguments: product, // Pasar el producto como argumento
            );
          }, // Acción de "Editar"
          child: const Text('Editar'),
        ),
      ],
    );
  }
}