import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:comissoes/app/page/shared_widget/shared_widget_imports.dart';
import 'package:comissoes/app/controller/comissao_perfil_controller.dart';
import 'package:comissoes/app/infra/infra_imports.dart';
import 'package:comissoes/app/page/shared_widget/input/input_imports.dart';

class ComissaoPerfilEditPage extends StatelessWidget {
	ComissaoPerfilEditPage({Key? key}) : super(key: key);
	final comissaoPerfilController = Get.find<ComissaoPerfilController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					comissaoPerfilController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: comissaoPerfilController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Perfis - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: comissaoPerfilController.save),
						cancelAndExitButton(onPressed: comissaoPerfilController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: comissaoPerfilController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: comissaoPerfilController.scrollController,
							child: SingleChildScrollView(
								controller: comissaoPerfilController.scrollController,
								child: BootstrapContainer(
									fluid: true,
									padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
									children: <Widget>[
										const Divider(
											color: Colors.transparent,
										),
										BootstrapRow(
											height: 60,
											children: <BootstrapCol>[
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 3,
															controller: comissaoPerfilController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																comissaoPerfilController.comissaoPerfilModel.codigo = text;
																comissaoPerfilController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-9',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: comissaoPerfilController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																comissaoPerfilController.comissaoPerfilModel.nome = text;
																comissaoPerfilController.formWasChanged = true;
															},
														),
													),
												),
											],
										),
										const Divider(
											indent: 10,
											endIndent: 10,
											thickness: 2,
										),
										BootstrapRow(
											height: 60,
											children: <BootstrapCol>[
												BootstrapCol(
													sizes: 'col-12',
													child: Text(
														'field_is_mandatory'.tr,
														style: Theme.of(context).textTheme.bodySmall,
													),
												),
											],
										),
										const SizedBox(height: 10.0),
									],
								),
							),
						),
					),
				),
			),
		);
	}
}
