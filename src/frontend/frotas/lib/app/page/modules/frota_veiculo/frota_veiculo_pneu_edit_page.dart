import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:frotas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:frotas/app/controller/frota_veiculo_pneu_controller.dart';
import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/page/shared_widget/input/input_imports.dart';

class FrotaVeiculoPneuEditPage extends StatelessWidget {
	FrotaVeiculoPneuEditPage({Key? key}) : super(key: key);
	final frotaVeiculoPneuController = Get.find<FrotaVeiculoPneuController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: frotaVeiculoPneuController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Pneus - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: frotaVeiculoPneuController.save),
						cancelAndExitButton(onPressed: frotaVeiculoPneuController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: frotaVeiculoPneuController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: frotaVeiculoPneuController.scrollController,
							child: SingleChildScrollView(
								controller: frotaVeiculoPneuController.scrollController,
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Troca',
																labelText: 'Data Troca',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: frotaVeiculoPneuController.frotaVeiculoPneuModel.dataTroca,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	frotaVeiculoPneuController.frotaVeiculoPneuModel.dataTroca = value;
																	frotaVeiculoPneuController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: frotaVeiculoPneuController.valorTrocaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Troca',
																labelText: 'Valor Troca',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoPneuController.frotaVeiculoPneuModel.valorTroca = frotaVeiculoPneuController.valorTrocaController.numberValue;
																frotaVeiculoPneuController.formWasChanged = true;
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: frotaVeiculoPneuController.posicaoPneuController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Posicao Pneu',
																labelText: 'Posicao Pneu',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoPneuController.frotaVeiculoPneuModel.posicaoPneu = text;
																frotaVeiculoPneuController.formWasChanged = true;
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
															maxLength: 100,
															controller: frotaVeiculoPneuController.marcaPneuController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Marca Pneu',
																labelText: 'Marca Pneu',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoPneuController.frotaVeiculoPneuModel.marcaPneu = text;
																frotaVeiculoPneuController.formWasChanged = true;
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
