import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalModuleLink extends StatelessWidget {
  const GlobalModuleLink({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Navega para a página de módulos que já existe em cada app
        Get.toNamed('/menuModulesPage');
      },
      title: const Text(
        'Módulos do Sistema',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.blue),
      ),
      leading: const Icon(
        Icons.grid_view,
        color: Colors.blue,
      ),
    );
  }
}
