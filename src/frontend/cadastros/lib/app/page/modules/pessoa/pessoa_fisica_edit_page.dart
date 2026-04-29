import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/pessoa_fisica_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class PessoaFisicaEditPage extends StatelessWidget {
	PessoaFisicaEditPage({Key? key}) : super(key: key);
	final pessoaFisicaController = Get.find<PessoaFisicaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: pessoaFisicaController.scaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pessoaFisicaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pessoaFisicaController.scrollController,
							child: SingleChildScrollView(
								controller: pessoaFisicaController.scrollController,
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
																		controller: pessoaFisicaController.nivelFormacaoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Nivel Formacao',
																			labelText: 'Nivel Formacao *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: pessoaFisicaController.callNivelFormacaoLookup),
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: pessoaFisicaController.estadoCivilModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Estado Civil',
																			labelText: 'Estado Civil *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: pessoaFisicaController.callEstadoCivilLookup),
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pessoaFisicaController.cpfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo CPF',
																labelText: 'CPF',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaFisicaController.pessoaFisicaModel.cpf = text;
																pessoaFisicaController.formWasChanged = true;
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
															maxLength: 20,
															controller: pessoaFisicaController.rgController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo RG',
																labelText: 'RG',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaFisicaController.pessoaFisicaModel.rg = text;
																pessoaFisicaController.formWasChanged = true;
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
															controller: pessoaFisicaController.orgaoRgController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Orgao RG',
																labelText: 'Orgao RG',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaFisicaController.pessoaFisicaModel.orgaoRg = text;
																pessoaFisicaController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Emissao RG',
																labelText: 'Data Emissao RG',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pessoaFisicaController.pessoaFisicaModel.dataEmissaoRg,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pessoaFisicaController.pessoaFisicaModel.dataEmissaoRg = value;
																	pessoaFisicaController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Nascimento',
																labelText: 'Data Nascimento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pessoaFisicaController.pessoaFisicaModel.dataNascimento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pessoaFisicaController.pessoaFisicaModel.dataNascimento = value;
																	pessoaFisicaController.formWasChanged = true;
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pessoaFisicaController.pessoaFisicaModel.sexo ?? 'Masculino',
															labelText: 'Sexo',
															hintText: 'Informe os dados para o campo Sexo',
															items: const ['Masculino','Feminino','Outro'],
															onChanged: (dynamic newValue) {
																pessoaFisicaController.pessoaFisicaModel.sexo = newValue;
																pessoaFisicaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pessoaFisicaController.pessoaFisicaModel.raca ?? 'Branco',
															labelText: 'Raça',
															hintText: 'Informe os dados para o campo Raça',
															items: const ['Branco','Moreno','Negro','Pardo','Amarelo','Indígena','Outro'],
															onChanged: (dynamic newValue) {
																pessoaFisicaController.pessoaFisicaModel.raca = newValue;
																pessoaFisicaController.formWasChanged = true;
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
															controller: pessoaFisicaController.nacionalidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nacionalidade',
																labelText: 'Nacionalidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaFisicaController.pessoaFisicaModel.nacionalidade = text;
																pessoaFisicaController.formWasChanged = true;
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
															maxLength: 100,
															controller: pessoaFisicaController.naturalidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Naturalidade',
																labelText: 'Naturalidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaFisicaController.pessoaFisicaModel.naturalidade = text;
																pessoaFisicaController.formWasChanged = true;
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
															maxLength: 200,
															controller: pessoaFisicaController.nomePaiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Pai',
																labelText: 'Nome Pai',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaFisicaController.pessoaFisicaModel.nomePai = text;
																pessoaFisicaController.formWasChanged = true;
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
															maxLength: 200,
															controller: pessoaFisicaController.nomeMaeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Mae',
																labelText: 'Nome Mae',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaFisicaController.pessoaFisicaModel.nomeMae = text;
																pessoaFisicaController.formWasChanged = true;
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
