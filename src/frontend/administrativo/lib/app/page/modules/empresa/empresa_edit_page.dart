import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:administrativo/app/controller/empresa_controller.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/page/shared_widget/input/input_imports.dart';

class EmpresaEditPage extends StatelessWidget {
	EmpresaEditPage({Key? key}) : super(key: key);
	final empresaController = Get.find<EmpresaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: empresaController.empresaScaffoldKey,
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: empresaController.empresaFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: empresaController.scrollController,
							child: SingleChildScrollView(
								controller: empresaController.scrollController,
								child: BootstrapContainer(
									fluid: true,
									padding: const EdgeInsets.all(10),
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
															maxLength: 150,
															controller: empresaController.razaoSocialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Razao Social',
																labelText: 'Razão Social',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.razaoSocial = text;
																empresaController.formWasChanged = true;
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
															maxLength: 150,
															controller: empresaController.nomeFantasiaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Fantasia',
																labelText: 'Nome Fantasia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.nomeFantasia = text;
																empresaController.formWasChanged = true;
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
															controller: empresaController.cnpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj',
																labelText: 'CNPJ',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.cnpj = text;
																empresaController.formWasChanged = true;
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
															maxLength: 45,
															controller: empresaController.inscricaoEstadualController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Inscricao Estadual',
																labelText: 'Inscrição Estadual',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.inscricaoEstadual = text;
																empresaController.formWasChanged = true;
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
															maxLength: 45,
															controller: empresaController.inscricaoMunicipalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Inscricao Municipal',
																labelText: 'Inscrição Municipal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.inscricaoMunicipal = text;
																empresaController.formWasChanged = true;
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
														child: CustomDropdownButton(
															value: empresaController.currentModel.tipoRegime ?? '1-Lucro Real',
															labelText: 'Tipo Regime',
															hintText: 'Informe os dados para o campo Tipo Regime',
															items: const ['1-Lucro Real','2-Lucro Presumido','3-Simples Nacional'],
															onChanged: (dynamic newValue) {
																empresaController.currentModel.tipoRegime = newValue;
																empresaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButton(
															value: empresaController.currentModel.crt ?? '1-Simples Nacional',
															labelText: 'CRT',
															hintText: 'Informe os dados para o campo Crt',
															items: const ['1-Simples Nacional','2-Simples Nacional - excesso de sublimite da receita bruta','3-Regime Normal '],
															onChanged: (dynamic newValue) {
																empresaController.currentModel.crt = newValue;
																empresaController.formWasChanged = true;
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
															validator: ValidateFormField.validateEmail,
															maxLength: 250,
															controller: empresaController.emailController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Email',
																labelText: 'Email',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.email = text;
																empresaController.formWasChanged = true;
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
															maxLength: 250,
															controller: empresaController.siteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Site',
																labelText: 'Site',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.site = text;
																empresaController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: empresaController.contatoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Contato',
																labelText: 'Contato',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.contato = text;
																empresaController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Constituicao',
																labelText: 'Data Constituição',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: empresaController.currentModel.dataConstituicao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	empresaController.currentModel.dataConstituicao = value;
																	empresaController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButton(
															value: empresaController.currentModel.tipo ?? 'Matriz',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Matriz','Filial'],
															onChanged: (dynamic newValue) {
																empresaController.currentModel.tipo = newValue;
																empresaController.formWasChanged = true;
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
															maxLength: 30,
															controller: empresaController.inscricaoJuntaComercialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Inscricao Junta Comercial',
																labelText: 'Inscricao Junta Comercial',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.inscricaoJuntaComercial = text;
																empresaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Insc Junta Comercial',
																labelText: 'Data Inscrição Junta Comercial',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: empresaController.currentModel.dataInscJuntaComercial,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	empresaController.currentModel.dataInscJuntaComercial = value;
																	empresaController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: empresaController.codigoIbgeCidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Ibge Cidade',
																labelText: 'Codigo IBGE Cidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.codigoIbgeCidade = int.tryParse(text);
																empresaController.formWasChanged = true;
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
															controller: empresaController.codigoIbgeUfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Ibge Uf',
																labelText: 'Codigo IBGE UF',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.codigoIbgeUf = int.tryParse(text);
																empresaController.formWasChanged = true;
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
															maxLength: 12,
															controller: empresaController.ceiController,
															decoration: inputDecoration(
																hintText: 'Informe o CEI (Cadastro Específico do INSS)',
																labelText: 'CEI',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.cei = text;
																empresaController.formWasChanged = true;
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
															maxLength: 7,
															controller: empresaController.codigoCnaePrincipalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Cnae Principal',
																labelText: 'Codigo CNAE Principal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.codigoCnaePrincipal = text;
																empresaController.formWasChanged = true;
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
															controller: empresaController.imagemLogotipoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Imagem Logotipo',
																labelText: 'Imagem Logotipo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaController.currentModel.imagemLogotipo = text;
																empresaController.formWasChanged = true;
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
