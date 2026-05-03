import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:tributacao/app/page/shared_widget/shared_widget_imports.dart';
import 'package:tributacao/app/controller/tribut_icms_custom_det_controller.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/page/shared_widget/input/input_imports.dart';

class TributIcmsCustomDetEditPage extends StatelessWidget {
	TributIcmsCustomDetEditPage({Key? key}) : super(key: key);
	final tributIcmsCustomDetController = Get.find<TributIcmsCustomDetController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: tributIcmsCustomDetController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tribut Icms Custom Det - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: tributIcmsCustomDetController.save),
						cancelAndExitButton(onPressed: tributIcmsCustomDetController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: tributIcmsCustomDetController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: tributIcmsCustomDetController.scrollController,
							child: SingleChildScrollView(
								controller: tributIcmsCustomDetController.scrollController,
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
															value: tributIcmsCustomDetController.tributIcmsCustomDetModel.ufDestino ?? 'AC',
															labelText: 'Uf Destino',
															hintText: 'Informe os dados para o campo Uf Destino',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.ufDestino = newValue;
																tributIcmsCustomDetController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributIcmsCustomDetController.tributIcmsCustomDetModel.cst ?? '00',
															labelText: 'CST',
															hintText: 'Informe os dados para o campo Cst',
															items: const ['00','10','20','30','40','41','50','51','60','70','90'],
															onChanged: (dynamic newValue) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.cst = newValue;
																tributIcmsCustomDetController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributIcmsCustomDetController.tributIcmsCustomDetModel.csosn ?? '101',
															labelText: 'CSOSN',
															hintText: 'Informe os dados para o campo Csosn',
															items: const ['101','102','103','201','202','203','300','400','500','900'],
															onChanged: (dynamic newValue) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.csosn = newValue;
																tributIcmsCustomDetController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributIcmsCustomDetController.tributIcmsCustomDetModel.modalidadeBc ?? '0-Margem Valor Agregado',
															labelText: 'Modalidade BC',
															hintText: 'Informe os dados para o campo Modalidade Bc',
															items: const ['0-Margem Valor Agregado','1-Valor Pauta','2-Valor Preço Máximo','3-Valor da Operação'],
															onChanged: (dynamic newValue) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.modalidadeBc = newValue;
																tributIcmsCustomDetController.formWasChanged = true;
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
															controller: tributIcmsCustomDetController.cfopController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cfop',
																labelText: 'CFOP',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.cfop = int.tryParse(text);
																tributIcmsCustomDetController.formWasChanged = true;
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
															controller: tributIcmsCustomDetController.aliquotaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota',
																labelText: 'Alíquota',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.aliquota = tributIcmsCustomDetController.aliquotaController.numberValue;
																tributIcmsCustomDetController.formWasChanged = true;
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
															controller: tributIcmsCustomDetController.valorPautaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Pauta',
																labelText: 'Valor Pauta',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.valorPauta = tributIcmsCustomDetController.valorPautaController.numberValue;
																tributIcmsCustomDetController.formWasChanged = true;
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
															controller: tributIcmsCustomDetController.valorPrecoMaximoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Preco Maximo',
																labelText: 'Valor Preço Máximo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.valorPrecoMaximo = tributIcmsCustomDetController.valorPrecoMaximoController.numberValue;
																tributIcmsCustomDetController.formWasChanged = true;
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
															controller: tributIcmsCustomDetController.mvaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Mva',
																labelText: 'MVA',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.mva = tributIcmsCustomDetController.mvaController.numberValue;
																tributIcmsCustomDetController.formWasChanged = true;
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
															controller: tributIcmsCustomDetController.porcentoBcController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porcento Bc',
																labelText: 'Porcento BC',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.porcentoBc = tributIcmsCustomDetController.porcentoBcController.numberValue;
																tributIcmsCustomDetController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributIcmsCustomDetController.tributIcmsCustomDetModel.modalidadeBcSt ?? '0-Valor Preço Máximo',
															labelText: 'Modalidade BC ST',
															hintText: 'Informe os dados para o campo Modalidade Bc St',
															items: const ['0-Valor Preço Máximo','1-Valor Lista Negativa','2-Valor Lista Positiva','3-Valor Lista Neutra','4-Margem Valor Agregado','5-Valor Pauta'],
															onChanged: (dynamic newValue) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.modalidadeBcSt = newValue;
																tributIcmsCustomDetController.formWasChanged = true;
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
															controller: tributIcmsCustomDetController.aliquotaInternaStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Interna St',
																labelText: 'Alíquota Interna ST',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.aliquotaInternaSt = tributIcmsCustomDetController.aliquotaInternaStController.numberValue;
																tributIcmsCustomDetController.formWasChanged = true;
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
															controller: tributIcmsCustomDetController.aliquotaInterestadualStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Interestadual St',
																labelText: 'Alíquota Interestadual ST',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.aliquotaInterestadualSt = tributIcmsCustomDetController.aliquotaInterestadualStController.numberValue;
																tributIcmsCustomDetController.formWasChanged = true;
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
															controller: tributIcmsCustomDetController.porcentoBcStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porcento Bc St',
																labelText: 'Porcento BC ST',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.porcentoBcSt = tributIcmsCustomDetController.porcentoBcStController.numberValue;
																tributIcmsCustomDetController.formWasChanged = true;
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
															controller: tributIcmsCustomDetController.aliquotaIcmsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Icms St',
																labelText: 'Alíquota ICMS ST',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.aliquotaIcmsSt = tributIcmsCustomDetController.aliquotaIcmsStController.numberValue;
																tributIcmsCustomDetController.formWasChanged = true;
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
															controller: tributIcmsCustomDetController.valorPautaStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Pauta St',
																labelText: 'Valor Pauta ST',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.valorPautaSt = tributIcmsCustomDetController.valorPautaStController.numberValue;
																tributIcmsCustomDetController.formWasChanged = true;
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
															controller: tributIcmsCustomDetController.valorPrecoMaximoStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Preco Maximo St',
																labelText: 'Valor Preço Máximo ST',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsCustomDetController.tributIcmsCustomDetModel.valorPrecoMaximoSt = tributIcmsCustomDetController.valorPrecoMaximoStController.numberValue;
																tributIcmsCustomDetController.formWasChanged = true;
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
