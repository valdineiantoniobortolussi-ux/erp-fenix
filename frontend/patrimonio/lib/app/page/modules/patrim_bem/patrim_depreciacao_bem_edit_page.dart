import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:patrimonio/app/page/shared_widget/shared_widget_imports.dart';
import 'package:patrimonio/app/controller/patrim_depreciacao_bem_controller.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/page/shared_widget/input/input_imports.dart';

class PatrimDepreciacaoBemEditPage extends StatelessWidget {
	PatrimDepreciacaoBemEditPage({Key? key}) : super(key: key);
	final patrimDepreciacaoBemController = Get.find<PatrimDepreciacaoBemController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: patrimDepreciacaoBemController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Depreciação - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: patrimDepreciacaoBemController.save),
						cancelAndExitButton(onPressed: patrimDepreciacaoBemController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: patrimDepreciacaoBemController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: patrimDepreciacaoBemController.scrollController,
							child: SingleChildScrollView(
								controller: patrimDepreciacaoBemController.scrollController,
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
																hintText: 'Informe os dados para o campo Data Depreciacao',
																labelText: 'Data Depreciacao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimDepreciacaoBemController.patrimDepreciacaoBemModel.dataDepreciacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimDepreciacaoBemController.patrimDepreciacaoBemModel.dataDepreciacao = value;
																	patrimDepreciacaoBemController.formWasChanged = true;
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
															controller: patrimDepreciacaoBemController.diasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dias',
																labelText: 'Dias',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimDepreciacaoBemController.patrimDepreciacaoBemModel.dias = int.tryParse(text);
																patrimDepreciacaoBemController.formWasChanged = true;
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
															controller: patrimDepreciacaoBemController.taxaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa',
																labelText: 'Taxa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimDepreciacaoBemController.patrimDepreciacaoBemModel.taxa = patrimDepreciacaoBemController.taxaController.numberValue;
																patrimDepreciacaoBemController.formWasChanged = true;
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
															controller: patrimDepreciacaoBemController.indiceController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Indice',
																labelText: 'Indice',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimDepreciacaoBemController.patrimDepreciacaoBemModel.indice = patrimDepreciacaoBemController.indiceController.numberValue;
																patrimDepreciacaoBemController.formWasChanged = true;
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
															controller: patrimDepreciacaoBemController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimDepreciacaoBemController.patrimDepreciacaoBemModel.valor = patrimDepreciacaoBemController.valorController.numberValue;
																patrimDepreciacaoBemController.formWasChanged = true;
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
															controller: patrimDepreciacaoBemController.depreciacaoAcumuladaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Depreciacao Acumulada',
																labelText: 'Depreciacao Acumulada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimDepreciacaoBemController.patrimDepreciacaoBemModel.depreciacaoAcumulada = patrimDepreciacaoBemController.depreciacaoAcumuladaController.numberValue;
																patrimDepreciacaoBemController.formWasChanged = true;
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
