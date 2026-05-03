import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:tributacao/app/controller/tribut_pis_controller.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/page/shared_widget/input/input_imports.dart';

class TributPisEditPage extends StatelessWidget {
	TributPisEditPage({Key? key}) : super(key: key);
	final tributPisController = Get.find<TributPisController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: tributPisController.scaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: tributPisController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: tributPisController.scrollController,
							child: SingleChildScrollView(
								controller: tributPisController.scrollController,
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
															value: tributPisController.tributPisModel.cstPis ?? '00',
															labelText: 'CST',
															hintText: 'Informe os dados para o campo Cst Pis',
															items: const ['00','10','20','30','40','41','50','51','60','70','90'],
															onChanged: (dynamic newValue) {
																tributPisController.tributPisModel.cstPis = newValue;
																tributPisController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributPisController.tributPisModel.modalidadeBaseCalculo ?? '0-Percentual',
															labelText: 'Modalidade Base Cálculo',
															hintText: 'Informe os dados para o campo Modalidade Base Calculo',
															items: const ['0-Percentual','1-Unidade'],
															onChanged: (dynamic newValue) {
																tributPisController.tributPisModel.modalidadeBaseCalculo = newValue;
																tributPisController.formWasChanged = true;
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
															controller: tributPisController.efdTabela435Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Efd Tabela 435',
																labelText: 'Código Apuração EFD',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributPisController.tributPisModel.efdTabela435 = text;
																tributPisController.formWasChanged = true;
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
															controller: tributPisController.porcentoBaseCalculoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porcento Base Calculo',
																labelText: 'Porcento Base Cálculo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributPisController.tributPisModel.porcentoBaseCalculo = tributPisController.porcentoBaseCalculoController.numberValue;
																tributPisController.formWasChanged = true;
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
															controller: tributPisController.aliquotaPorcentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Porcento',
																labelText: 'Alíquota Porcento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributPisController.tributPisModel.aliquotaPorcento = tributPisController.aliquotaPorcentoController.numberValue;
																tributPisController.formWasChanged = true;
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
															controller: tributPisController.aliquotaUnidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Unidade',
																labelText: 'Alíquota Unidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributPisController.tributPisModel.aliquotaUnidade = tributPisController.aliquotaUnidadeController.numberValue;
																tributPisController.formWasChanged = true;
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
															controller: tributPisController.valorPrecoMaximoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Preco Maximo',
																labelText: 'Valor Preço Máximo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributPisController.tributPisModel.valorPrecoMaximo = tributPisController.valorPrecoMaximoController.numberValue;
																tributPisController.formWasChanged = true;
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
															controller: tributPisController.valorPautaFiscalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Pauta Fiscal',
																labelText: 'Valor Pauta Fiscal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributPisController.tributPisModel.valorPautaFiscal = tributPisController.valorPautaFiscalController.numberValue;
																tributPisController.formWasChanged = true;
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
