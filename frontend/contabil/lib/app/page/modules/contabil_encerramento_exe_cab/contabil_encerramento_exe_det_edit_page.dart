import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/contabil_encerramento_exe_det_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class ContabilEncerramentoExeDetEditPage extends StatelessWidget {
	ContabilEncerramentoExeDetEditPage({Key? key}) : super(key: key);
	final contabilEncerramentoExeDetController = Get.find<ContabilEncerramentoExeDetController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: contabilEncerramentoExeDetController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Detalhes - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: contabilEncerramentoExeDetController.save),
						cancelAndExitButton(onPressed: contabilEncerramentoExeDetController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contabilEncerramentoExeDetController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contabilEncerramentoExeDetController.scrollController,
							child: SingleChildScrollView(
								controller: contabilEncerramentoExeDetController.scrollController,
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
																		controller: contabilEncerramentoExeDetController.contabilContaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Conta Contábil',
																			labelText: 'Conta Contábil *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: contabilEncerramentoExeDetController.callContabilContaLookup),
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: contabilEncerramentoExeDetController.saldoAnteriorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saldo Anterior',
																labelText: 'Saldo Anterior',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilEncerramentoExeDetController.contabilEncerramentoExeDetModel.saldoAnterior = contabilEncerramentoExeDetController.saldoAnteriorController.numberValue;
																contabilEncerramentoExeDetController.formWasChanged = true;
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
															controller: contabilEncerramentoExeDetController.valorDebitoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Debito',
																labelText: 'Valor Debito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilEncerramentoExeDetController.contabilEncerramentoExeDetModel.valorDebito = contabilEncerramentoExeDetController.valorDebitoController.numberValue;
																contabilEncerramentoExeDetController.formWasChanged = true;
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
															controller: contabilEncerramentoExeDetController.valorCreditoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Credito',
																labelText: 'Valor Credito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilEncerramentoExeDetController.contabilEncerramentoExeDetModel.valorCredito = contabilEncerramentoExeDetController.valorCreditoController.numberValue;
																contabilEncerramentoExeDetController.formWasChanged = true;
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
															controller: contabilEncerramentoExeDetController.saldoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saldo',
																labelText: 'Saldo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilEncerramentoExeDetController.contabilEncerramentoExeDetModel.saldo = contabilEncerramentoExeDetController.saldoController.numberValue;
																contabilEncerramentoExeDetController.formWasChanged = true;
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
