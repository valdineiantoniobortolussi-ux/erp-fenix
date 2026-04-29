import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/banco_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class BancoEditPage extends StatelessWidget {
	BancoEditPage({Key? key}) : super(key: key);
	final bancoController = Get.find<BancoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					bancoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: bancoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Banco - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: bancoController.save),
						cancelAndExitButton(onPressed: bancoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: bancoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: bancoController.scrollController,
							child: SingleChildScrollView(
								controller: bancoController.scrollController,
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
															maxLength: 10,
															controller: bancoController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Código',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																bancoController.bancoModel.codigo = text;
																bancoController.formWasChanged = true;
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
															controller: bancoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																bancoController.bancoModel.nome = text;
																bancoController.formWasChanged = true;
															},
														),
													),
												),
											],
										),
										const Divider(
											color: Colors.transparent,
										),
										BootstrapRow(
											height: 60,
											children: <BootstrapCol>[
												BootstrapCol(
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 250,
															maxLines: 3,
															controller: bancoController.urlController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Url',
																labelText: 'Url',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																bancoController.bancoModel.url = text;
																bancoController.formWasChanged = true;
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
