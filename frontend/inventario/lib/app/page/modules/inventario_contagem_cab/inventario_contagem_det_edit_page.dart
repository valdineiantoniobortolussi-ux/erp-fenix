import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:inventario/app/page/shared_widget/shared_widget_imports.dart';
import 'package:inventario/app/controller/inventario_contagem_det_controller.dart';
import 'package:inventario/app/infra/infra_imports.dart';
import 'package:inventario/app/page/shared_widget/input/input_imports.dart';

class InventarioContagemDetEditPage extends StatelessWidget {
	InventarioContagemDetEditPage({Key? key}) : super(key: key);
	final inventarioContagemDetController = Get.find<InventarioContagemDetController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: inventarioContagemDetController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Produtos - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: inventarioContagemDetController.save),
						cancelAndExitButton(onPressed: inventarioContagemDetController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: inventarioContagemDetController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: inventarioContagemDetController.scrollController,
							child: SingleChildScrollView(
								controller: inventarioContagemDetController.scrollController,
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
																		controller: inventarioContagemDetController.produtoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Produto',
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
																child: lookupButton(onPressed: inventarioContagemDetController.callProdutoLookup),
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: inventarioContagemDetController.contagem01Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Contagem 01',
																labelText: 'Contagem 01',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																inventarioContagemDetController.inventarioContagemDetModel.contagem01 = inventarioContagemDetController.contagem01Controller.numberValue;
																inventarioContagemDetController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: inventarioContagemDetController.contagem02Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Contagem 02',
																labelText: 'Contagem 02',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																inventarioContagemDetController.inventarioContagemDetModel.contagem02 = inventarioContagemDetController.contagem02Controller.numberValue;
																inventarioContagemDetController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: inventarioContagemDetController.contagem03Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Contagem 03',
																labelText: 'Contagem 03',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																inventarioContagemDetController.inventarioContagemDetModel.contagem03 = inventarioContagemDetController.contagem03Controller.numberValue;
																inventarioContagemDetController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: inventarioContagemDetController.inventarioContagemDetModel.fechadoContagem ?? '01',
															labelText: 'Fechado Contagem',
															hintText: 'Informe os dados para o campo Fechado Contagem',
															items: const ['01','02','03'],
															onChanged: (dynamic newValue) {
																inventarioContagemDetController.inventarioContagemDetModel.fechadoContagem = newValue;
																inventarioContagemDetController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: inventarioContagemDetController.quantidadeSistemaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Sistema',
																labelText: 'Quantidade Sistema',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																inventarioContagemDetController.inventarioContagemDetModel.quantidadeSistema = inventarioContagemDetController.quantidadeSistemaController.numberValue;
																inventarioContagemDetController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: inventarioContagemDetController.acuracidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Acuracidade',
																labelText: 'Acuracidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																inventarioContagemDetController.inventarioContagemDetModel.acuracidade = inventarioContagemDetController.acuracidadeController.numberValue;
																inventarioContagemDetController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: inventarioContagemDetController.divergenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Divergencia',
																labelText: 'Divergencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																inventarioContagemDetController.inventarioContagemDetModel.divergencia = inventarioContagemDetController.divergenciaController.numberValue;
																inventarioContagemDetController.formWasChanged = true;
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
