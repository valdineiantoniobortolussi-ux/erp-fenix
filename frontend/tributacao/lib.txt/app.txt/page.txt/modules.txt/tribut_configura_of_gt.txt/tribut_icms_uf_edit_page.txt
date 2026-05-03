import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:tributacao/app/page/shared_widget/shared_widget_imports.dart';
import 'package:tributacao/app/controller/tribut_icms_uf_controller.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/page/shared_widget/input/input_imports.dart';

class TributIcmsUfEditPage extends StatelessWidget {
	TributIcmsUfEditPage({Key? key}) : super(key: key);
	final tributIcmsUfController = Get.find<TributIcmsUfController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: tributIcmsUfController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tribut Icms Uf - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: tributIcmsUfController.save),
						cancelAndExitButton(onPressed: tributIcmsUfController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: tributIcmsUfController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: tributIcmsUfController.scrollController,
							child: SingleChildScrollView(
								controller: tributIcmsUfController.scrollController,
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
															value: tributIcmsUfController.tributIcmsUfModel.ufDestino ?? 'AC',
															labelText: 'UF Destino',
															hintText: 'Informe os dados para o campo Uf Destino',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																tributIcmsUfController.tributIcmsUfModel.ufDestino = newValue;
																tributIcmsUfController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributIcmsUfController.tributIcmsUfModel.cst ?? '00',
															labelText: 'CST',
															hintText: 'Informe os dados para o campo Cst',
															items: const ['00','10','20','30','40','41','50','51','60','70','90'],
															onChanged: (dynamic newValue) {
																tributIcmsUfController.tributIcmsUfModel.cst = newValue;
																tributIcmsUfController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributIcmsUfController.tributIcmsUfModel.csosn ?? '101',
															labelText: 'CSOSN',
															hintText: 'Informe os dados para o campo Csosn',
															items: const ['101','102','103','201','202','203','300','400','500','900'],
															onChanged: (dynamic newValue) {
																tributIcmsUfController.tributIcmsUfModel.csosn = newValue;
																tributIcmsUfController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributIcmsUfController.tributIcmsUfModel.modalidadeBc ?? '0-Margem Valor Agregado',
															labelText: 'Modalidade BC',
															hintText: 'Informe os dados para o campo Modalidade Bc',
															items: const ['0-Margem Valor Agregado','1-Valor Pauta','2-Valor Preço Máximo','3-Valor da Operação'],
															onChanged: (dynamic newValue) {
																tributIcmsUfController.tributIcmsUfModel.modalidadeBc = newValue;
																tributIcmsUfController.formWasChanged = true;
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
															controller: tributIcmsUfController.cfopController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cfop',
																labelText: 'CFOP',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsUfController.tributIcmsUfModel.cfop = int.tryParse(text);
																tributIcmsUfController.formWasChanged = true;
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
															controller: tributIcmsUfController.aliquotaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota',
																labelText: 'Alíquota',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsUfController.tributIcmsUfModel.aliquota = tributIcmsUfController.aliquotaController.numberValue;
																tributIcmsUfController.formWasChanged = true;
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
															controller: tributIcmsUfController.valorPautaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Pauta',
																labelText: 'Valor Pauta',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsUfController.tributIcmsUfModel.valorPauta = tributIcmsUfController.valorPautaController.numberValue;
																tributIcmsUfController.formWasChanged = true;
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
															controller: tributIcmsUfController.valorPrecoMaximoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Preco Maximo',
																labelText: 'Valor Preço Máximo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsUfController.tributIcmsUfModel.valorPrecoMaximo = tributIcmsUfController.valorPrecoMaximoController.numberValue;
																tributIcmsUfController.formWasChanged = true;
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
															controller: tributIcmsUfController.mvaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Mva',
																labelText: 'MVA',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsUfController.tributIcmsUfModel.mva = tributIcmsUfController.mvaController.numberValue;
																tributIcmsUfController.formWasChanged = true;
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
															controller: tributIcmsUfController.porcentoBcController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porcento Bc',
																labelText: 'Porcento BC',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsUfController.tributIcmsUfModel.porcentoBc = tributIcmsUfController.porcentoBcController.numberValue;
																tributIcmsUfController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributIcmsUfController.tributIcmsUfModel.modalidadeBcSt ?? '0-Valor Preço Máximo',
															labelText: 'Modalidade BC ST',
															hintText: 'Informe os dados para o campo Modalidade Bc St',
															items: const ['0-Valor Preço Máximo','1-Valor Lista Negativa','2-Valor Lista Positiva','3-Valor Lista Neutra','4-Margem Valor Agregado','5-Valor Pauta'],
															onChanged: (dynamic newValue) {
																tributIcmsUfController.tributIcmsUfModel.modalidadeBcSt = newValue;
																tributIcmsUfController.formWasChanged = true;
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
															controller: tributIcmsUfController.aliquotaInternaStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Interna St',
																labelText: 'Alíquota Interna ST',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsUfController.tributIcmsUfModel.aliquotaInternaSt = tributIcmsUfController.aliquotaInternaStController.numberValue;
																tributIcmsUfController.formWasChanged = true;
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
															controller: tributIcmsUfController.aliquotaInterestadualStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Interestadual St',
																labelText: 'Alíquota Interestadual ST',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsUfController.tributIcmsUfModel.aliquotaInterestadualSt = tributIcmsUfController.aliquotaInterestadualStController.numberValue;
																tributIcmsUfController.formWasChanged = true;
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
															controller: tributIcmsUfController.porcentoBcStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porcento Bc St',
																labelText: 'Porcento BC ST',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsUfController.tributIcmsUfModel.porcentoBcSt = tributIcmsUfController.porcentoBcStController.numberValue;
																tributIcmsUfController.formWasChanged = true;
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
															controller: tributIcmsUfController.aliquotaIcmsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Icms St',
																labelText: 'Alíquota ICMS ST',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsUfController.tributIcmsUfModel.aliquotaIcmsSt = tributIcmsUfController.aliquotaIcmsStController.numberValue;
																tributIcmsUfController.formWasChanged = true;
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
															controller: tributIcmsUfController.valorPautaStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Pauta St',
																labelText: 'Valor Pauta ST',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsUfController.tributIcmsUfModel.valorPautaSt = tributIcmsUfController.valorPautaStController.numberValue;
																tributIcmsUfController.formWasChanged = true;
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
															controller: tributIcmsUfController.valorPrecoMaximoStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Preco Maximo St',
																labelText: 'Valor Preço Máximo ST',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIcmsUfController.tributIcmsUfModel.valorPrecoMaximoSt = tributIcmsUfController.valorPrecoMaximoStController.numberValue;
																tributIcmsUfController.formWasChanged = true;
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
