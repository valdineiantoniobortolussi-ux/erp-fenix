import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orcamentos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:orcamentos/app/controller/login_controller.dart';
import 'package:orcamentos/app/controller/theme_controller.dart';
import 'package:orcamentos/app/page/shared_widget/main_side_drawer.dart';
import 'package:orcamentos/app/infra/infra_imports.dart';

class HomePage extends GetView<LoginController> {
  HomePage({Key? key}) : super(key: key);
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                themeController.isDarkMode
                    ? themeController.changeThemeMode(ThemeMode.light)
                    : themeController.changeThemeMode(ThemeMode.dark);
              },
              icon: themeController.isDarkMode
                  ? const Icon(Icons.dark_mode_outlined)
                  : const Icon(Icons.light_mode_outlined),
            ),
          ),
        ],
      ),
      drawer: MainSideDrawer(),
      body: Obx(
        () => 
        Stack(
          children: [                  
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.1, 0.4, 0.7, 0.9],
                    colors: themeController.isDarkMode
                        ? [
                            Colors.blueGrey.shade900,
                            Colors.green.shade900,
                            Colors.grey.shade900,
                            Colors.blue.shade900,
                          ]
                        : [
                            Colors.blueGrey.shade100,
                            Colors.green,
                            Colors.grey,
                            Colors.blue.shade100,
                          ]),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.red.withOpacity(0.2), BlendMode.dstATop),
                  image: Image.asset(
                    Constants.backgroundImage,
                  ).image,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 5,
                        color: themeController.isDarkMode
                              ? const Color.fromARGB(255, 171, 211, 250).withOpacity(0.2)
                              : Colors.blue.shade100.withOpacity(0.1),
                        child: Container(
                          width: 400,
                          padding: const EdgeInsets.all(40.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                height: 300,
                                width: 300,
                                child: Image.asset(
                                  Constants.logotipo,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
        
            Positioned( // help e feedback
              top: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: FloatingActionButton(
                          heroTag: "bntHelp",
                          mini: true,
                          backgroundColor: Colors.grey,
                          splashColor: Colors.black,
                          tooltip: "Help",
                          onPressed: () {
                            launchUrl(Uri.parse("https://t2tisistemas.com/erp/modulos/orcamentos/help/"));
                          },
                          hoverElevation: 1.5,
                          elevation: 1.5,
                          child: const Icon(
                            Icons.help,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: FloatingActionButton(
                          heroTag: "bntFeedback",
                          mini: true,
                          backgroundColor: Colors.grey,
                          splashColor: Colors.black,
                          tooltip: "Feedback",
                          onPressed: () {
                            showInfoSnackBar(message: "Envie o feedback do seu usuário para o Trello.");
                          },
                          hoverElevation: 1.5,
                          elevation: 1.5,
                          child: const Icon(
                            Icons.message,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Positioned( // versão
              right: 16,
              top: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(Session.empresaComPlanoAtivo ? 'Usando banco de dados remoto' : 'Usando banco de dados local [DEMO]',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0, fontFamily: 'Courrier'),
                  ),                    
                ],
              ),
            ),
                      
            Positioned( // module buttons
              right: 20,
              bottom: 20,
              child: Row(
                children: [
                  FloatingActionButton(
                    heroTag: "btn7",
                    mini: false,
                    backgroundColor: Colors.blue.shade900,
                    splashColor: Colors.black,
                    tooltip: "Módulos do ERP",
                    onPressed: () {
                      Get.dialog(
                        const AlertDialog(
                          content: MenuModulesPage(),
                        )
                      ); 
                    },
                    hoverElevation: 1.5,
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.blue, width: 4)
                    ),
                    elevation: 1.5,
                    child: const Icon(
                      Icons.screen_share_outlined,
                      size: 35,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              )
            ),

          ],
        ),
      ),
    );
  }
}
