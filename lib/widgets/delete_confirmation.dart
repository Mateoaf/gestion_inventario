import 'package:flutter/material.dart';

/// Muestra un cuadro de diálogo para confirmar la eliminación de un artículo.
void showDeleteConfirmation(BuildContext context, Function onDelete) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirmar eliminación"),
        content: Text("¿Estás seguro de que deseas eliminar este artículo?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
            },
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              onDelete(); // Ejecutar la eliminación
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Artículo eliminado correctamente")),
              );
            },
            child: Text("Sí"),
          ),
        ],
      );
    },
  );
}