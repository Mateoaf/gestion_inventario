import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';  // Importa el tema centralizado
import 'package:gestion_inventario/core/app_theme.dart';
import 'package:gestion_inventario/firebase_options.dart';
import 'package:gestion_inventario/models/product_model.dart';
import 'package:gestion_inventario/screens/home/home_screen.dart';
import 'package:gestion_inventario/screens/products/add_product_screen.dart';
import 'package:gestion_inventario/screens/products/product_detail_screen.dart';
import 'package:gestion_inventario/screens/products/update_product.dart';
import 'package:gestion_inventario/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme( selectedColor: 1).theme(),
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/home',
      routes: {
        '/sign-in': (context) => const LoginScreen(),
        '/profile': (context) => const ProfileScreenWrapper(),
        '/home': (context) => const HomeScreen(),
        '/productDetails': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args == null || args is! Product) {
            return Scaffold(
              appBar: AppBar(title: const Text("Error")),
              body: const Center(child: Text("No se recibió un producto válido.")),
            );
          }
          return ProductDetailScreen(product: args);
        },
        '/AddProduct': (context) => const AddProductScreen(),
        '/UpdateProduct': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args == null || args is! Product) {
            return Scaffold(
              appBar: AppBar(title: const Text("Error")),
              body: const Center(child: Text("No se recibió un producto válido.")),
            );
          }
          return UpdateProductScreen(product: args);
        },
      },
    );
  }
}