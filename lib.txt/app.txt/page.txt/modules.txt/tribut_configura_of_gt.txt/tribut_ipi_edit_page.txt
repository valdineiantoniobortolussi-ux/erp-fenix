import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:tributacao/app/controller/tribut_ipi_controller.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/page/shared_widget/input/input_imports.dart';

class TributIpiEditPage extends StatelessWidget {
	TributIpiEditPage({Key? key}) : super(key: key);
	final tributIpiController = Get.find<TributIpiController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: tributIpiController.scaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: tributIpiController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: tributIpiController.scrollController,
							child: SingleChildScrollView(
								controller: tributIpiController.scrollController,
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
														child: CustomDropdownButtonFormField(
															value: tributIpiController.tributIpiModel.cstIpi ?? '00',
															labelText: 'CST',
															hintText: 'Informe os dados para o campo Cst Ipi',
															items: const ['00','10','20','30','40','41','50','51','60','70','90'],
															onChanged: (dynamic newValue) {
																tributIpiController.tributIpiModel.cstIpi = newValue;
																tributIpiController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributIpiController.tributIpiModel.modalidadeBaseCalculo ?? '0-Percentual',
															labelText: 'Modalidade Base Cálculo',
															hintText: 'Informe os dados para o campo Modalidade Base Calculo',
															items: const ['0-Percentual','1-Unidade'],
															onChanged: (dynamic newValue) {
																tributIpiController.tributIpiModel.modalidadeBaseCalculo = newValue;
																tributIpiController.formWasChanged = true;
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
															controller: tributIpiController.porcentoBaseCalculoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porcento Base Calculo',
																labelText: 'Porcento Base Cálculo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIpiController.tributIpiModel.porcentoBaseCalculo = tributIpiController.porcentoBaseCalculoController.numberValue;
																tributIpiController.formWasChanged = true;
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
															controller: tributIpiController.aliquotaPorcentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Porcento',
																labelText: 'Alíquota Porcento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIpiController.tributIpiModel.aliquotaPorcento = tributIpiController.aliquotaPorcentoController.numberValue;
																tributIpiController.formWasChanged = true;
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
															controller: tributIpiController.aliquotaUnidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Unidade',
																labelText: 'Alíquota Unidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIpiController.tributIpiModel.aliquotaUnidade = tributIpiController.aliquotaUnidadeController.numberValue;
																tributIpiController.formWasChanged = true;
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
															controller: tributIpiController.valorPrecoMaximoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Preco Maximo',
																labelText: 'Valor Preço Máximo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIpiController.tributIpiModel.valorPrecoMaximo = tributIpiController.valorPrecoMaximoController.numberValue;
																tributIpiController.formWasChanged = true;
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
															controller: tributIpiController.valorPautaFiscalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Pauta Fiscal',
																labelText: 'Valor Pauta Fiscal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIpiController.tributIpiModel.valorPautaFiscal = tributIpiController.valorPautaFiscalController.numberValue;
																tributIpiController.formWasChanged = true;
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
