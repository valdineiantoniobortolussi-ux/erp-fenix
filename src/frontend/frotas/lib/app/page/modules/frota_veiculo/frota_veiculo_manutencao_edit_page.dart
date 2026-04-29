import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:frotas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:frotas/app/controller/frota_veiculo_manutencao_controller.dart';
import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/page/shared_widget/input/input_imports.dart';

class FrotaVeiculoManutencaoEditPage extends StatelessWidget {
	FrotaVeiculoManutencaoEditPage({Key? key}) : super(key: key);
	final frotaVeiculoManutencaoController = Get.find<FrotaVeiculoManutencaoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: frotaVeiculoManutencaoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Manutenção - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: frotaVeiculoManutencaoController.save),
						cancelAndExitButton(onPressed: frotaVeiculoManutencaoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: frotaVeiculoManutencaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: frotaVeiculoManutencaoController.scrollController,
							child: SingleChildScrollView(
								controller: frotaVeiculoManutencaoController.scrollController,
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
														child: CustomDropdownButtonFormField(
															value: frotaVeiculoManutencaoController.frotaVeiculoManutencaoModel.tipo ?? 'Preventiva',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Preventiva','Corretiva'],
															onChanged: (dynamic newValue) {
																frotaVeiculoManutencaoController.frotaVeiculoManutencaoModel.tipo = newValue;
																frotaVeiculoManutencaoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Manutencao',
																labelText: 'Data Manutencao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: frotaVeiculoManutencaoController.frotaVeiculoManutencaoModel.dataManutencao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	frotaVeiculoManutencaoController.frotaVeiculoManutencaoModel.dataManutencao = value;
																	frotaVeiculoManutencaoController.formWasChanged = true;
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
															controller: frotaVeiculoManutencaoController.valorManutencaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Manutencao',
																labelText: 'Valor Manutencao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoManutencaoController.frotaVeiculoManutencaoModel.valorManutencao = frotaVeiculoManutencaoController.valorManutencaoController.numberValue;
																frotaVeiculoManutencaoController.formWasChanged = true;
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
															controller: frotaVeiculoManutencaoController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoManutencaoController.frotaVeiculoManutencaoModel.observacao = text;
																frotaVeiculoManutencaoController.formWasChanged = true;
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
