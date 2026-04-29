import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:gondolas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:gondolas/app/controller/gondola_estante_controller.dart';
import 'package:gondolas/app/infra/infra_imports.dart';
import 'package:gondolas/app/page/shared_widget/input/input_imports.dart';

class GondolaEstanteEditPage extends StatelessWidget {
	GondolaEstanteEditPage({Key? key}) : super(key: key);
	final gondolaEstanteController = Get.find<GondolaEstanteController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					gondolaEstanteController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: gondolaEstanteController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Estante - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: gondolaEstanteController.save),
						cancelAndExitButton(onPressed: gondolaEstanteController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: gondolaEstanteController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: gondolaEstanteController.scrollController,
							child: SingleChildScrollView(
								controller: gondolaEstanteController.scrollController,
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
																		controller: gondolaEstanteController.gondolaRuaModelController,
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
																child: lookupButton(onPressed: gondolaEstanteController.callGondolaRuaLookup),
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
															controller: gondolaEstanteController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gondolaEstanteController.gondolaEstanteModel.codigo = text;
																gondolaEstanteController.formWasChanged = true;
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
															controller: gondolaEstanteController.quantidadeCaixaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Caixas',
																labelText: 'Quantidade Caixas',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gondolaEstanteController.gondolaEstanteModel.quantidadeCaixa = int.tryParse(text);
																gondolaEstanteController.formWasChanged = true;
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
