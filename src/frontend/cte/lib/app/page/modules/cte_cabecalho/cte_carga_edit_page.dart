import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_carga_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteCargaEditPage extends StatelessWidget {
	CteCargaEditPage({Key? key}) : super(key: key);
	final cteCargaController = Get.find<CteCargaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: cteCargaController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Carga - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteCargaController.save),
						cancelAndExitButton(onPressed: cteCargaController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteCargaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteCargaController.scrollController,
							child: SingleChildScrollView(
								controller: cteCargaController.scrollController,
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
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: cteCargaController.cteCargaModel.codigoUnidadeMedida ?? 'AAA',
															labelText: 'Codigo Unidade Medida',
															hintText: 'Informe os dados para o campo Codigo Unidade Medida',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteCargaController.cteCargaModel.codigoUnidadeMedida = newValue;
																cteCargaController.formWasChanged = true;
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
															controller: cteCargaController.tipoMedidaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Tipo Medida',
																labelText: 'Tipo Medida',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCargaController.cteCargaModel.tipoMedida = text;
																cteCargaController.formWasChanged = true;
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
															controller: cteCargaController.quantidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade',
																labelText: 'Quantidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCargaController.cteCargaModel.quantidade = cteCargaController.quantidadeController.numberValue;
																cteCargaController.formWasChanged = true;
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
