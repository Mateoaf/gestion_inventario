import 'package:flutter/material.dart';
import 'package:gestion_inventario/services/product_service.dart';
import 'package:gestion_inventario/widgets/header.dart';

// Define el widget de pantalla para agregar productos
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ProductService _productService = ProductService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Variables para categorías
  String _selectedCategory = 'Smartphone'; // Valor por defecto
  final List<String> _categories = ['Smartphone', 'Tablet', 'Ordenador']; // Opciones

  // Función para agregar producto
  void _addProduct() async {
    if (_nameController.text.isEmpty || _selectedCategory.isEmpty || _stockController.text.isEmpty || _priceController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Todos los campos son obligatorios")),
      );
      return;
    }

    try {
      await _productService.addProduct({
        'name': _nameController.text,
        'description': _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : 'Sin descripción', // Valor por defecto
        'stock': int.tryParse(_stockController.text) ?? 0,
        'price': double.tryParse(_priceController.text) ?? 0.0,
        'category': _selectedCategory,
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Producto agregado correctamente")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al agregar el producto: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Se utiliza CustomScrollView para mantener una UI consistente
      body: CustomScrollView(
        slivers: [
          const Header(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Campo para ingresar el nombre
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre del producto', 
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0) 
                      ), 
                      
                      ),
                  ),
                  const SizedBox(height: 20),
                  // Campo para ingresar la descripción
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0) 
                      ), 

                      ),
                  ),
                  const SizedBox(height: 20),
                  // Dropdown para seleccionar la categoría
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
                        _selectedCategory = newValue ?? 'Smartphone';
                      });
                    },
                    isExpanded: true,
                    hint: const Text("Selecciona una categoría"),
                  ),
                  const SizedBox(height: 20),
                  // Campo para la cantidad en stock
                  TextField(
                    controller: _stockController,
                    decoration: InputDecoration(
                      labelText: 'Cantidad en stock',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0) 
                      ), 
                      ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  // Campo para el precio
                  TextField(
                    controller: _priceController,
                    decoration:  InputDecoration(
                      labelText: 'Precio',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0) 
                      ), 
                      ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  // Botones de Cancelar y Agregar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _addProduct,
                        child: const Text('Agregar'),
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