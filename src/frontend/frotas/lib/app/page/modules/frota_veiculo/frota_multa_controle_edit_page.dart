import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:frotas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:frotas/app/controller/frota_multa_controle_controller.dart';
import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/page/shared_widget/input/input_imports.dart';

class FrotaMultaControleEditPage extends StatelessWidget {
	FrotaMultaControleEditPage({Key? key}) : super(key: key);
	final frotaMultaControleController = Get.find<FrotaMultaControleController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: frotaMultaControleController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Multas - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: frotaMultaControleController.save),
						cancelAndExitButton(onPressed: frotaMultaControleController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: frotaMultaControleController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: frotaMultaControleController.scrollController,
							child: SingleChildScrollView(
								controller: frotaMultaControleController.scrollController,
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
																hintText: 'Informe os dados para o campo Data Multa',
																labelText: 'Data Multa',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: frotaMultaControleController.frotaMultaControleModel.dataMulta,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	frotaMultaControleController.frotaMultaControleModel.dataMulta = value;
																	frotaMultaControleController.formWasChanged = true;
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
															controller: frotaMultaControleController.pontosController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Pontos',
																labelText: 'Pontos',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaMultaControleController.frotaMultaControleModel.pontos = int.tryParse(text);
																frotaMultaControleController.formWasChanged = true;
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
															controller: frotaMultaControleController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaMultaControleController.frotaMultaControleModel.valor = frotaMultaControleController.valorController.numberValue;
																frotaMultaControleController.formWasChanged = true;
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
															controller: frotaMultaControleController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaMultaControleController.frotaMultaControleModel.observacao = text;
																frotaMultaControleController.formWasChanged = true;
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
