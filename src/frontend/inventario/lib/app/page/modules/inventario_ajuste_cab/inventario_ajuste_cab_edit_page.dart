import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:inventario/app/page/shared_widget/shared_widget_imports.dart';
import 'package:inventario/app/controller/inventario_ajuste_cab_controller.dart';
import 'package:inventario/app/infra/infra_imports.dart';
import 'package:inventario/app/page/shared_widget/input/input_imports.dart';

class InventarioAjusteCabEditPage extends StatelessWidget {
	InventarioAjusteCabEditPage({Key? key}) : super(key: key);
	final inventarioAjusteCabController = Get.find<InventarioAjusteCabController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: inventarioAjusteCabController.inventarioAjusteCabEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: inventarioAjusteCabController.inventarioAjusteCabEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: inventarioAjusteCabController.scrollController,
							child: SingleChildScrollView(
								controller: inventarioAjusteCabController.scrollController,
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
																		controller: inventarioAjusteCabController.viewPessoaColaboradorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Importar Colaborador',
																			labelText: 'Colaborador *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: inventarioAjusteCabController.callViewPessoaColaboradorLookup),
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Ajuste',
																labelText: 'Data Ajuste',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: inventarioAjusteCabController.inventarioAjusteCabModel.dataAjuste,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	inventarioAjusteCabController.inventarioAjusteCabModel.dataAjuste = value;
																	inventarioAjusteCabController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: inventarioAjusteCabController.inventarioAjusteCabModel.tipo ?? 'Aumentar',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Aumentar','Diminuir'],
															onChanged: (dynamic newValue) {
																inventarioAjusteCabController.inventarioAjusteCabModel.tipo = newValue;
																inventarioAjusteCabController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															keyboardType: TextInputType.number,
															autofocus: true,
															controller: inventarioAjusteCabController.taxaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa',
																labelText: 'Taxa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																inventarioAjusteCabController.inventarioAjusteCabModel.taxa = inventarioAjusteCabController.taxaController.numberValue;
																inventarioAjusteCabController.formWasChanged = true;
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
															maxLines: 3,
															controller: inventarioAjusteCabController.justificativaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Justificativa',
																labelText: 'Justificativa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																inventarioAjusteCabController.inventarioAjusteCabModel.justificativa = text;
																inventarioAjusteCabController.formWasChanged = true;
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
