import 'package:flutter/material.dart';
import 'package:gestion_inventario/models/product.dart';


class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/productDetails');
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
                    Text(  //Nombre del producto
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(product.description),  //Descripción del producto
                    const SizedBox(height: 8),
                    Text(  //Stock del producto
                      'Stock: ${product.stock} unidades',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(  //Precio del producto
                      '${product.price.toStringAsFixed(2)}€',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row( //Botones de editar y borrar
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      size: 28.0,
                    ),
                    onPressed: () {
                      /*Navigator.pushNamed(
                        context,
                        '/editarProducto',
                        arguments: product,
                      );*/
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 28.0,
                    ),
                    onPressed: () {
                      /*Navigator.pushNamed(
                        context,
                        '/eliminarProducto',
                        arguments: product,
                      );*/
                    },
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
