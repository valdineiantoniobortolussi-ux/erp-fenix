import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_declaracao_importacao_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeDeclaracaoImportacaoEditPage extends StatelessWidget {
	NfeDeclaracaoImportacaoEditPage({Key? key}) : super(key: key);
	final nfeDeclaracaoImportacaoController = Get.find<NfeDeclaracaoImportacaoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeDeclaracaoImportacaoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Declaração Importação - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeDeclaracaoImportacaoController.save),
						cancelAndExitButton(onPressed: nfeDeclaracaoImportacaoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeDeclaracaoImportacaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeDeclaracaoImportacaoController.scrollController,
							child: SingleChildScrollView(
								controller: nfeDeclaracaoImportacaoController.scrollController,
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
															maxLength: 12,
															controller: nfeDeclaracaoImportacaoController.numeroDocumentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Documento',
																labelText: 'Numero Documento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.numeroDocumento = text;
																nfeDeclaracaoImportacaoController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Registro',
																labelText: 'Data Registro',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.dataRegistro,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.dataRegistro = value;
																	nfeDeclaracaoImportacaoController.formWasChanged = true;
																},
															),
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
															controller: nfeDeclaracaoImportacaoController.localDesembaracoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Local Desembaraco',
																labelText: 'Local Desembaraco',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.localDesembaraco = text;
																nfeDeclaracaoImportacaoController.formWasChanged = true;
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
															value: nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.ufDesembaraco ?? 'AC',
															labelText: 'Uf Desembaraco',
															hintText: 'Informe os dados para o campo Uf Desembaraco',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.ufDesembaraco = newValue;
																nfeDeclaracaoImportacaoController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Desembaraco',
																labelText: 'Data Desembaraco',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.dataDesembaraco,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.dataDesembaraco = value;
																	nfeDeclaracaoImportacaoController.formWasChanged = true;
																},
															),
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
															value: nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.viaTransporte ?? 'AAA',
															labelText: 'Via Transporte',
															hintText: 'Informe os dados para o campo Via Transporte',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.viaTransporte = newValue;
																nfeDeclaracaoImportacaoController.formWasChanged = true;
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
															controller: nfeDeclaracaoImportacaoController.valorAfrmmController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Afrmm',
																labelText: 'Valor Afrmm',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.valorAfrmm = nfeDeclaracaoImportacaoController.valorAfrmmController.numberValue;
																nfeDeclaracaoImportacaoController.formWasChanged = true;
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
															value: nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.formaIntermediacao ?? 'AAA',
															labelText: 'Forma Intermediacao',
															hintText: 'Informe os dados para o campo Forma Intermediacao',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.formaIntermediacao = newValue;
																nfeDeclaracaoImportacaoController.formWasChanged = true;
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
															controller: nfeDeclaracaoImportacaoController.cnpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj',
																labelText: 'Cnpj',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.cnpj = text;
																nfeDeclaracaoImportacaoController.formWasChanged = true;
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
															value: nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.ufTerceiro ?? 'AC',
															labelText: 'Uf Terceiro',
															hintText: 'Informe os dados para o campo Uf Terceiro',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.ufTerceiro = newValue;
																nfeDeclaracaoImportacaoController.formWasChanged = true;
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
															controller: nfeDeclaracaoImportacaoController.codigoExportadorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Exportador',
																labelText: 'Codigo Exportador',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDeclaracaoImportacaoController.nfeDeclaracaoImportacaoModel.codigoExportador = text;
																nfeDeclaracaoImportacaoController.formWasChanged = true;
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
