import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_rodoviario_veiculo_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteRodoviarioVeiculoEditPage extends StatelessWidget {
	CteRodoviarioVeiculoEditPage({Key? key}) : super(key: key);
	final cteRodoviarioVeiculoController = Get.find<CteRodoviarioVeiculoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					cteRodoviarioVeiculoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: cteRodoviarioVeiculoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Cte Rodoviario Veiculo - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteRodoviarioVeiculoController.save),
						cancelAndExitButton(onPressed: cteRodoviarioVeiculoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteRodoviarioVeiculoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteRodoviarioVeiculoController.scrollController,
							child: SingleChildScrollView(
								controller: cteRodoviarioVeiculoController.scrollController,
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
																		controller: cteRodoviarioVeiculoController.cteRodoviarioModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Cte Rodoviario',
																			labelText: 'Id Cte Rodoviario *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: cteRodoviarioVeiculoController.callCteRodoviarioLookup),
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
															controller: cteRodoviarioVeiculoController.codigoInternoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Interno',
																labelText: 'Codigo Interno',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.codigoInterno = text;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															controller: cteRodoviarioVeiculoController.renavamController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Renavam',
																labelText: 'Renavam',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.renavam = text;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															controller: cteRodoviarioVeiculoController.placaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Placa',
																labelText: 'Placa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.placa = text;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															controller: cteRodoviarioVeiculoController.taraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Tara',
																labelText: 'Tara',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.tara = int.tryParse(text);
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															controller: cteRodoviarioVeiculoController.capacidadeKgController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Capacidade Kg',
																labelText: 'Capacidade Kg',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.capacidadeKg = int.tryParse(text);
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															controller: cteRodoviarioVeiculoController.capacidadeM3Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Capacidade M 3',
																labelText: 'Capacidade M 3',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.capacidadeM3 = int.tryParse(text);
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															value: cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.tipoPropriedade ?? 'AAA',
															labelText: 'Tipo Propriedade',
															hintText: 'Informe os dados para o campo Tipo Propriedade',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.tipoPropriedade = newValue;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															value: cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.tipoVeiculo ?? 'AAA',
															labelText: 'Tipo Veiculo',
															hintText: 'Informe os dados para o campo Tipo Veiculo',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.tipoVeiculo = newValue;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															value: cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.tipoRodado ?? 'AAA',
															labelText: 'Tipo Rodado',
															hintText: 'Informe os dados para o campo Tipo Rodado',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.tipoRodado = newValue;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															value: cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.tipoCarroceria ?? 'AAA',
															labelText: 'Tipo Carroceria',
															hintText: 'Informe os dados para o campo Tipo Carroceria',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.tipoCarroceria = newValue;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															value: cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.uf ?? 'AC',
															labelText: 'Uf',
															hintText: 'Informe os dados para o campo Uf',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.uf = newValue;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															controller: cteRodoviarioVeiculoController.proprietarioCpfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Proprietario Cpf',
																labelText: 'Proprietario Cpf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.proprietarioCpf = text;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															controller: cteRodoviarioVeiculoController.proprietarioCnpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Proprietario Cnpj',
																labelText: 'Proprietario Cnpj',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.proprietarioCnpj = text;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															controller: cteRodoviarioVeiculoController.proprietarioRntrcController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Proprietario Rntrc',
																labelText: 'Proprietario Rntrc',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.proprietarioRntrc = text;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															controller: cteRodoviarioVeiculoController.proprietarioNomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Proprietario Nome',
																labelText: 'Proprietario Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.proprietarioNome = text;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															maxLength: 14,
															controller: cteRodoviarioVeiculoController.proprietarioIeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Proprietario Ie',
																labelText: 'Proprietario Ie',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.proprietarioIe = text;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															value: cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.proprietarioUf ?? 'AC',
															labelText: 'Proprietario Uf',
															hintText: 'Informe os dados para o campo Proprietario Uf',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.proprietarioUf = newValue;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
															value: cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.proprietarioTipo ?? 'AAA',
															labelText: 'Proprietario Tipo',
															hintText: 'Informe os dados para o campo Proprietario Tipo',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteRodoviarioVeiculoController.cteRodoviarioVeiculoModel.proprietarioTipo = newValue;
																cteRodoviarioVeiculoController.formWasChanged = true;
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
