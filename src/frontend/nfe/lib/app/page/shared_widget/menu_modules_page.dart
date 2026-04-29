import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuModulesPage extends StatelessWidget {
  const MenuModulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('T2Ti ERP - Módulos'),
          actions: [
          IconButton(
              tooltip: 'button_exit'.tr,                
              icon: iconButtonCancel(),
              onPressed: () { 
                Navigator.of(Get.context!).pop();
              },
            ),
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: Session.modulosBlocos.keys.length,
          itemBuilder: (BuildContext context, int sectionIndex) {
            String sectionTitle = Session.modulosBlocos.keys.elementAt(sectionIndex);
            List<String> modules = Session.modulosBlocos[sectionTitle]!;
            List<String> urls = Session.modulosLinks[sectionTitle]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    width: double.infinity,
                    height: 28,
                    color: Colors.black12,
                   child: Text(
                    sectionTitle,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (MediaQuery.of(context).size.width ~/ 150).toInt(),
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: modules.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ModuleButton(
                      title: modules[index],
                      link: urls[index],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ModuleButton extends StatelessWidget {
  final String title;
  final String link;

  const ModuleButton({super.key, required this.title, required this.link});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onPressed: () {
        if (link == "message") {
          showInfoSnackBar(message: "Adquira o módulo para ter acesso às suas funcionalidades");
        } else {
          launchUrl(Uri.parse(link));
        }
      },
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: FutureBuilder<String>(
          future: _getImagePath(title),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Container(
                alignment: Alignment.center,
                child: const Icon(Icons.error),
              );
            } else {
              return Ink(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(snapshot.data!),
                    fit: BoxFit.cover,
                    opacity: 0.3,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black45,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<String> _getImagePath(String moduleName) async {
    moduleName = moduleName.replaceAll(' ', '_');
    final imagePath = "assets/images/menu/$moduleName.jpg";
    try {
      await rootBundle.load(imagePath);
      return imagePath;
    } catch (_) {
      return "assets/images/profile.png";
    }
  }
}