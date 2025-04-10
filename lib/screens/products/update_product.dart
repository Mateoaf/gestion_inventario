import 'package:flutter/material.dart';
import 'package:gestion_inventario/models/product_model.dart';
import 'package:gestion_inventario/services/product_service.dart';
import 'package:gestion_inventario/widgets/header.dart';

class UpdateProductScreen extends StatefulWidget {
  final Product product; // Recibe el producto a editar

  const UpdateProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final ProductService _productService = ProductService();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _stockController;
  late TextEditingController _priceController;

  // Declaración de la variable para la categoría y la lista de categorías.
  late String _selectedCategory;
  final List<String> _categories = ['Smartphone', 'Tablet', 'Ordenador'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController = TextEditingController(text: widget.product.description);
    _stockController = TextEditingController(text: widget.product.stock.toString());
    _priceController = TextEditingController(text: widget.product.price.toString());
    _selectedCategory = widget.product.category;  // Inicializa _selectedCategory con la categoría del producto.
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveProduct() async {
    try {
      await _productService.updateProduct(widget.product.id, {
        'name': _nameController.text,
        'description': _descriptionController.text,
        'stock': int.tryParse(_stockController.text) ?? widget.product.stock,
        'price': double.tryParse(_priceController.text) ?? widget.product.price,
        'category': _selectedCategory, // Se utiliza la categoría seleccionada.
      });
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al actualizar el producto")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const Header(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre de artículo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0) 
                      ), 
                      ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _descriptionController,
                    decoration:  InputDecoration(
                      labelText: 'Descripción',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0) 
                      ), 
                      ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _stockController,
                    decoration: InputDecoration(
                      labelText: 'Cantidad de stock',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0) 
                      ), 
                      ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Precio',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0) 
                      ), 
                      ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  // Dropdown para seleccionar la categoría.
                  DropdownButton<String>(
                    value: _selectedCategory,
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue ?? _selectedCategory;
                      });
                    },
                    isExpanded: true,
                    hint: const Text("Selecciona una categoría"),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _saveProduct,
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}