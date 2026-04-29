import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:patrimonio/app/page/shared_widget/shared_widget_imports.dart';
import 'package:patrimonio/app/controller/seguradora_controller.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/page/shared_widget/input/input_imports.dart';

class SeguradoraEditPage extends StatelessWidget {
	SeguradoraEditPage({Key? key}) : super(key: key);
	final seguradoraController = Get.find<SeguradoraController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					seguradoraController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: seguradoraController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Seguradora - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: seguradoraController.save),
						cancelAndExitButton(onPressed: seguradoraController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: seguradoraController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: seguradoraController.scrollController,
							child: SingleChildScrollView(
								controller: seguradoraController.scrollController,
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: seguradoraController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																seguradoraController.seguradoraModel.nome = text;
																seguradoraController.formWasChanged = true;
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: seguradoraController.contatoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Contato',
																labelText: 'Contato',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																seguradoraController.seguradoraModel.contato = text;
																seguradoraController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: seguradoraController.telefoneController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Telefone',
																labelText: 'Telefone',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																seguradoraController.seguradoraModel.telefone = text;
																seguradoraController.formWasChanged = true;
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
