import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:inventario/app/controller/inventario_contagem_cab_controller.dart';
import 'package:inventario/app/infra/infra_imports.dart';
import 'package:inventario/app/page/shared_widget/input/input_imports.dart';

class InventarioContagemCabEditPage extends StatelessWidget {
	InventarioContagemCabEditPage({Key? key}) : super(key: key);
	final inventarioContagemCabController = Get.find<InventarioContagemCabController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: inventarioContagemCabController.inventarioContagemCabEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: inventarioContagemCabController.inventarioContagemCabEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: inventarioContagemCabController.scrollController,
							child: SingleChildScrollView(
								controller: inventarioContagemCabController.scrollController,
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Contagem',
																labelText: 'Data Contagem',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: inventarioContagemCabController.inventarioContagemCabModel.dataContagem,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	inventarioContagemCabController.inventarioContagemCabModel.dataContagem = value;
																	inventarioContagemCabController.formWasChanged = true;
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
															value: inventarioContagemCabController.inventarioContagemCabModel.estoqueAtualizado ?? 'S',
															labelText: 'Estoque Atualizado',
															hintText: 'Informe os dados para o campo Estoque Atualizado',
															items: const ['S','N'],
															onChanged: (dynamic newValue) {
																inventarioContagemCabController.inventarioContagemCabModel.estoqueAtualizado = newValue;
																inventarioContagemCabController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: inventarioContagemCabController.inventarioContagemCabModel.tipo ?? 'Geral',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Geral','Dinâmico','Rotativo','Por Amostragem'],
															onChanged: (dynamic newValue) {
																inventarioContagemCabController.inventarioContagemCabModel.tipo = newValue;
																inventarioContagemCabController.formWasChanged = true;
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
