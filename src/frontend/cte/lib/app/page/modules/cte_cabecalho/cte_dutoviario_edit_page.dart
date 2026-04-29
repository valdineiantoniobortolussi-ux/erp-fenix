import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_dutoviario_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteDutoviarioEditPage extends StatelessWidget {
	CteDutoviarioEditPage({Key? key}) : super(key: key);
	final cteDutoviarioController = Get.find<CteDutoviarioController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: cteDutoviarioController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Dutoviário - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteDutoviarioController.save),
						cancelAndExitButton(onPressed: cteDutoviarioController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteDutoviarioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteDutoviarioController.scrollController,
							child: SingleChildScrollView(
								controller: cteDutoviarioController.scrollController,
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
														child: TextFormField(
															autofocus: true,
															controller: cteDutoviarioController.valorTarifaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Tarifa',
																labelText: 'Valor Tarifa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteDutoviarioController.cteDutoviarioModel.valorTarifa = cteDutoviarioController.valorTarifaController.numberValue;
																cteDutoviarioController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Inicio',
																labelText: 'Data Inicio',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: cteDutoviarioController.cteDutoviarioModel.dataInicio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	cteDutoviarioController.cteDutoviarioModel.dataInicio = value;
																	cteDutoviarioController.formWasChanged = true;
																},
															),
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Fim',
																labelText: 'Data Fim',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: cteDutoviarioController.cteDutoviarioModel.dataFim,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	cteDutoviarioController.cteDutoviarioModel.dataFim = value;
																	cteDutoviarioController.formWasChanged = true;
																},
															),
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
