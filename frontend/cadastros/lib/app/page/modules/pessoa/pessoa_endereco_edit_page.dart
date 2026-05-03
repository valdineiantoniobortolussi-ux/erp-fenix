import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/pessoa_endereco_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class PessoaEnderecoEditPage extends StatelessWidget {
	PessoaEnderecoEditPage({Key? key}) : super(key: key);
	final pessoaEnderecoController = Get.find<PessoaEnderecoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: pessoaEnderecoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Endereços - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: pessoaEnderecoController.save),
						cancelAndExitButton(onPressed: pessoaEnderecoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pessoaEnderecoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pessoaEnderecoController.scrollController,
							child: SingleChildScrollView(
								controller: pessoaEnderecoController.scrollController,
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
													sizes: 'col-12 col-md-9',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: pessoaEnderecoController.logradouroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Logradouro',
																labelText: 'Logradouro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaEnderecoController.pessoaEnderecoModel.logradouro = text;
																pessoaEnderecoController.formWasChanged = true;
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
															maxLength: 10,
															controller: pessoaEnderecoController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaEnderecoController.pessoaEnderecoModel.numero = text;
																pessoaEnderecoController.formWasChanged = true;
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
															controller: pessoaEnderecoController.complementoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Complemento',
																labelText: 'Complemento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaEnderecoController.pessoaEnderecoModel.complemento = text;
																pessoaEnderecoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-5',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: pessoaEnderecoController.bairroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Bairro',
																labelText: 'Bairro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaEnderecoController.pessoaEnderecoModel.bairro = text;
																pessoaEnderecoController.formWasChanged = true;
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
															controller: pessoaEnderecoController.cidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cidade',
																labelText: 'Cidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaEnderecoController.pessoaEnderecoModel.cidade = text;
																pessoaEnderecoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pessoaEnderecoController.pessoaEnderecoModel.uf ?? 'AC',
															labelText: 'UF',
															hintText: 'Informe os dados para o campo UF',
															items: const ['AC','AL','AM','AP','BA','CE','DF','ES','GO','MA','MG','MS','MT','PA','PB','PE','PI','PR','RJ','RN','RO','RR','RS','SC','SE','SP','TO'],
															onChanged: (dynamic newValue) {
																pessoaEnderecoController.pessoaEnderecoModel.uf = newValue;
																pessoaEnderecoController.formWasChanged = true;
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
															controller: pessoaEnderecoController.cepController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo CEP',
																labelText: 'CEP',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaEnderecoController.pessoaEnderecoModel.cep = text;
																pessoaEnderecoController.formWasChanged = true;
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
															controller: pessoaEnderecoController.municipioIbgeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Municipio IBGE',
																labelText: 'Municipio IBGE',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaEnderecoController.pessoaEnderecoModel.municipioIbge = int.tryParse(text);
																pessoaEnderecoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: pessoaEnderecoController.pessoaEnderecoModel.principal ?? 'Sim',
															labelText: 'Principal',
															hintText: 'Informe os dados para o campo Principal',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																pessoaEnderecoController.pessoaEnderecoModel.principal = newValue;
																pessoaEnderecoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pessoaEnderecoController.pessoaEnderecoModel.entrega ?? 'Sim',
															labelText: 'Entrega',
															hintText: 'Informe os dados para o campo Entrega',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																pessoaEnderecoController.pessoaEnderecoModel.entrega = newValue;
																pessoaEnderecoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pessoaEnderecoController.pessoaEnderecoModel.cobranca ?? 'Sim',
															labelText: 'Cobranca',
															hintText: 'Informe os dados para o campo Cobranca',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																pessoaEnderecoController.pessoaEnderecoModel.cobranca = newValue;
																pessoaEnderecoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pessoaEnderecoController.pessoaEnderecoModel.correspondencia ?? 'Sim',
															labelText: 'Correspondencia',
															hintText: 'Informe os dados para o campo Correspondencia',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																pessoaEnderecoController.pessoaEnderecoModel.correspondencia = newValue;
																pessoaEnderecoController.formWasChanged = true;
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
