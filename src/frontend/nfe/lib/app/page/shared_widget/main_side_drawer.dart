import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:nfe/app/controller/theme_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';
import 'package:nfe/app/routes/app_routes.dart';

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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_duplicata') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_duplicata') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.nfeDuplicataListPage);
						},
						title: const Text(
							'Duplicata',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_importacao_detalhe') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_importacao_detalhe') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.nfeImportacaoDetalheListPage);
						},
						title: const Text(
							'Importação Detalhe',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_cana_fornecimento_diario') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_cana_fornecimento_diario') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.nfeCanaFornecimentoDiarioListPage);
						},
						title: const Text(
							'',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_cana_deducoes_safra') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_cana_deducoes_safra') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.nfeCanaDeducoesSafraListPage);
						},
						title: const Text(
							'',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_transporte_reboque') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_transporte_reboque') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.nfeTransporteReboqueListPage);
						},
						title: const Text(
							'',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_transporte_volume') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_transporte_volume') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.nfeTransporteVolumeListPage);
						},
						title: const Text(
							'Nfe Transporte Volume',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_transporte_volume_lacre') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_transporte_volume_lacre') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.nfeTransporteVolumeLacreListPage);
						},
						title: const Text(
							'',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_configuracao') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_configuracao') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.nfeConfiguracaoListPage);
						},
						title: const Text(
							'Configurações da NF-e',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_numero_inutilizado') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_numero_inutilizado') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.nfeNumeroInutilizadoListPage);
						},
						title: const Text(
							'Números Inutilizados',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_cabecalho') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_cabecalho') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.nfeCabecalhoListPage);
						},
						title: const Text(
							'NF-e',
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
								: Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_detalhe') ).toList().isNotEmpty
									? Session.accessControlList.where( ((t) => t.funcaoNome == 'nfe_detalhe') ).toList()[0].habilitado == 'S'
									: false,
						onTap: () {
							Get.toNamed(Routes.nfeDetalheListPage);
						},
						title: const Text(
							'Itens da Nota',
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
