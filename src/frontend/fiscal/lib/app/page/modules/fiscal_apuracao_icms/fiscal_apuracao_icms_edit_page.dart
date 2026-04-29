import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:fiscal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:fiscal/app/controller/fiscal_apuracao_icms_controller.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/page/shared_widget/input/input_imports.dart';

class FiscalApuracaoIcmsEditPage extends StatelessWidget {
	FiscalApuracaoIcmsEditPage({Key? key}) : super(key: key);
	final fiscalApuracaoIcmsController = Get.find<FiscalApuracaoIcmsController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					fiscalApuracaoIcmsController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: fiscalApuracaoIcmsController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Apuração do ICMS - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: fiscalApuracaoIcmsController.save),
						cancelAndExitButton(onPressed: fiscalApuracaoIcmsController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: fiscalApuracaoIcmsController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: fiscalApuracaoIcmsController.scrollController,
							child: SingleChildScrollView(
								controller: fiscalApuracaoIcmsController.scrollController,
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
															controller: fiscalApuracaoIcmsController.competenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Competencia',
																labelText: 'Competencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.competencia = text;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorTotalDebitoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Debito',
																labelText: 'Valor Total Debito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorTotalDebito = fiscalApuracaoIcmsController.valorTotalDebitoController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorAjusteDebitoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Ajuste Debito',
																labelText: 'Valor Ajuste Debito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorAjusteDebito = fiscalApuracaoIcmsController.valorAjusteDebitoController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorTotalAjusteDebitoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Ajuste Debito',
																labelText: 'Valor Total Ajuste Debito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorTotalAjusteDebito = fiscalApuracaoIcmsController.valorTotalAjusteDebitoController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorEstornoCreditoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Estorno Credito',
																labelText: 'Valor Estorno Credito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorEstornoCredito = fiscalApuracaoIcmsController.valorEstornoCreditoController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorTotalCreditoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Credito',
																labelText: 'Valor Total Credito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorTotalCredito = fiscalApuracaoIcmsController.valorTotalCreditoController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorAjusteCreditoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Ajuste Credito',
																labelText: 'Valor Ajuste Credito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorAjusteCredito = fiscalApuracaoIcmsController.valorAjusteCreditoController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorTotalAjusteCreditoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Ajuste Credito',
																labelText: 'Valor Total Ajuste Credito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorTotalAjusteCredito = fiscalApuracaoIcmsController.valorTotalAjusteCreditoController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorEstornoDebitoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Estorno Debito',
																labelText: 'Valor Estorno Debito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorEstornoDebito = fiscalApuracaoIcmsController.valorEstornoDebitoController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorSaldoCredorAnteriorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Saldo Credor Anterior',
																labelText: 'Valor Saldo Credor Anterior',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorSaldoCredorAnterior = fiscalApuracaoIcmsController.valorSaldoCredorAnteriorController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorSaldoApuradoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Saldo Apurado',
																labelText: 'Valor Saldo Apurado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorSaldoApurado = fiscalApuracaoIcmsController.valorSaldoApuradoController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorTotalDeducaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Deducao',
																labelText: 'Valor Total Deducao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorTotalDeducao = fiscalApuracaoIcmsController.valorTotalDeducaoController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorIcmsRecolherController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms Recolher',
																labelText: 'Valor Icms Recolher',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorIcmsRecolher = fiscalApuracaoIcmsController.valorIcmsRecolherController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorSaldoCredorTranspController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Saldo Credor Transp',
																labelText: 'Valor Saldo Credor Transp',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorSaldoCredorTransp = fiscalApuracaoIcmsController.valorSaldoCredorTranspController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
															controller: fiscalApuracaoIcmsController.valorDebitoEspecialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Debito Especial',
																labelText: 'Valor Debito Especial',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalApuracaoIcmsController.fiscalApuracaoIcmsModel.valorDebitoEspecial = fiscalApuracaoIcmsController.valorDebitoEspecialController.numberValue;
																fiscalApuracaoIcmsController.formWasChanged = true;
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
