import 'package:flutter/material.dart';
import 'package:gestion_inventario/models/product_model.dart';
import 'package:gestion_inventario/services/product_service.dart';
import 'package:gestion_inventario/widgets/header.dart';
import 'package:gestion_inventario/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ProductService _productService = ProductService();

  // Incluimos la opción 'Todos' para deshabilitar el filtro por categoría.
  final List<String> _categories = ['Todos', 'Smartphone', 'Tablet', 'Ordenador'];
  String _selectedCategory = 'Todos';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const Header(),
          // Barra de búsqueda y filtro por categoría
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Campo de búsqueda
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Buscar',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {}); // Actualiza la lista mientras se escribe
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Dropdown para filtrar por categoría
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
                        _selectedCategory = newValue ?? 'Todos';
                      });
                    },
                    isExpanded: false,
                    hint: const Text("Categoría"),
                  ),
                ],
              ),
            ),
          ),
          // StreamBuilder para mostrar productos desde Firebase
          SliverToBoxAdapter(
            child: StreamBuilder<List<Product>>(
              stream: _productService.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar los productos'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                // Obtiene la lista de productos
                List<Product> products = snapshot.data!;
                // Filtrado por nombre (barra de búsqueda)
                final query = _searchController.text.toLowerCase();
                if (query.isNotEmpty) {
                  products = products
                      .where((product) => product.name.toLowerCase().contains(query))
                      .toList();
                }
                // Filtrado por categoría usando el campo correcto
                if (_selectedCategory != 'Todos') {
                  products = products
                      .where((product) => product.category.toLowerCase() ==
                          _selectedCategory.toLowerCase())
                      .toList();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      // Botón flotante para agregar productos
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/AddProduct'); // Navega a la pantalla de agregar producto
        },
        child: const Icon(Icons.add), // Ícono del botón flotante
        backgroundColor: const Color.fromARGB(255, 179, 213, 241), // Color personalizado
      ),
    );
  }
}