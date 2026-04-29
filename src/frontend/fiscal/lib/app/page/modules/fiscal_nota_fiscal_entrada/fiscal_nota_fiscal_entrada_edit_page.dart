import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:fiscal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:fiscal/app/controller/fiscal_nota_fiscal_entrada_controller.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/page/shared_widget/input/input_imports.dart';

class FiscalNotaFiscalEntradaEditPage extends StatelessWidget {
	FiscalNotaFiscalEntradaEditPage({Key? key}) : super(key: key);
	final fiscalNotaFiscalEntradaController = Get.find<FiscalNotaFiscalEntradaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					fiscalNotaFiscalEntradaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: fiscalNotaFiscalEntradaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Registro de Entradas - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: fiscalNotaFiscalEntradaController.save),
						cancelAndExitButton(onPressed: fiscalNotaFiscalEntradaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: fiscalNotaFiscalEntradaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: fiscalNotaFiscalEntradaController.scrollController,
							child: SingleChildScrollView(
								controller: fiscalNotaFiscalEntradaController.scrollController,
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
																		controller: fiscalNotaFiscalEntradaController.nfeCabecalhoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Nfe Cabecalho',
																			labelText: 'NFe Cabecalho *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: fiscalNotaFiscalEntradaController.callNfeCabecalhoLookup),
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: fiscalNotaFiscalEntradaController.competenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Competencia',
																labelText: 'Competencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.competencia = text;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.cfopEntradaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cfop Entrada',
																labelText: 'Cfop Entrada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.cfopEntrada = int.tryParse(text);
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.valorRateioFreteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Rateio Frete',
																labelText: 'Valor Rateio Frete',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.valorRateioFrete = fiscalNotaFiscalEntradaController.valorRateioFreteController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.valorCustoMedioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Custo Medio',
																labelText: 'Valor Custo Medio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.valorCustoMedio = fiscalNotaFiscalEntradaController.valorCustoMedioController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.valorIcmsAntecipadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms Antecipado',
																labelText: 'Valor Icms Antecipado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.valorIcmsAntecipado = fiscalNotaFiscalEntradaController.valorIcmsAntecipadoController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.valorBcIcmsAntecipadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Icms Antecipado',
																labelText: 'Valor Bc Icms Antecipado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.valorBcIcmsAntecipado = fiscalNotaFiscalEntradaController.valorBcIcmsAntecipadoController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.valorBcIcmsCreditadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Icms Creditado',
																labelText: 'Valor Bc Icms Creditado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.valorBcIcmsCreditado = fiscalNotaFiscalEntradaController.valorBcIcmsCreditadoController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.valorBcPisCreditadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Pis Creditado',
																labelText: 'Valor Bc Pis Creditado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.valorBcPisCreditado = fiscalNotaFiscalEntradaController.valorBcPisCreditadoController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.valorBcCofinsCreditadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Cofins Creditado',
																labelText: 'Valor Bc Cofins Creditado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.valorBcCofinsCreditado = fiscalNotaFiscalEntradaController.valorBcCofinsCreditadoController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.valorBcIpiCreditadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Ipi Creditado',
																labelText: 'Valor Bc Ipi Creditado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.valorBcIpiCreditado = fiscalNotaFiscalEntradaController.valorBcIpiCreditadoController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															maxLength: 3,
															controller: fiscalNotaFiscalEntradaController.cstCreditoIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cst Credito Icms',
																labelText: 'Cst Credito Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.cstCreditoIcms = text;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.cstCreditoPisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cst Credito Pis',
																labelText: 'Cst Credito Pis',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.cstCreditoPis = text;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.cstCreditoCofinsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cst Credito Cofins',
																labelText: 'Cst Credito Cofins',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.cstCreditoCofins = text;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.cstCreditoIpiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cst Credito Ipi',
																labelText: 'Cst Credito Ipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.cstCreditoIpi = text;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.valorIcmsCreditadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms Creditado',
																labelText: 'Valor Icms Creditado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.valorIcmsCreditado = fiscalNotaFiscalEntradaController.valorIcmsCreditadoController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.valorPisCreditadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Pis Creditado',
																labelText: 'Valor Pis Creditado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.valorPisCreditado = fiscalNotaFiscalEntradaController.valorPisCreditadoController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.valorCofinsCreditadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Cofins Creditado',
																labelText: 'Valor Cofins Creditado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.valorCofinsCreditado = fiscalNotaFiscalEntradaController.valorCofinsCreditadoController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.valorIpiCreditadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Ipi Creditado',
																labelText: 'Valor Ipi Creditado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.valorIpiCreditado = fiscalNotaFiscalEntradaController.valorIpiCreditadoController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.qtdeParcelaCreditoPisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Qtde Parcela Credito Pis',
																labelText: 'Qtde Parcela Credito Pis',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.qtdeParcelaCreditoPis = int.tryParse(text);
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.qtdeParcelaCreditoCofinsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Qtde Parcela Credito Cofins',
																labelText: 'Qtde Parcela Credito Cofins',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.qtdeParcelaCreditoCofins = int.tryParse(text);
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.qtdeParcelaCreditoIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Qtde Parcela Credito Icms',
																labelText: 'Qtde Parcela Credito Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.qtdeParcelaCreditoIcms = int.tryParse(text);
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.qtdeParcelaCreditoIpiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Qtde Parcela Credito Ipi',
																labelText: 'Qtde Parcela Credito Ipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.qtdeParcelaCreditoIpi = int.tryParse(text);
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.aliquotaCreditoIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Credito Icms',
																labelText: 'Aliquota Credito Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.aliquotaCreditoIcms = fiscalNotaFiscalEntradaController.aliquotaCreditoIcmsController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.aliquotaCreditoPisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Credito Pis',
																labelText: 'Aliquota Credito Pis',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.aliquotaCreditoPis = fiscalNotaFiscalEntradaController.aliquotaCreditoPisController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.aliquotaCreditoCofinsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Credito Cofins',
																labelText: 'Aliquota Credito Cofins',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.aliquotaCreditoCofins = fiscalNotaFiscalEntradaController.aliquotaCreditoCofinsController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
															controller: fiscalNotaFiscalEntradaController.aliquotaCreditoIpiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Credito Ipi',
																labelText: 'Aliquota Credito Ipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalNotaFiscalEntradaController.fiscalNotaFiscalEntradaModel.aliquotaCreditoIpi = fiscalNotaFiscalEntradaController.aliquotaCreditoIpiController.numberValue;
																fiscalNotaFiscalEntradaController.formWasChanged = true;
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
			),
		);
	}
}
