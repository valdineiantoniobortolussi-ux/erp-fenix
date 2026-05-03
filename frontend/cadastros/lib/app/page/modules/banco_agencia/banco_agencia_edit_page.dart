import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/banco_agencia_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class BancoAgenciaEditPage extends StatelessWidget {
	BancoAgenciaEditPage({Key? key}) : super(key: key);
	final bancoAgenciaController = Get.find<BancoAgenciaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					bancoAgenciaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: bancoAgenciaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Agência - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: bancoAgenciaController.save),
						cancelAndExitButton(onPressed: bancoAgenciaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: bancoAgenciaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: bancoAgenciaController.scrollController,
							child: SingleChildScrollView(
								controller: bancoAgenciaController.scrollController,
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: bancoAgenciaController.bancoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Banco',
																			labelText: 'Banco *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: bancoAgenciaController.callBancoLookup),
															),
														],
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
															maxLength: 100,
															controller: bancoAgenciaController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																bancoAgenciaController.bancoAgenciaModel.nome = text;
																bancoAgenciaController.formWasChanged = true;
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
													sizes: 'col-12 col-md-7',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 20,
															controller: bancoAgenciaController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																bancoAgenciaController.bancoAgenciaModel.numero = text;
																bancoAgenciaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-1',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 1,
															controller: bancoAgenciaController.digitoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Digito',
																labelText: 'Digito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																bancoAgenciaController.bancoAgenciaModel.digito = text;
																bancoAgenciaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: bancoAgenciaController.telefoneController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Telefone',
																labelText: 'Telefone',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																bancoAgenciaController.bancoAgenciaModel.telefone = text;
																bancoAgenciaController.formWasChanged = true;
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
															maxLength: 100,
															controller: bancoAgenciaController.contatoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Contato',
																labelText: 'Contato',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																bancoAgenciaController.bancoAgenciaModel.contato = text;
																bancoAgenciaController.formWasChanged = true;
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
															maxLength: 100,
															controller: bancoAgenciaController.gerenteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Gerente',
																labelText: 'Gerente',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																bancoAgenciaController.bancoAgenciaModel.gerente = text;
																bancoAgenciaController.formWasChanged = true;
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
															controller: bancoAgenciaController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																bancoAgenciaController.bancoAgenciaModel.observacao = text;
																bancoAgenciaController.formWasChanged = true;
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
