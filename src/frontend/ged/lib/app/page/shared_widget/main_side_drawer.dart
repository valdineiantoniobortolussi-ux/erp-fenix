import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:ged/app/controller/theme_controller.dart';
import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/page/shared_widget/message_dialog.dart';
import 'package:ged/app/routes/app_routes.dart';

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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'ged_tipo_documento') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'ged_tipo_documento') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.gedTipoDocumentoListPage);
						},
						title: const Text(
							'Tipo Documento',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'ged_versao_documento') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'ged_versao_documento') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.gedVersaoDocumentoListPage);
						},
						title: const Text(
							'Versionamento',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'ged_documento_cabecalho') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'ged_documento_cabecalho') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.gedDocumentoCabecalhoListPage);
						},
						title: const Text(
							'Documento',
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
