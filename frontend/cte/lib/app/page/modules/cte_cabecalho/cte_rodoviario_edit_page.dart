import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_rodoviario_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteRodoviarioEditPage extends StatelessWidget {
	CteRodoviarioEditPage({Key? key}) : super(key: key);
	final cteRodoviarioController = Get.find<CteRodoviarioController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: cteRodoviarioController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Rodoviário - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteRodoviarioController.save),
						cancelAndExitButton(onPressed: cteRodoviarioController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteRodoviarioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteRodoviarioController.scrollController,
							child: SingleChildScrollView(
								controller: cteRodoviarioController.scrollController,
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
															maxLength: 8,
															controller: cteRodoviarioController.rntrcController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Rntrc',
																labelText: 'Rntrc',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioController.cteRodoviarioModel.rntrc = text;
																cteRodoviarioController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Prevista Entrega',
																labelText: 'Data Prevista Entrega',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: cteRodoviarioController.cteRodoviarioModel.dataPrevistaEntrega,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	cteRodoviarioController.cteRodoviarioModel.dataPrevistaEntrega = value;
																	cteRodoviarioController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: cteRodoviarioController.cteRodoviarioModel.indicadorLotacao ?? 'AAA',
															labelText: 'Indicador Lotacao',
															hintText: 'Informe os dados para o campo Indicador Lotacao',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteRodoviarioController.cteRodoviarioModel.indicadorLotacao = newValue;
																cteRodoviarioController.formWasChanged = true;
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
															controller: cteRodoviarioController.ciotController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ciot',
																labelText: 'Ciot',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioController.cteRodoviarioModel.ciot = int.tryParse(text);
																cteRodoviarioController.formWasChanged = true;
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
