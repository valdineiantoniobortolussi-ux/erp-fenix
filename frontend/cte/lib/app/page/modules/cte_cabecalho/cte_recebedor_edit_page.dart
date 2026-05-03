import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_recebedor_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteRecebedorEditPage extends StatelessWidget {
	CteRecebedorEditPage({Key? key}) : super(key: key);
	final cteRecebedorController = Get.find<CteRecebedorController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: cteRecebedorController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Recebedor - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteRecebedorController.save),
						cancelAndExitButton(onPressed: cteRecebedorController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteRecebedorController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteRecebedorController.scrollController,
							child: SingleChildScrollView(
								controller: cteRecebedorController.scrollController,
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
															controller: cteRecebedorController.cnpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj',
																labelText: 'Cnpj',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.cnpj = text;
																cteRecebedorController.formWasChanged = true;
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
															controller: cteRecebedorController.cpfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cpf',
																labelText: 'Cpf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.cpf = text;
																cteRecebedorController.formWasChanged = true;
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
															maxLength: 20,
															controller: cteRecebedorController.ieController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ie',
																labelText: 'Ie',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.ie = text;
																cteRecebedorController.formWasChanged = true;
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
															controller: cteRecebedorController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.nome = text;
																cteRecebedorController.formWasChanged = true;
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
															controller: cteRecebedorController.fantasiaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fantasia',
																labelText: 'Fantasia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.fantasia = text;
																cteRecebedorController.formWasChanged = true;
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
															controller: cteRecebedorController.telefoneController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Telefone',
																labelText: 'Telefone',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.telefone = text;
																cteRecebedorController.formWasChanged = true;
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
															controller: cteRecebedorController.logradouroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Logradouro',
																labelText: 'Logradouro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.logradouro = text;
																cteRecebedorController.formWasChanged = true;
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
															controller: cteRecebedorController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.numero = text;
																cteRecebedorController.formWasChanged = true;
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
															controller: cteRecebedorController.complementoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Complemento',
																labelText: 'Complemento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.complemento = text;
																cteRecebedorController.formWasChanged = true;
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
															controller: cteRecebedorController.bairroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Bairro',
																labelText: 'Bairro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.bairro = text;
																cteRecebedorController.formWasChanged = true;
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
															controller: cteRecebedorController.codigoMunicipioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Municipio',
																labelText: 'Codigo Municipio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.codigoMunicipio = int.tryParse(text);
																cteRecebedorController.formWasChanged = true;
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
															controller: cteRecebedorController.nomeMunicipioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Municipio',
																labelText: 'Nome Municipio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.nomeMunicipio = text;
																cteRecebedorController.formWasChanged = true;
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
															value: cteRecebedorController.cteRecebedorModel.uf ?? 'AC',
															labelText: 'Uf',
															hintText: 'Informe os dados para o campo Uf',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																cteRecebedorController.cteRecebedorModel.uf = newValue;
																cteRecebedorController.formWasChanged = true;
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
															controller: cteRecebedorController.cepController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cep',
																labelText: 'Cep',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.cep = text;
																cteRecebedorController.formWasChanged = true;
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
															controller: cteRecebedorController.codigoPaisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Pais',
																labelText: 'Codigo Pais',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.codigoPais = int.tryParse(text);
																cteRecebedorController.formWasChanged = true;
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
															controller: cteRecebedorController.nomePaisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Pais',
																labelText: 'Nome Pais',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.nomePais = text;
																cteRecebedorController.formWasChanged = true;
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
															maxLength: 60,
															controller: cteRecebedorController.emailController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Email',
																labelText: 'Email',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRecebedorController.cteRecebedorModel.email = text;
																cteRecebedorController.formWasChanged = true;
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
