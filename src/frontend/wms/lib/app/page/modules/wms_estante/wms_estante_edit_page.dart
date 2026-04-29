import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:wms/app/page/shared_widget/shared_widget_imports.dart';
import 'package:wms/app/controller/wms_estante_controller.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/page/shared_widget/input/input_imports.dart';

class WmsEstanteEditPage extends StatelessWidget {
	WmsEstanteEditPage({Key? key}) : super(key: key);
	final wmsEstanteController = Get.find<WmsEstanteController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					wmsEstanteController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: wmsEstanteController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Estante - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: wmsEstanteController.save),
						cancelAndExitButton(onPressed: wmsEstanteController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: wmsEstanteController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: wmsEstanteController.scrollController,
							child: SingleChildScrollView(
								controller: wmsEstanteController.scrollController,
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
																		controller: wmsEstanteController.wmsRuaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Rua',
																			labelText: 'Rua *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: wmsEstanteController.callWmsRuaLookup),
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
															maxLength: 10,
															controller: wmsEstanteController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsEstanteController.wmsEstanteModel.codigo = text;
																wmsEstanteController.formWasChanged = true;
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
															controller: wmsEstanteController.quantidadeCaixaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Caixa',
																labelText: 'Quantidade Caixa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsEstanteController.wmsEstanteModel.quantidadeCaixa = int.tryParse(text);
																wmsEstanteController.formWasChanged = true;
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
