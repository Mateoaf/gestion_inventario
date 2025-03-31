import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_inventario/firebase_options.dart';
import 'package:gestion_inventario/screens/home/home_screen.dart';
import 'package:gestion_inventario/screens/products/product_details_screen.dart';
import 'screens/auth/login_screen.dart'; // importa el nuevo archivo

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
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/profile',
      routes: {
        '/sign-in': (context) => const LoginScreen(),
        '/profile': (context) => const ProfileScreenWrapper(),
        '/home': (context) => const HomeScreen(), //
        '/productDetails': (context) => ProductoPage(),
      },
    );
  }
}
