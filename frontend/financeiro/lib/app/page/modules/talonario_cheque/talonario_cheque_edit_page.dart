import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro/app/controller/talonario_cheque_controller.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/page/shared_widget/input/input_imports.dart';

class TalonarioChequeEditPage extends StatelessWidget {
	TalonarioChequeEditPage({Key? key}) : super(key: key);
	final talonarioChequeController = Get.find<TalonarioChequeController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: talonarioChequeController.talonarioChequeEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: talonarioChequeController.talonarioChequeEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: talonarioChequeController.scrollController,
							child: SingleChildScrollView(
								controller: talonarioChequeController.scrollController,
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
																		controller: talonarioChequeController.bancoContaCaixaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Conta/Caixa',
																			labelText: 'Conta/Caixa *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: talonarioChequeController.callBancoContaCaixaLookup),
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
															maxLength: 10,
															controller: talonarioChequeController.talaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Talao',
																labelText: 'Talao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																talonarioChequeController.talonarioChequeModel.talao = text;
																talonarioChequeController.formWasChanged = true;
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
															controller: talonarioChequeController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																talonarioChequeController.talonarioChequeModel.numero = int.tryParse(text);
																talonarioChequeController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: talonarioChequeController.talonarioChequeModel.statusTalao ?? 'Normal',
															labelText: 'Status',
															hintText: 'Informe os dados para o campo Status Talao',
															items: const ['Normal','Cancelado','Extraviado','Utilizado'],
															onChanged: (dynamic newValue) {
																talonarioChequeController.talonarioChequeModel.statusTalao = newValue;
																talonarioChequeController.formWasChanged = true;
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
