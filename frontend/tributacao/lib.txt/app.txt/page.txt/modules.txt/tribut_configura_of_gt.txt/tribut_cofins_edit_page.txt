import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:tributacao/app/controller/tribut_cofins_controller.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/page/shared_widget/input/input_imports.dart';

class TributCofinsEditPage extends StatelessWidget {
	TributCofinsEditPage({Key? key}) : super(key: key);
	final tributCofinsController = Get.find<TributCofinsController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: tributCofinsController.scaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: tributCofinsController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: tributCofinsController.scrollController,
							child: SingleChildScrollView(
								controller: tributCofinsController.scrollController,
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributCofinsController.tributCofinsModel.cstCofins ?? '00',
															labelText: 'CST',
															hintText: 'Informe os dados para o campo Cst Cofins',
															items: const ['00','10','20','30','40','41','50','51','60','70','90'],
															onChanged: (dynamic newValue) {
																tributCofinsController.tributCofinsModel.cstCofins = newValue;
																tributCofinsController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributCofinsController.tributCofinsModel.modalidadeBaseCalculo ?? '0-Percentual',
															labelText: 'Modalidade Base Cálculo',
															hintText: 'Informe os dados para o campo Modalidade Base Calculo',
															items: const ['0-Percentual','1-Unidade'],
															onChanged: (dynamic newValue) {
																tributCofinsController.tributCofinsModel.modalidadeBaseCalculo = newValue;
																tributCofinsController.formWasChanged = true;
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
															maxLength: 2,
															controller: tributCofinsController.efdTabela435Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Efd Tabela 435',
																labelText: 'Código Apuração EFD',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributCofinsController.tributCofinsModel.efdTabela435 = text;
																tributCofinsController.formWasChanged = true;
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
															controller: tributCofinsController.porcentoBaseCalculoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porcento Base Calculo',
																labelText: 'Porcento Base Cálculo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributCofinsController.tributCofinsModel.porcentoBaseCalculo = tributCofinsController.porcentoBaseCalculoController.numberValue;
																tributCofinsController.formWasChanged = true;
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
															controller: tributCofinsController.aliquotaPorcentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Porcento',
																labelText: 'Alíquota Porcento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributCofinsController.tributCofinsModel.aliquotaPorcento = tributCofinsController.aliquotaPorcentoController.numberValue;
																tributCofinsController.formWasChanged = true;
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
															controller: tributCofinsController.aliquotaUnidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Unidade',
																labelText: 'Alíquota Unidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributCofinsController.tributCofinsModel.aliquotaUnidade = tributCofinsController.aliquotaUnidadeController.numberValue;
																tributCofinsController.formWasChanged = true;
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
															controller: tributCofinsController.valorPrecoMaximoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Preco Maximo',
																labelText: 'Valor Preco Maximo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributCofinsController.tributCofinsModel.valorPrecoMaximo = tributCofinsController.valorPrecoMaximoController.numberValue;
																tributCofinsController.formWasChanged = true;
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
															controller: tributCofinsController.valorPautaFiscalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Pauta Fiscal',
																labelText: 'Valor Pauta Fiscal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributCofinsController.tributCofinsModel.valorPautaFiscal = tributCofinsController.valorPautaFiscalController.numberValue;
																tributCofinsController.formWasChanged = true;
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
