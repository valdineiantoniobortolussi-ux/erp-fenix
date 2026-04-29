import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:inventario/app/page/shared_widget/shared_widget_imports.dart';
import 'package:inventario/app/controller/inventario_ajuste_det_controller.dart';
import 'package:inventario/app/infra/infra_imports.dart';
import 'package:inventario/app/page/shared_widget/input/input_imports.dart';

class InventarioAjusteDetEditPage extends StatelessWidget {
	InventarioAjusteDetEditPage({Key? key}) : super(key: key);
	final inventarioAjusteDetController = Get.find<InventarioAjusteDetController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: inventarioAjusteDetController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Produtos - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: inventarioAjusteDetController.save),
						cancelAndExitButton(onPressed: inventarioAjusteDetController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: inventarioAjusteDetController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: inventarioAjusteDetController.scrollController,
							child: SingleChildScrollView(
								controller: inventarioAjusteDetController.scrollController,
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
																		controller: inventarioAjusteDetController.produtoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Importar Produto',
																			labelText: 'Produto *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: inventarioAjusteDetController.callProdutoLookup),
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
															controller: inventarioAjusteDetController.valorOriginalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Original',
																labelText: 'Valor Original',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																inventarioAjusteDetController.inventarioAjusteDetModel.valorOriginal = inventarioAjusteDetController.valorOriginalController.numberValue;
																inventarioAjusteDetController.formWasChanged = true;
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
															controller: inventarioAjusteDetController.valorReajusteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Reajuste',
																labelText: 'Valor Reajuste',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																inventarioAjusteDetController.inventarioAjusteDetModel.valorReajuste = inventarioAjusteDetController.valorReajusteController.numberValue;
																inventarioAjusteDetController.formWasChanged = true;
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
