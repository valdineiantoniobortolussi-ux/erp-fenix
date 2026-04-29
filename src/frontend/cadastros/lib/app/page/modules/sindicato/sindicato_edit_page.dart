import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/sindicato_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class SindicatoEditPage extends StatelessWidget {
	SindicatoEditPage({Key? key}) : super(key: key);
	final sindicatoController = Get.find<SindicatoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					sindicatoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: sindicatoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Sindicato - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: sindicatoController.save),
						cancelAndExitButton(onPressed: sindicatoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: sindicatoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: sindicatoController.scrollController,
							child: SingleChildScrollView(
								controller: sindicatoController.scrollController,
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
															maxLength: 100,
															controller: sindicatoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Fill with the Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.nome = text;
																sindicatoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: sindicatoController.codigoBancoController,
															decoration: inputDecoration(
																hintText: 'Fill with the Codigo Banco',
																labelText: 'Codigo Banco',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.codigoBanco = int.tryParse(text);
																sindicatoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: sindicatoController.codigoAgenciaController,
															decoration: inputDecoration(
																hintText: 'Fill with the Codigo Agencia',
																labelText: 'Codigo Agencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.codigoAgencia = int.tryParse(text);
																sindicatoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 20,
															controller: sindicatoController.contaBancoController,
															decoration: inputDecoration(
																hintText: 'Fill with the Conta Banco',
																labelText: 'Conta Banco',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.contaBanco = text;
																sindicatoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 30,
															controller: sindicatoController.codigoCedenteController,
															decoration: inputDecoration(
																hintText: 'Fill with the Codigo Cedente',
																labelText: 'Codigo Cedente',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.codigoCedente = text;
																sindicatoController.formWasChanged = true;
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
															controller: sindicatoController.logradouroController,
															decoration: inputDecoration(
																hintText: 'Fill with the Logradouro',
																labelText: 'Logradouro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.logradouro = text;
																sindicatoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 10,
															controller: sindicatoController.numeroController,
															decoration: inputDecoration(
																hintText: 'Fill with the Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.numero = text;
																sindicatoController.formWasChanged = true;
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
															maxLength: 100,
															controller: sindicatoController.bairroController,
															decoration: inputDecoration(
																hintText: 'Fill with the Bairro',
																labelText: 'Bairro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.bairro = text;
																sindicatoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: sindicatoController.municipioIbgeController,
															decoration: inputDecoration(
																hintText: 'Fill with the Municipio Ibge',
																labelText: 'Municipio IBGE',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.municipioIbge = int.tryParse(text);
																sindicatoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: sindicatoController.sindicatoModel.uf ?? 'AC',
															labelText: 'UF',
															hintText: 'Fill with the Uf',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																sindicatoController.sindicatoModel.uf = newValue;
																sindicatoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: sindicatoController.fone1Controller,
															decoration: inputDecoration(
																hintText: 'Fill with the Fone 1',
																labelText: 'Fone 1',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.fone1 = text;
																sindicatoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: sindicatoController.fone2Controller,
															decoration: inputDecoration(
																hintText: 'Fill with the Fone 2',
																labelText: 'Fone 2',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.fone2 = text;
																sindicatoController.formWasChanged = true;
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
															validator: ValidateFormField.validateEmail,
															maxLength: 100,
															controller: sindicatoController.emailController,
															decoration: inputDecoration(
																hintText: 'Fill with the Email',
																labelText: 'Email',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.email = text;
																sindicatoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: sindicatoController.sindicatoModel.tipoSindicato ?? 'Patronal',
															labelText: 'Tipo Sindicato',
															hintText: 'Fill with the Tipo Sindicato',
															items: const ['Patronal','Empregados'],
															onChanged: (dynamic newValue) {
																sindicatoController.sindicatoModel.tipoSindicato = newValue;
																sindicatoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Fill with the Data Base',
																labelText: 'Data Base',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: sindicatoController.sindicatoModel.dataBase,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	sindicatoController.sindicatoModel.dataBase = value;
																	sindicatoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: sindicatoController.pisoSalarialController,
															decoration: inputDecoration(
																hintText: 'Fill with the Piso Salarial',
																labelText: 'Piso Salarial',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.pisoSalarial = sindicatoController.pisoSalarialController.numberValue;
																sindicatoController.formWasChanged = true;
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
															controller: sindicatoController.cnpjController,
															decoration: inputDecoration(
																hintText: 'Fill with the Cnpj',
																labelText: 'CNP',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.cnpj = text;
																sindicatoController.formWasChanged = true;
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
															maxLength: 30,
															controller: sindicatoController.classificacaoContabilContaController,
															decoration: inputDecoration(
																hintText: 'Fill with the Classificacao Contabil Conta',
																labelText: 'Conta Contábil',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sindicatoController.sindicatoModel.classificacaoContabilConta = text;
																sindicatoController.formWasChanged = true;
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
