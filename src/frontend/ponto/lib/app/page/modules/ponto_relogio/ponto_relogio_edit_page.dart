import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ponto/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ponto/app/controller/ponto_relogio_controller.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/page/shared_widget/input/input_imports.dart';

class PontoRelogioEditPage extends StatelessWidget {
	PontoRelogioEditPage({Key? key}) : super(key: key);
	final pontoRelogioController = Get.find<PontoRelogioController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					pontoRelogioController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: pontoRelogioController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Relógio de Ponto - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: pontoRelogioController.save),
						cancelAndExitButton(onPressed: pontoRelogioController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pontoRelogioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pontoRelogioController.scrollController,
							child: SingleChildScrollView(
								controller: pontoRelogioController.scrollController,
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
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: pontoRelogioController.localizacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Localizacao',
																labelText: 'Localizacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoRelogioController.pontoRelogioModel.localizacao = text;
																pontoRelogioController.formWasChanged = true;
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
															maxLength: 30,
															controller: pontoRelogioController.marcaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Marca',
																labelText: 'Marca',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoRelogioController.pontoRelogioModel.marca = text;
																pontoRelogioController.formWasChanged = true;
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
															maxLength: 30,
															controller: pontoRelogioController.fabricanteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fabricante',
																labelText: 'Fabricante',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoRelogioController.pontoRelogioModel.fabricante = text;
																pontoRelogioController.formWasChanged = true;
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
															maxLength: 50,
															controller: pontoRelogioController.numeroSerieController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Serie',
																labelText: 'Numero Serie',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoRelogioController.pontoRelogioModel.numeroSerie = text;
																pontoRelogioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pontoRelogioController.pontoRelogioModel.utilizacao ?? 'Ponto',
															labelText: 'Utilizacao',
															hintText: 'Informe os dados para o campo Utilizacao',
															items: const ['Ponto','Refeitório','Circulação'],
															onChanged: (dynamic newValue) {
																pontoRelogioController.pontoRelogioModel.utilizacao = newValue;
																pontoRelogioController.formWasChanged = true;
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
			),
		);
	}
}
