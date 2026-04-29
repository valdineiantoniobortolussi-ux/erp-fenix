import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_rodoviario_pedagio_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteRodoviarioPedagioEditPage extends StatelessWidget {
	CteRodoviarioPedagioEditPage({Key? key}) : super(key: key);
	final cteRodoviarioPedagioController = Get.find<CteRodoviarioPedagioController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					cteRodoviarioPedagioController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: cteRodoviarioPedagioController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Cte Rodoviario Pedagio - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteRodoviarioPedagioController.save),
						cancelAndExitButton(onPressed: cteRodoviarioPedagioController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteRodoviarioPedagioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteRodoviarioPedagioController.scrollController,
							child: SingleChildScrollView(
								controller: cteRodoviarioPedagioController.scrollController,
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
																		controller: cteRodoviarioPedagioController.cteRodoviarioModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Cte Rodoviario',
																			labelText: 'Id Cte Rodoviario *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: cteRodoviarioPedagioController.callCteRodoviarioLookup),
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
															controller: cteRodoviarioPedagioController.cnpjFornecedorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj Fornecedor',
																labelText: 'Cnpj Fornecedor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioPedagioController.cteRodoviarioPedagioModel.cnpjFornecedor = text;
																cteRodoviarioPedagioController.formWasChanged = true;
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
															controller: cteRodoviarioPedagioController.comprovanteCompraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Comprovante Compra',
																labelText: 'Comprovante Compra',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioPedagioController.cteRodoviarioPedagioModel.comprovanteCompra = text;
																cteRodoviarioPedagioController.formWasChanged = true;
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
															controller: cteRodoviarioPedagioController.cnpjResponsavelController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj Responsavel',
																labelText: 'Cnpj Responsavel',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioPedagioController.cteRodoviarioPedagioModel.cnpjResponsavel = text;
																cteRodoviarioPedagioController.formWasChanged = true;
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
															controller: cteRodoviarioPedagioController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioPedagioController.cteRodoviarioPedagioModel.valor = cteRodoviarioPedagioController.valorController.numberValue;
																cteRodoviarioPedagioController.formWasChanged = true;
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
