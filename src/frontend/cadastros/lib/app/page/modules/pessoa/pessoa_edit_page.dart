import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/controller/pessoa_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class PessoaEditPage extends StatelessWidget {
	PessoaEditPage({Key? key}) : super(key: key);
	final pessoaController = Get.find<PessoaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: pessoaController.pessoaEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pessoaController.pessoaEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pessoaController.scrollController,
							child: SingleChildScrollView(
								controller: pessoaController.scrollController,
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
															maxLength: 150,
															controller: pessoaController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaController.pessoaModel.nome = text;
																pessoaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pessoaController.pessoaModel.tipo ?? 'Física',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Física','Jurídica'],
															onChanged: (dynamic newValue) {
																pessoaController.pessoaModel.tipo = newValue;
																pessoaController.formWasChanged = true;
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
															maxLength: 250,
															controller: pessoaController.siteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Site',
																labelText: 'Site',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaController.pessoaModel.site = text;
																pessoaController.formWasChanged = true;
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
															validator: ValidateFormField.validateEmail,
															maxLength: 250,
															controller: pessoaController.emailController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Email',
																labelText: 'Email',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaController.pessoaModel.email = text;
																pessoaController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: pessoaController.pessoaModel.ehCliente ?? 'Sim',
															labelText: 'É Cliente',
															hintText: 'Informe os dados para o campo Eh Cliente',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																pessoaController.pessoaModel.ehCliente = newValue;
																pessoaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pessoaController.pessoaModel.ehFornecedor ?? 'Sim',
															labelText: 'É Fornecedor',
															hintText: 'Informe os dados para o campo Eh Fornecedor',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																pessoaController.pessoaModel.ehFornecedor = newValue;
																pessoaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pessoaController.pessoaModel.ehTransportadora ?? 'Sim',
															labelText: 'É Transportadora',
															hintText: 'Informe os dados para o campo Eh Transportadora',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																pessoaController.pessoaModel.ehTransportadora = newValue;
																pessoaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pessoaController.pessoaModel.ehColaborador ?? 'Sim',
															labelText: 'É Colaborador',
															hintText: 'Informe os dados para o campo Eh Colaborador',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																pessoaController.pessoaModel.ehColaborador = newValue;
																pessoaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pessoaController.pessoaModel.ehContador ?? 'Sim',
															labelText: 'É Contador',
															hintText: 'Informe os dados para o campo Eh Contador',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																pessoaController.pessoaModel.ehContador = newValue;
																pessoaController.formWasChanged = true;
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
