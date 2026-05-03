import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:frotas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:frotas/app/controller/frota_combustivel_controle_controller.dart';
import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/page/shared_widget/input/input_imports.dart';

class FrotaCombustivelControleEditPage extends StatelessWidget {
	FrotaCombustivelControleEditPage({Key? key}) : super(key: key);
	final frotaCombustivelControleController = Get.find<FrotaCombustivelControleController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: frotaCombustivelControleController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Controle Combustível - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: frotaCombustivelControleController.save),
						cancelAndExitButton(onPressed: frotaCombustivelControleController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: frotaCombustivelControleController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: frotaCombustivelControleController.scrollController,
							child: SingleChildScrollView(
								controller: frotaCombustivelControleController.scrollController,
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
																hintText: 'Informe os dados para o campo Data Abastecimento',
																labelText: 'Data Abastecimento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: frotaCombustivelControleController.frotaCombustivelControleModel.dataAbastecimento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	frotaCombustivelControleController.frotaCombustivelControleModel.dataAbastecimento = value;
																	frotaCombustivelControleController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: frotaCombustivelControleController.horaAbastecimentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Abastecimento',
																labelText: 'Hora Abastecimento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaCombustivelControleController.frotaCombustivelControleModel.horaAbastecimento = text;
																frotaCombustivelControleController.formWasChanged = true;
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
															controller: frotaCombustivelControleController.valorAbastecimentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Abastecimento',
																labelText: 'Valor Abastecimento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaCombustivelControleController.frotaCombustivelControleModel.valorAbastecimento = frotaCombustivelControleController.valorAbastecimentoController.numberValue;
																frotaCombustivelControleController.formWasChanged = true;
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
