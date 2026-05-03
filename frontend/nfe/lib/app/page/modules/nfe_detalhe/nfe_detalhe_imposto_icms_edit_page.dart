import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_detalhe_imposto_icms_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeDetalheImpostoIcmsEditPage extends StatelessWidget {
	NfeDetalheImpostoIcmsEditPage({Key? key}) : super(key: key);
	final nfeDetalheImpostoIcmsController = Get.find<NfeDetalheImpostoIcmsController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeDetalheImpostoIcmsController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('ICMS - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeDetalheImpostoIcmsController.save),
						cancelAndExitButton(onPressed: nfeDetalheImpostoIcmsController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeDetalheImpostoIcmsController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeDetalheImpostoIcmsController.scrollController,
							child: SingleChildScrollView(
								controller: nfeDetalheImpostoIcmsController.scrollController,
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
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.origemMercadoria ?? 'AAA',
															labelText: 'Origem Mercadoria',
															hintText: 'Informe os dados para o campo Origem Mercadoria',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.origemMercadoria = newValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.cstIcms ?? 'AAA',
															labelText: 'Cst Icms',
															hintText: 'Informe os dados para o campo Cst Icms',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.cstIcms = newValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.csosn ?? 'AAA',
															labelText: 'Csosn',
															hintText: 'Informe os dados para o campo Csosn',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.csosn = newValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.modalidadeBcIcms ?? 'AAA',
															labelText: 'Modalidade Bc Icms',
															hintText: 'Informe os dados para o campo Modalidade Bc Icms',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.modalidadeBcIcms = newValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.percentualReducaoBcIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Reducao Bc Icms',
																labelText: 'Percentual Reducao Bc Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.percentualReducaoBcIcms = nfeDetalheImpostoIcmsController.percentualReducaoBcIcmsController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorBcIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Icms',
																labelText: 'Valor Bc Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorBcIcms = nfeDetalheImpostoIcmsController.valorBcIcmsController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.aliquotaIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Icms',
																labelText: 'Aliquota Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.aliquotaIcms = nfeDetalheImpostoIcmsController.aliquotaIcmsController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorIcmsOperacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms Operacao',
																labelText: 'Valor Icms Operacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorIcmsOperacao = nfeDetalheImpostoIcmsController.valorIcmsOperacaoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.percentualDiferimentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Diferimento',
																labelText: 'Percentual Diferimento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.percentualDiferimento = nfeDetalheImpostoIcmsController.percentualDiferimentoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorIcmsDiferidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms Diferido',
																labelText: 'Valor Icms Diferido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorIcmsDiferido = nfeDetalheImpostoIcmsController.valorIcmsDiferidoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms',
																labelText: 'Valor Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorIcms = nfeDetalheImpostoIcmsController.valorIcmsController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.baseCalculoFcpController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Fcp',
																labelText: 'Base Calculo Fcp',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.baseCalculoFcp = nfeDetalheImpostoIcmsController.baseCalculoFcpController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.percentualFcpController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Fcp',
																labelText: 'Percentual Fcp',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.percentualFcp = nfeDetalheImpostoIcmsController.percentualFcpController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorFcpController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Fcp',
																labelText: 'Valor Fcp',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorFcp = nfeDetalheImpostoIcmsController.valorFcpController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.modalidadeBcIcmsSt ?? 'AAA',
															labelText: 'Modalidade Bc Icms St',
															hintText: 'Informe os dados para o campo Modalidade Bc Icms St',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.modalidadeBcIcmsSt = newValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.percentualMvaIcmsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Mva Icms St',
																labelText: 'Percentual Mva Icms St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.percentualMvaIcmsSt = nfeDetalheImpostoIcmsController.percentualMvaIcmsStController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.percentualReducaoBcIcmsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Reducao Bc Icms St',
																labelText: 'Percentual Reducao Bc Icms St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.percentualReducaoBcIcmsSt = nfeDetalheImpostoIcmsController.percentualReducaoBcIcmsStController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorBaseCalculoIcmsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Base Calculo Icms St',
																labelText: 'Valor Base Calculo Icms St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorBaseCalculoIcmsSt = nfeDetalheImpostoIcmsController.valorBaseCalculoIcmsStController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.aliquotaIcmsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Icms St',
																labelText: 'Aliquota Icms St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.aliquotaIcmsSt = nfeDetalheImpostoIcmsController.aliquotaIcmsStController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorIcmsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms St',
																labelText: 'Valor Icms St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorIcmsSt = nfeDetalheImpostoIcmsController.valorIcmsStController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.baseCalculoFcpStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Fcp St',
																labelText: 'Base Calculo Fcp St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.baseCalculoFcpSt = nfeDetalheImpostoIcmsController.baseCalculoFcpStController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.percentualFcpStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Fcp St',
																labelText: 'Percentual Fcp St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.percentualFcpSt = nfeDetalheImpostoIcmsController.percentualFcpStController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorFcpStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Fcp St',
																labelText: 'Valor Fcp St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorFcpSt = nfeDetalheImpostoIcmsController.valorFcpStController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.ufSt ?? 'AC',
															labelText: 'Uf St',
															hintText: 'Informe os dados para o campo Uf St',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.ufSt = newValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.percentualBcOperacaoPropriaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Bc Operacao Propria',
																labelText: 'Percentual Bc Operacao Propria',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.percentualBcOperacaoPropria = nfeDetalheImpostoIcmsController.percentualBcOperacaoPropriaController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorBcIcmsStRetidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Icms St Retido',
																labelText: 'Valor Bc Icms St Retido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorBcIcmsStRetido = nfeDetalheImpostoIcmsController.valorBcIcmsStRetidoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.aliquotaSuportadaConsumidorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Suportada Consumidor',
																labelText: 'Aliquota Suportada Consumidor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.aliquotaSuportadaConsumidor = nfeDetalheImpostoIcmsController.aliquotaSuportadaConsumidorController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorIcmsSubstitutoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms Substituto',
																labelText: 'Valor Icms Substituto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorIcmsSubstituto = nfeDetalheImpostoIcmsController.valorIcmsSubstitutoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorIcmsStRetidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms St Retido',
																labelText: 'Valor Icms St Retido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorIcmsStRetido = nfeDetalheImpostoIcmsController.valorIcmsStRetidoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.baseCalculoFcpStRetidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Fcp St Retido',
																labelText: 'Base Calculo Fcp St Retido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.baseCalculoFcpStRetido = nfeDetalheImpostoIcmsController.baseCalculoFcpStRetidoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.percentualFcpStRetidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Fcp St Retido',
																labelText: 'Percentual Fcp St Retido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.percentualFcpStRetido = nfeDetalheImpostoIcmsController.percentualFcpStRetidoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorFcpStRetidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Fcp St Retido',
																labelText: 'Valor Fcp St Retido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorFcpStRetido = nfeDetalheImpostoIcmsController.valorFcpStRetidoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.motivoDesoneracaoIcms ?? 'AAA',
															labelText: 'Motivo Desoneracao Icms',
															hintText: 'Informe os dados para o campo Motivo Desoneracao Icms',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.motivoDesoneracaoIcms = newValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorIcmsDesoneradoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms Desonerado',
																labelText: 'Valor Icms Desonerado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorIcmsDesonerado = nfeDetalheImpostoIcmsController.valorIcmsDesoneradoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.aliquotaCreditoIcmsSnController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Credito Icms Sn',
																labelText: 'Aliquota Credito Icms Sn',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.aliquotaCreditoIcmsSn = nfeDetalheImpostoIcmsController.aliquotaCreditoIcmsSnController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorCreditoIcmsSnController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Credito Icms Sn',
																labelText: 'Valor Credito Icms Sn',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorCreditoIcmsSn = nfeDetalheImpostoIcmsController.valorCreditoIcmsSnController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorBcIcmsStDestinoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Icms St Destino',
																labelText: 'Valor Bc Icms St Destino',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorBcIcmsStDestino = nfeDetalheImpostoIcmsController.valorBcIcmsStDestinoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorIcmsStDestinoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms St Destino',
																labelText: 'Valor Icms St Destino',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorIcmsStDestino = nfeDetalheImpostoIcmsController.valorIcmsStDestinoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.percentualReducaoBcEfetivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Reducao Bc Efetivo',
																labelText: 'Percentual Reducao Bc Efetivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.percentualReducaoBcEfetivo = nfeDetalheImpostoIcmsController.percentualReducaoBcEfetivoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorBcEfetivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Efetivo',
																labelText: 'Valor Bc Efetivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorBcEfetivo = nfeDetalheImpostoIcmsController.valorBcEfetivoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.aliquotaIcmsEfetivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Icms Efetivo',
																labelText: 'Aliquota Icms Efetivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.aliquotaIcmsEfetivo = nfeDetalheImpostoIcmsController.aliquotaIcmsEfetivoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsController.valorIcmsEfetivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms Efetivo',
																labelText: 'Valor Icms Efetivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsController.nfeDetalheImpostoIcmsModel.valorIcmsEfetivo = nfeDetalheImpostoIcmsController.valorIcmsEfetivoController.numberValue;
																nfeDetalheImpostoIcmsController.formWasChanged = true;
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
