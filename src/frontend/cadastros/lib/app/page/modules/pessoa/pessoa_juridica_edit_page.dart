import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/controller/pessoa_juridica_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class PessoaJuridicaEditPage extends StatelessWidget {
	PessoaJuridicaEditPage({Key? key}) : super(key: key);
	final pessoaJuridicaController = Get.find<PessoaJuridicaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: pessoaJuridicaController.scaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pessoaJuridicaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pessoaJuridicaController.scrollController,
							child: SingleChildScrollView(
								controller: pessoaJuridicaController.scrollController,
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
															controller: pessoaJuridicaController.cnpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo CNPJ',
																labelText: 'CNPJ',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaJuridicaController.pessoaJuridicaModel.cnpj = text;
																pessoaJuridicaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: pessoaJuridicaController.nomeFantasiaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Fantasia',
																labelText: 'Nome Fantasia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaJuridicaController.pessoaJuridicaModel.nomeFantasia = text;
																pessoaJuridicaController.formWasChanged = true;
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
															controller: pessoaJuridicaController.inscricaoEstadualController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Inscricao Estadual',
																labelText: 'Inscricao Estadual',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaJuridicaController.pessoaJuridicaModel.inscricaoEstadual = text;
																pessoaJuridicaController.formWasChanged = true;
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
															controller: pessoaJuridicaController.inscricaoMunicipalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Inscricao Municipal',
																labelText: 'Inscricao Municipal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaJuridicaController.pessoaJuridicaModel.inscricaoMunicipal = text;
																pessoaJuridicaController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Constituicao',
																labelText: 'Data Constituicao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pessoaJuridicaController.pessoaJuridicaModel.dataConstituicao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pessoaJuridicaController.pessoaJuridicaModel.dataConstituicao = value;
																	pessoaJuridicaController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pessoaJuridicaController.pessoaJuridicaModel.tipoRegime ?? '1-Lucro Real',
															labelText: 'Tipo Regime',
															hintText: 'Informe os dados para o campo Tipo Regime',
															items: const ['1-Lucro Real','2-Lucro Presumido','3-Simples Nacional'],
															onChanged: (dynamic newValue) {
																pessoaJuridicaController.pessoaJuridicaModel.tipoRegime = newValue;
																pessoaJuridicaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pessoaJuridicaController.pessoaJuridicaModel.crt ?? '1-Simples Nacional',
															labelText: 'CRT',
															hintText: 'Informe os dados para o campo CRT',
															items: const ['1-Simples Nacional','2-Simples Nacional-Excesso','3-Regime Normal'],
															onChanged: (dynamic newValue) {
																pessoaJuridicaController.pessoaJuridicaModel.crt = newValue;
																pessoaJuridicaController.formWasChanged = true;
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
