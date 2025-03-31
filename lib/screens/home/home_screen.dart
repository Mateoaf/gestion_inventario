import 'package:flutter/material.dart';
import 'package:gestion_inventario/models/product.dart';
import 'package:gestion_inventario/widgets/header.dart';
import 'package:gestion_inventario/widgets/product_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> filteredProducts = [];

  final List<Product> products = [
    Product(
      name: 'Iphone 16',
      description: '256Gb, chip A18, OLED 6.1 pulgadas',
      stock: 23,
      price: 677.0,
    ),
    Product(
      name: 'Samsung Galaxy S45',
      description: '256Gb, Qualcomm SM8650, OLED 6.4 pulgadas',
      stock: 29,
      price: 723.0,
    ),
    Product(
      name: 'Xiaomi MI 33',
      description: '128Gb, Qualcomm SM8750, QLED 5.8 pulgadas',
      stock: 15,
      price: 589.0,
    ),
    Product(
      name: 'Iphone 16',
      description: '256Gb, chip A18, OLED 6.1 pulgadas',
      stock: 23,
      price: 677.0,
    ),
    Product(
      name: 'Samsung Galaxy S45',
      description: '256Gb, Qualcomm SM8650, OLED 6.4 pulgadas',
      stock: 29,
      price: 723.0,
    ),
    Product(
      name: 'Xiaomi MI 33',
      description: '128Gb, Qualcomm SM8750, QLED 5.8 pulgadas',
      stock: 15,
      price: 589.0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
    _searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      filteredProducts = products.where((product) {
        return product.name.toLowerCase().contains(query) ||
               product.description.toLowerCase().contains(query);
      }).toList();
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: CustomScrollView(
      slivers: [
        const Header(),  //Encabezado
        
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
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
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.add_circle_outline_outlined),
                  color: const Color.fromARGB(152, 0, 0, 0),
                  iconSize: 40,
                  onPressed: () {
                    //Navigator.pushNamed(context, '/productDetails');
                  },
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ProductCard(product: filteredProducts[index]);
            },
            childCount: filteredProducts.length,
          ),
        ),
      ],
    ),
  );
}


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
