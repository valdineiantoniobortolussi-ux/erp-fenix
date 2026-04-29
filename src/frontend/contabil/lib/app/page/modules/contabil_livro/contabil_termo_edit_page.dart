import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/contabil_termo_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class ContabilTermoEditPage extends StatelessWidget {
	ContabilTermoEditPage({Key? key}) : super(key: key);
	final contabilTermoController = Get.find<ContabilTermoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: contabilTermoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Termos - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: contabilTermoController.save),
						cancelAndExitButton(onPressed: contabilTermoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contabilTermoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contabilTermoController.scrollController,
							child: SingleChildScrollView(
								controller: contabilTermoController.scrollController,
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
															value: contabilTermoController.contabilTermoModel.aberturaEncerramento ?? 'Abertura',
															labelText: 'Abertura Encerramento',
															hintText: 'Informe os dados para o campo Abertura Encerramento',
															items: const ['Abertura','Encerramento'],
															onChanged: (dynamic newValue) {
																contabilTermoController.contabilTermoModel.aberturaEncerramento = newValue;
																contabilTermoController.formWasChanged = true;
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
															controller: contabilTermoController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilTermoController.contabilTermoModel.numero = int.tryParse(text);
																contabilTermoController.formWasChanged = true;
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
															controller: contabilTermoController.paginaInicialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Pagina Inicial',
																labelText: 'Pagina Inicial',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilTermoController.contabilTermoModel.paginaInicial = int.tryParse(text);
																contabilTermoController.formWasChanged = true;
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
															controller: contabilTermoController.paginaFinalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Pagina Final',
																labelText: 'Pagina Final',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilTermoController.contabilTermoModel.paginaFinal = int.tryParse(text);
																contabilTermoController.formWasChanged = true;
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
															maxLength: 100,
															controller: contabilTermoController.registradoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Registrado',
																labelText: 'Registrado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilTermoController.contabilTermoModel.registrado = text;
																contabilTermoController.formWasChanged = true;
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
															maxLength: 50,
															controller: contabilTermoController.numeroRegistroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Registro',
																labelText: 'Numero Registro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilTermoController.contabilTermoModel.numeroRegistro = text;
																contabilTermoController.formWasChanged = true;
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
																dateTime: contabilTermoController.contabilTermoModel.dataDespacho,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contabilTermoController.contabilTermoModel.dataDespacho = value;
																	contabilTermoController.formWasChanged = true;
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
																dateTime: contabilTermoController.contabilTermoModel.dataAbertura,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contabilTermoController.contabilTermoModel.dataAbertura = value;
																	contabilTermoController.formWasChanged = true;
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
																dateTime: contabilTermoController.contabilTermoModel.dataEncerramento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contabilTermoController.contabilTermoModel.dataEncerramento = value;
																	contabilTermoController.formWasChanged = true;
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
																dateTime: contabilTermoController.contabilTermoModel.escrituracaoInicio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contabilTermoController.contabilTermoModel.escrituracaoInicio = value;
																	contabilTermoController.formWasChanged = true;
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
																dateTime: contabilTermoController.contabilTermoModel.escrituracaoFim,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contabilTermoController.contabilTermoModel.escrituracaoFim = value;
																	contabilTermoController.formWasChanged = true;
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
															controller: contabilTermoController.textoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Texto',
																labelText: 'Texto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilTermoController.contabilTermoModel.texto = text;
																contabilTermoController.formWasChanged = true;
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
