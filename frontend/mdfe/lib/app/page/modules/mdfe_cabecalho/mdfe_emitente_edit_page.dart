import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:mdfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:mdfe/app/controller/mdfe_emitente_controller.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/page/shared_widget/input/input_imports.dart';

class MdfeEmitenteEditPage extends StatelessWidget {
	MdfeEmitenteEditPage({Key? key}) : super(key: key);
	final mdfeEmitenteController = Get.find<MdfeEmitenteController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: mdfeEmitenteController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Emitente - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: mdfeEmitenteController.save),
						cancelAndExitButton(onPressed: mdfeEmitenteController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: mdfeEmitenteController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: mdfeEmitenteController.scrollController,
							child: SingleChildScrollView(
								controller: mdfeEmitenteController.scrollController,
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 60,
															controller: mdfeEmitenteController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeEmitenteController.mdfeEmitenteModel.nome = text;
																mdfeEmitenteController.formWasChanged = true;
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
															maxLength: 60,
															controller: mdfeEmitenteController.fantasiaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fantasia',
																labelText: 'Fantasia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeEmitenteController.mdfeEmitenteModel.fantasia = text;
																mdfeEmitenteController.formWasChanged = true;
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
															controller: mdfeEmitenteController.cnpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj',
																labelText: 'Cnpj',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeEmitenteController.mdfeEmitenteModel.cnpj = text;
																mdfeEmitenteController.formWasChanged = true;
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
															controller: mdfeEmitenteController.ieController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ie',
																labelText: 'Ie',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeEmitenteController.mdfeEmitenteModel.ie = int.tryParse(text);
																mdfeEmitenteController.formWasChanged = true;
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
															maxLength: 60,
															controller: mdfeEmitenteController.logradouroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Logradouro',
																labelText: 'Logradouro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeEmitenteController.mdfeEmitenteModel.logradouro = text;
																mdfeEmitenteController.formWasChanged = true;
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
															maxLength: 60,
															controller: mdfeEmitenteController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeEmitenteController.mdfeEmitenteModel.numero = text;
																mdfeEmitenteController.formWasChanged = true;
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
															maxLength: 60,
															controller: mdfeEmitenteController.complementoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Complemento',
																labelText: 'Complemento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeEmitenteController.mdfeEmitenteModel.complemento = text;
																mdfeEmitenteController.formWasChanged = true;
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
															maxLength: 60,
															controller: mdfeEmitenteController.bairroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Bairro',
																labelText: 'Bairro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeEmitenteController.mdfeEmitenteModel.bairro = text;
																mdfeEmitenteController.formWasChanged = true;
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
															maxLength: 7,
															controller: mdfeEmitenteController.codigoMunicipioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Municipio',
																labelText: 'Codigo Municipio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeEmitenteController.mdfeEmitenteModel.codigoMunicipio = text;
																mdfeEmitenteController.formWasChanged = true;
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
															maxLength: 60,
															controller: mdfeEmitenteController.nomeMunicipioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Municipio',
																labelText: 'Nome Municipio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeEmitenteController.mdfeEmitenteModel.nomeMunicipio = text;
																mdfeEmitenteController.formWasChanged = true;
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
															controller: mdfeEmitenteController.cepController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cep',
																labelText: 'Cep',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeEmitenteController.mdfeEmitenteModel.cep = text;
																mdfeEmitenteController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: mdfeEmitenteController.mdfeEmitenteModel.uf ?? 'AC',
															labelText: 'Uf',
															hintText: 'Informe os dados para o campo Uf',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																mdfeEmitenteController.mdfeEmitenteModel.uf = newValue;
																mdfeEmitenteController.formWasChanged = true;
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
															controller: mdfeEmitenteController.telefoneController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Telefone',
																labelText: 'Telefone',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeEmitenteController.mdfeEmitenteModel.telefone = text;
																mdfeEmitenteController.formWasChanged = true;
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
															validator: ValidateFormField.validateEmail,
															maxLength: 60,
															controller: mdfeEmitenteController.emailController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Email',
																labelText: 'Email',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeEmitenteController.mdfeEmitenteModel.email = text;
																mdfeEmitenteController.formWasChanged = true;
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
