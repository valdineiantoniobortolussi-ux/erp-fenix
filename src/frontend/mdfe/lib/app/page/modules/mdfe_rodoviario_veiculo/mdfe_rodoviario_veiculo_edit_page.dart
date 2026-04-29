import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:mdfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:mdfe/app/controller/mdfe_rodoviario_veiculo_controller.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/page/shared_widget/input/input_imports.dart';

class MdfeRodoviarioVeiculoEditPage extends StatelessWidget {
	MdfeRodoviarioVeiculoEditPage({Key? key}) : super(key: key);
	final mdfeRodoviarioVeiculoController = Get.find<MdfeRodoviarioVeiculoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					mdfeRodoviarioVeiculoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: mdfeRodoviarioVeiculoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Rodoviario Veiculo - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: mdfeRodoviarioVeiculoController.save),
						cancelAndExitButton(onPressed: mdfeRodoviarioVeiculoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: mdfeRodoviarioVeiculoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: mdfeRodoviarioVeiculoController.scrollController,
							child: SingleChildScrollView(
								controller: mdfeRodoviarioVeiculoController.scrollController,
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
																		controller: mdfeRodoviarioVeiculoController.mdfeRodoviarioModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Mdfe Rodoviario',
																			labelText: 'Id Mdfe Rodoviario *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: mdfeRodoviarioVeiculoController.callMdfeRodoviarioLookup),
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
															maxLength: 10,
															controller: mdfeRodoviarioVeiculoController.codigoInternoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Interno',
																labelText: 'Codigo Interno',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.codigoInterno = text;
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
															maxLength: 7,
															controller: mdfeRodoviarioVeiculoController.placaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Placa',
																labelText: 'Placa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.placa = text;
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
															maxLength: 11,
															controller: mdfeRodoviarioVeiculoController.renavamController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Renavam',
																labelText: 'Renavam',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.renavam = text;
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
															controller: mdfeRodoviarioVeiculoController.taraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Tara',
																labelText: 'Tara',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.tara = int.tryParse(text);
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
															controller: mdfeRodoviarioVeiculoController.capacidadeKgController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Capacidade Kg',
																labelText: 'Capacidade Kg',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.capacidadeKg = int.tryParse(text);
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
															controller: mdfeRodoviarioVeiculoController.capacidadeM3Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Capacidade M 3',
																labelText: 'Capacidade M 3',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.capacidadeM3 = int.tryParse(text);
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.tipoRodado ?? 'AAA',
															labelText: 'Tipo Rodado',
															hintText: 'Informe os dados para o campo Tipo Rodado',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.tipoRodado = newValue;
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.tipoCarroceria ?? 'AAA',
															labelText: 'Tipo Carroceria',
															hintText: 'Informe os dados para o campo Tipo Carroceria',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.tipoCarroceria = newValue;
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.ufLicenciamento ?? 'AC',
															labelText: 'Uf Licenciamento',
															hintText: 'Informe os dados para o campo Uf Licenciamento',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.ufLicenciamento = newValue;
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
															controller: mdfeRodoviarioVeiculoController.proprietarioCpfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Proprietario Cpf',
																labelText: 'Proprietario Cpf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.proprietarioCpf = text;
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
															controller: mdfeRodoviarioVeiculoController.proprietarioCnpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Proprietario Cnpj',
																labelText: 'Proprietario Cnpj',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.proprietarioCnpj = text;
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
															maxLength: 8,
															controller: mdfeRodoviarioVeiculoController.proprietarioRntrcController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Proprietario Rntrc',
																labelText: 'Proprietario Rntrc',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.proprietarioRntrc = text;
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
															maxLength: 60,
															controller: mdfeRodoviarioVeiculoController.proprietarioNomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Proprietario Nome',
																labelText: 'Proprietario Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.proprietarioNome = text;
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
															maxLength: 2,
															controller: mdfeRodoviarioVeiculoController.proprietarioIeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Proprietario Ie',
																labelText: 'Proprietario Ie',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.proprietarioIe = text;
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
															controller: mdfeRodoviarioVeiculoController.proprietarioTipoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Proprietario Tipo',
																labelText: 'Proprietario Tipo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioVeiculoController.mdfeRodoviarioVeiculoModel.proprietarioTipo = int.tryParse(text);
																mdfeRodoviarioVeiculoController.formWasChanged = true;
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
