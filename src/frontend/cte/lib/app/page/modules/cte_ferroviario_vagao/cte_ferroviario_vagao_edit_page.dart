import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_ferroviario_vagao_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteFerroviarioVagaoEditPage extends StatelessWidget {
	CteFerroviarioVagaoEditPage({Key? key}) : super(key: key);
	final cteFerroviarioVagaoController = Get.find<CteFerroviarioVagaoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					cteFerroviarioVagaoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: cteFerroviarioVagaoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Cte Ferroviario Vagao - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteFerroviarioVagaoController.save),
						cancelAndExitButton(onPressed: cteFerroviarioVagaoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteFerroviarioVagaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteFerroviarioVagaoController.scrollController,
							child: SingleChildScrollView(
								controller: cteFerroviarioVagaoController.scrollController,
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
																		controller: cteFerroviarioVagaoController.cteFerroviarioModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Cte Ferroviario',
																			labelText: 'Id Cte Ferroviario *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: cteFerroviarioVagaoController.callCteFerroviarioLookup),
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
															controller: cteFerroviarioVagaoController.numeroVagaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Vagao',
																labelText: 'Numero Vagao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteFerroviarioVagaoController.cteFerroviarioVagaoModel.numeroVagao = int.tryParse(text);
																cteFerroviarioVagaoController.formWasChanged = true;
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
															controller: cteFerroviarioVagaoController.capacidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Capacidade',
																labelText: 'Capacidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteFerroviarioVagaoController.cteFerroviarioVagaoModel.capacidade = cteFerroviarioVagaoController.capacidadeController.numberValue;
																cteFerroviarioVagaoController.formWasChanged = true;
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
															value: cteFerroviarioVagaoController.cteFerroviarioVagaoModel.tipoVagao ?? 'AAA',
															labelText: 'Tipo Vagao',
															hintText: 'Informe os dados para o campo Tipo Vagao',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteFerroviarioVagaoController.cteFerroviarioVagaoModel.tipoVagao = newValue;
																cteFerroviarioVagaoController.formWasChanged = true;
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
															controller: cteFerroviarioVagaoController.pesoRealController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Peso Real',
																labelText: 'Peso Real',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteFerroviarioVagaoController.cteFerroviarioVagaoModel.pesoReal = cteFerroviarioVagaoController.pesoRealController.numberValue;
																cteFerroviarioVagaoController.formWasChanged = true;
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
															controller: cteFerroviarioVagaoController.pesoBcController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Peso Bc',
																labelText: 'Peso Bc',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteFerroviarioVagaoController.cteFerroviarioVagaoModel.pesoBc = cteFerroviarioVagaoController.pesoBcController.numberValue;
																cteFerroviarioVagaoController.formWasChanged = true;
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
