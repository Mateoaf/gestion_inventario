import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color.fromARGB(255, 1, 106, 191), // Color del AppBar
      pinned: false, // El AppBar desaparecerá al hacer scroll
      floating: true, // El AppBar reaparece al desplazarte hacia arriba
      snap: true,
      centerTitle: true,
      leading: IconButton( // Añadir el ícono de perfil de usuario aquí
        icon: const Icon(
          Icons.account_circle_sharp, // Icono de usuario
          color: Colors.white,  // Color del icono
          size: 35,  //Tamaño del icono
        ),
        onPressed: () {
          //Navigator.pushNamed(context, '/perfilUsuario'); // Redirige a la página de perfil
        },
      ),
      title: const Text(  //Titulo 
        'Tienda Online',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}