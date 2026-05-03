import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_informacao_nf_transporte_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteInformacaoNfTransporteEditPage extends StatelessWidget {
	CteInformacaoNfTransporteEditPage({Key? key}) : super(key: key);
	final cteInformacaoNfTransporteController = Get.find<CteInformacaoNfTransporteController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					cteInformacaoNfTransporteController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: cteInformacaoNfTransporteController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Cte Informacao Nf Transporte - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteInformacaoNfTransporteController.save),
						cancelAndExitButton(onPressed: cteInformacaoNfTransporteController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteInformacaoNfTransporteController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteInformacaoNfTransporteController.scrollController,
							child: SingleChildScrollView(
								controller: cteInformacaoNfTransporteController.scrollController,
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
																		controller: cteInformacaoNfTransporteController.cteInformacaoNfOutrosModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Cte Informacao Nf',
																			labelText: 'Id Cte Informacao Nf *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: cteInformacaoNfTransporteController.callCteInformacaoNfOutrosLookup),
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
														child: CustomDropdownButtonFormField(
															value: cteInformacaoNfTransporteController.cteInformacaoNfTransporteModel.tipoUnidadeTransporte ?? 'AAA',
															labelText: 'Tipo Unidade Transporte',
															hintText: 'Informe os dados para o campo Tipo Unidade Transporte',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteInformacaoNfTransporteController.cteInformacaoNfTransporteModel.tipoUnidadeTransporte = newValue;
																cteInformacaoNfTransporteController.formWasChanged = true;
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
															maxLength: 20,
															controller: cteInformacaoNfTransporteController.idUnidadeTransporteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Unidade Transporte',
																labelText: 'Id Unidade Transporte',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfTransporteController.cteInformacaoNfTransporteModel.idUnidadeTransporte = text;
																cteInformacaoNfTransporteController.formWasChanged = true;
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
