import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:administrativo/app/controller/theme_controller.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/page/shared_widget/message_dialog.dart';
import 'package:administrativo/app/routes/app_routes.dart';

class MainSideDrawer extends StatelessWidget {
	MainSideDrawer({Key? key}) : super(key: key);

	final themeController = Get.find<ThemeController>();

	@override
	Widget build(BuildContext context) {
		return Drawer(
			child: ListView(
				padding: EdgeInsets.zero,
				children: <Widget>[
					UserAccountsDrawerHeader(
						accountName: Text(Session.loggedInUser.pessoaNome ?? 'name'.tr,),
						accountEmail: Text(Session.loggedInUser.email ?? 'Email',),
						currentAccountPicture: MouseRegion(
							cursor: SystemMouseCursors.click,
							child: GestureDetector(
								onTap: (() {
									showInfoSnackBar(message: 'drawer_message_change_image_profile'.tr);
								}),
								child: const CircleAvatar(
									backgroundImage: AssetImage(Constants.profileImage),
								),
							),
						),
					),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              'drawer_single_page'.tr,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0),
            ),
          ),

					ListTile(
						enabled: Session.loggedInUser.administrador == 'S'
							? true
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'auditoria') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'auditoria') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.auditoriaListPage);
						},
						title: const Text(
							'Auditoria',
							style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
						),
						leading: Icon(
							iconDataList[Random().nextInt(10)],
							color: iconColorList[Random().nextInt(10)],
						),
					),

					ListTile(
						enabled: Session.loggedInUser.administrador == 'S'
							? true
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'funcao') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'funcao') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.funcaoListPage);
						},
						title: const Text(
							'Função',
							style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
						),
						leading: Icon(
							iconDataList[Random().nextInt(10)],
							color: iconColorList[Random().nextInt(10)],
						),
					),

					ListTile(
						enabled: Session.loggedInUser.administrador == 'S'
							? true
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'usuario') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'usuario') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.usuarioListPage);
						},
						title: const Text(
							'Usuário',
							style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
						),
						leading: Icon(
							iconDataList[Random().nextInt(10)],
							color: iconColorList[Random().nextInt(10)],
						),
					),

					
					const Divider(),		 

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              'drawer_master_page'.tr,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0),
            ),
          ),

					ListTile(
						enabled: Session.loggedInUser.administrador == 'S'
							? true
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'papel') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'papel') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.papelListPage);
						},
						title: const Text(
							'Papel',
							style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
						),
						leading: Icon(
							iconDataList[Random().nextInt(10)],
							color: iconColorList[Random().nextInt(10)],
						),
					),

					ListTile(
						enabled: Session.loggedInUser.administrador == 'S'
							? true
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'empresa') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'empresa') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.empresaListPage);
						},
						title: const Text(
							'Empresa',
							style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
						),
						leading: Icon(
							iconDataList[Random().nextInt(10)],
							color: iconColorList[Random().nextInt(10)],
						),
					),

										
					const Divider(),        

					ListTile(
							onTap: () {
									Get.offAllNamed('/loginPage');
							},
							title: Text(
									"button_exit".tr,
									style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
							),
							leading: const Icon(
									Icons.exit_to_app,
									color: Colors.red,
							),
					), 
				],
			),
		);
	}
}
