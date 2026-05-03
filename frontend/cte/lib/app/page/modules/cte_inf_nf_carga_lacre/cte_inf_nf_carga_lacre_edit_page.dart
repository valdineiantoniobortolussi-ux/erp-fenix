import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_inf_nf_carga_lacre_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteInfNfCargaLacreEditPage extends StatelessWidget {
	CteInfNfCargaLacreEditPage({Key? key}) : super(key: key);
	final cteInfNfCargaLacreController = Get.find<CteInfNfCargaLacreController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					cteInfNfCargaLacreController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: cteInfNfCargaLacreController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Cte Inf Nf Carga Lacre - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteInfNfCargaLacreController.save),
						cancelAndExitButton(onPressed: cteInfNfCargaLacreController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteInfNfCargaLacreController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteInfNfCargaLacreController.scrollController,
							child: SingleChildScrollView(
								controller: cteInfNfCargaLacreController.scrollController,
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
																		controller: cteInfNfCargaLacreController.cteInformacaoNfCargaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Cte Informacao Nf Carga',
																			labelText: 'Id Cte Informacao Nf Carga *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: cteInfNfCargaLacreController.callCteInformacaoNfCargaLookup),
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 20,
															controller: cteInfNfCargaLacreController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInfNfCargaLacreController.cteInfNfCargaLacreModel.numero = text;
																cteInfNfCargaLacreController.formWasChanged = true;
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
															controller: cteInfNfCargaLacreController.quantidadeRateadaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Rateada',
																labelText: 'Quantidade Rateada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInfNfCargaLacreController.cteInfNfCargaLacreModel.quantidadeRateada = cteInfNfCargaLacreController.quantidadeRateadaController.numberValue;
																cteInfNfCargaLacreController.formWasChanged = true;
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
