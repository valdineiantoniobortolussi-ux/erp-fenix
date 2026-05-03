import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:fiscal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:fiscal/app/controller/fiscal_termo_controller.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/page/shared_widget/input/input_imports.dart';

class FiscalTermoEditPage extends StatelessWidget {
	FiscalTermoEditPage({Key? key}) : super(key: key);
	final fiscalTermoController = Get.find<FiscalTermoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: fiscalTermoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Termos - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: fiscalTermoController.save),
						cancelAndExitButton(onPressed: fiscalTermoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: fiscalTermoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: fiscalTermoController.scrollController,
							child: SingleChildScrollView(
								controller: fiscalTermoController.scrollController,
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: fiscalTermoController.fiscalTermoModel.aberturaEncerramento ?? 'Abertura',
															labelText: 'Abertura/Encerramento',
															hintText: 'Informe os dados para o campo Abertura Encerramento',
															items: const ['Abertura','Encerramento'],
															onChanged: (dynamic newValue) {
																fiscalTermoController.fiscalTermoModel.aberturaEncerramento = newValue;
																fiscalTermoController.formWasChanged = true;
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
															controller: fiscalTermoController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalTermoController.fiscalTermoModel.numero = int.tryParse(text);
																fiscalTermoController.formWasChanged = true;
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
															controller: fiscalTermoController.paginaInicialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Pagina Inicial',
																labelText: 'Pagina Inicial',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalTermoController.fiscalTermoModel.paginaInicial = int.tryParse(text);
																fiscalTermoController.formWasChanged = true;
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
															controller: fiscalTermoController.paginaFinalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Pagina Final',
																labelText: 'Pagina Final',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalTermoController.fiscalTermoModel.paginaFinal = int.tryParse(text);
																fiscalTermoController.formWasChanged = true;
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
															maxLength: 50,
															controller: fiscalTermoController.numeroRegistroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Registro',
																labelText: 'Numero Registro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalTermoController.fiscalTermoModel.numeroRegistro = text;
																fiscalTermoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: fiscalTermoController.registradoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Registrado',
																labelText: 'Registrado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalTermoController.fiscalTermoModel.registrado = text;
																fiscalTermoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Despacho',
																labelText: 'Data Despacho',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: fiscalTermoController.fiscalTermoModel.dataDespacho,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	fiscalTermoController.fiscalTermoModel.dataDespacho = value;
																	fiscalTermoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Abertura',
																labelText: 'Data Abertura',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: fiscalTermoController.fiscalTermoModel.dataAbertura,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	fiscalTermoController.fiscalTermoModel.dataAbertura = value;
																	fiscalTermoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Encerramento',
																labelText: 'Data Encerramento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: fiscalTermoController.fiscalTermoModel.dataEncerramento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	fiscalTermoController.fiscalTermoModel.dataEncerramento = value;
																	fiscalTermoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Escrituracao Inicio',
																labelText: 'Escrituracao Inicio',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: fiscalTermoController.fiscalTermoModel.escrituracaoInicio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	fiscalTermoController.fiscalTermoModel.escrituracaoInicio = value;
																	fiscalTermoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Escrituracao Fim',
																labelText: 'Escrituracao Fim',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: fiscalTermoController.fiscalTermoModel.escrituracaoFim,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	fiscalTermoController.fiscalTermoModel.escrituracaoFim = value;
																	fiscalTermoController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															maxLines: 3,
															controller: fiscalTermoController.textoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Texto',
																labelText: 'Texto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalTermoController.fiscalTermoModel.texto = text;
																fiscalTermoController.formWasChanged = true;
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
