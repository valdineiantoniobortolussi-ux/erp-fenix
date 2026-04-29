import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:estoque/app/controller/theme_controller.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/page/shared_widget/message_dialog.dart';
import 'package:estoque/app/routes/app_routes.dart';

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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'estoque_cor') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'estoque_cor') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.estoqueCorListPage);
						},
						title: const Text(
							'Cores',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'estoque_tamanho') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'estoque_tamanho') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.estoqueTamanhoListPage);
						},
						title: const Text(
							'Tamanhos',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'estoque_sabor') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'estoque_sabor') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.estoqueSaborListPage);
						},
						title: const Text(
							'Sabores',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'estoque_marca') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'estoque_marca') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.estoqueMarcaListPage);
						},
						title: const Text(
							'Marcas',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'estoque_grade') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'estoque_grade') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.estoqueGradeListPage);
						},
						title: const Text(
							'Grade de Estoque',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'requisicao_interna_cabecalho') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'requisicao_interna_cabecalho') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.requisicaoInternaCabecalhoListPage);
						},
						title: const Text(
							'Requisicao Interna',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'estoque_reajuste_cabecalho') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'estoque_reajuste_cabecalho') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.estoqueReajusteCabecalhoListPage);
						},
						title: const Text(
							'Reajuste de Preços',
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
