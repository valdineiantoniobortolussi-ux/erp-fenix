import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:administrativo/app/page/shared_widget/shared_widget_imports.dart';
import 'package:administrativo/app/controller/empresa_endereco_controller.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/page/shared_widget/input/input_imports.dart';

class EmpresaEnderecoEditPage extends StatelessWidget {
	EmpresaEnderecoEditPage({Key? key}) : super(key: key);
	final empresaEnderecoController = Get.find<EmpresaEnderecoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: empresaEnderecoController.empresaEnderecoScaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('${ empresaEnderecoController.screenTitle } - ${ empresaEnderecoController.isNewRecord ? 'inserting'.tr : 'editing'.tr }',),
					actions: [
						saveButton(onPressed: empresaEnderecoController.save),
						cancelAndExitButton(onPressed: empresaEnderecoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: empresaEnderecoController.empresaEnderecoFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: empresaEnderecoController.scrollController,
							child: SingleChildScrollView(
								controller: empresaEnderecoController.scrollController,
								child: BootstrapContainer(
									fluid: true,
									padding: const EdgeInsets.all(10.0),
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
															controller: empresaEnderecoController.logradouroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Logradouro',
																labelText: 'Logradouro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaEnderecoController.empresaEnderecoModel.logradouro = text;
																empresaEnderecoController.formWasChangedDetail = true;
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
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 10,
															controller: empresaEnderecoController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaEnderecoController.empresaEnderecoModel.numero = text;
																empresaEnderecoController.formWasChangedDetail = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-5',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: empresaEnderecoController.bairroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Bairro',
																labelText: 'Bairro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaEnderecoController.empresaEnderecoModel.bairro = text;
																empresaEnderecoController.formWasChangedDetail = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-5',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: empresaEnderecoController.cidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cidade',
																labelText: 'Cidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaEnderecoController.empresaEnderecoModel.cidade = text;
																empresaEnderecoController.formWasChangedDetail = true;
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
														child: CustomDropdownButton(
															value: empresaEnderecoController.empresaEnderecoModel.uf ?? 'AC',
															labelText: 'UF',
															hintText: 'Informe os dados para o campo Uf',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																empresaEnderecoController.empresaEnderecoModel.uf = newValue;
																empresaEnderecoController.formWasChangedDetail = true;
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
															controller: empresaEnderecoController.cepController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cep',
																labelText: 'CEP',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaEnderecoController.empresaEnderecoModel.cep = text;
																empresaEnderecoController.formWasChangedDetail = true;
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
															controller: empresaEnderecoController.municipioIbgeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Municipio Ibge',
																labelText: 'Municipio Ibge',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaEnderecoController.empresaEnderecoModel.municipioIbge = int.tryParse(text);
																empresaEnderecoController.formWasChangedDetail = true;
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
															maxLength: 100,
															controller: empresaEnderecoController.complementoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Complemento',
																labelText: 'Complemento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaEnderecoController.empresaEnderecoModel.complemento = text;
																empresaEnderecoController.formWasChangedDetail = true;
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
														child: CustomDropdownButton(
															value: empresaEnderecoController.empresaEnderecoModel.principal ?? 'Sim',
															labelText: 'Principal',
															hintText: 'Informe os dados para o campo Principal',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																empresaEnderecoController.empresaEnderecoModel.principal = newValue;
																empresaEnderecoController.formWasChangedDetail = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButton(
															value: empresaEnderecoController.empresaEnderecoModel.entrega ?? 'Sim',
															labelText: 'Entrega',
															hintText: 'Informe os dados para o campo Entrega',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																empresaEnderecoController.empresaEnderecoModel.entrega = newValue;
																empresaEnderecoController.formWasChangedDetail = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButton(
															value: empresaEnderecoController.empresaEnderecoModel.cobranca ?? 'Sim',
															labelText: 'Cobrança',
															hintText: 'Informe os dados para o campo Cobranca',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																empresaEnderecoController.empresaEnderecoModel.cobranca = newValue;
																empresaEnderecoController.formWasChangedDetail = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButton(
															value: empresaEnderecoController.empresaEnderecoModel.correspondencia ?? 'Sim',
															labelText: 'Correspondência',
															hintText: 'Informe os dados para o campo Correspondencia',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																empresaEnderecoController.empresaEnderecoModel.correspondencia = newValue;
																empresaEnderecoController.formWasChangedDetail = true;
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
			);
	}
}
