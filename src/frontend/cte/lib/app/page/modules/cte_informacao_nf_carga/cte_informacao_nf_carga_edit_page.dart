import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_informacao_nf_carga_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteInformacaoNfCargaEditPage extends StatelessWidget {
	CteInformacaoNfCargaEditPage({Key? key}) : super(key: key);
	final cteInformacaoNfCargaController = Get.find<CteInformacaoNfCargaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					cteInformacaoNfCargaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: cteInformacaoNfCargaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Cte Informacao Nf Carga - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteInformacaoNfCargaController.save),
						cancelAndExitButton(onPressed: cteInformacaoNfCargaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteInformacaoNfCargaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteInformacaoNfCargaController.scrollController,
							child: SingleChildScrollView(
								controller: cteInformacaoNfCargaController.scrollController,
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
																		controller: cteInformacaoNfCargaController.cteInformacaoNfOutrosModelController,
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
																child: lookupButton(onPressed: cteInformacaoNfCargaController.callCteInformacaoNfOutrosLookup),
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
															value: cteInformacaoNfCargaController.cteInformacaoNfCargaModel.tipoUnidadeCarga ?? 'AAA',
															labelText: 'Tipo Unidade Carga',
															hintText: 'Informe os dados para o campo Tipo Unidade Carga',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteInformacaoNfCargaController.cteInformacaoNfCargaModel.tipoUnidadeCarga = newValue;
																cteInformacaoNfCargaController.formWasChanged = true;
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
															controller: cteInformacaoNfCargaController.idUnidadeCargaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Unidade Carga',
																labelText: 'Id Unidade Carga',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfCargaController.cteInformacaoNfCargaModel.idUnidadeCarga = text;
																cteInformacaoNfCargaController.formWasChanged = true;
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
