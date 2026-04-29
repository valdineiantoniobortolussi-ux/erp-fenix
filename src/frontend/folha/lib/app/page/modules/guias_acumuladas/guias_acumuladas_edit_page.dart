import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/guias_acumuladas_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class GuiasAcumuladasEditPage extends StatelessWidget {
	GuiasAcumuladasEditPage({Key? key}) : super(key: key);
	final guiasAcumuladasController = Get.find<GuiasAcumuladasController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					guiasAcumuladasController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: guiasAcumuladasController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Guias Acumuladas - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: guiasAcumuladasController.save),
						cancelAndExitButton(onPressed: guiasAcumuladasController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: guiasAcumuladasController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: guiasAcumuladasController.scrollController,
							child: SingleChildScrollView(
								controller: guiasAcumuladasController.scrollController,
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
															value: guiasAcumuladasController.guiasAcumuladasModel.gpsTipo ?? '1-Filial própia empresa',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Gps Tipo',
															items: const ['1-Filial própia empresa','2-Somente um serviço','3-Filial referente aos cooperados'],
															onChanged: (dynamic newValue) {
																guiasAcumuladasController.guiasAcumuladasModel.gpsTipo = newValue;
																guiasAcumuladasController.formWasChanged = true;
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
															controller: guiasAcumuladasController.gpsCompetenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Gps Competencia',
																labelText: 'Competencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																guiasAcumuladasController.guiasAcumuladasModel.gpsCompetencia = text;
																guiasAcumuladasController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: guiasAcumuladasController.gpsValorInssController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Gps Valor Inss',
																labelText: 'Valor INSS',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																guiasAcumuladasController.guiasAcumuladasModel.gpsValorInss = guiasAcumuladasController.gpsValorInssController.numberValue;
																guiasAcumuladasController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: guiasAcumuladasController.gpsValorOutrasEntController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Gps Valor Outras Ent',
																labelText: 'Valor Outras Entidades',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																guiasAcumuladasController.guiasAcumuladasModel.gpsValorOutrasEnt = guiasAcumuladasController.gpsValorOutrasEntController.numberValue;
																guiasAcumuladasController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Gps Data Pagamento',
																labelText: 'Data Pagamento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: guiasAcumuladasController.guiasAcumuladasModel.gpsDataPagamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	guiasAcumuladasController.guiasAcumuladasModel.gpsDataPagamento = value;
																	guiasAcumuladasController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: guiasAcumuladasController.irrfCompetenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Irrf Competencia',
																labelText: 'Competencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																guiasAcumuladasController.guiasAcumuladasModel.irrfCompetencia = text;
																guiasAcumuladasController.formWasChanged = true;
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
															controller: guiasAcumuladasController.irrfCodigoRecolhimentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Irrf Codigo Recolhimento',
																labelText: 'Codigo Recolhimento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																guiasAcumuladasController.guiasAcumuladasModel.irrfCodigoRecolhimento = int.tryParse(text);
																guiasAcumuladasController.formWasChanged = true;
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
															controller: guiasAcumuladasController.irrfValorAcumuladoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Irrf Valor Acumulado',
																labelText: 'Valor Acumulado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																guiasAcumuladasController.guiasAcumuladasModel.irrfValorAcumulado = guiasAcumuladasController.irrfValorAcumuladoController.numberValue;
																guiasAcumuladasController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Irrf Data Pagamento',
																labelText: 'Data Pagamento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: guiasAcumuladasController.guiasAcumuladasModel.irrfDataPagamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	guiasAcumuladasController.guiasAcumuladasModel.irrfDataPagamento = value;
																	guiasAcumuladasController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: guiasAcumuladasController.pisCompetenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Pis Competencia',
																labelText: 'Competencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																guiasAcumuladasController.guiasAcumuladasModel.pisCompetencia = text;
																guiasAcumuladasController.formWasChanged = true;
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
															controller: guiasAcumuladasController.pisValorAcumuladoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Pis Valor Acumulado',
																labelText: 'Valor Acumulado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																guiasAcumuladasController.guiasAcumuladasModel.pisValorAcumulado = guiasAcumuladasController.pisValorAcumuladoController.numberValue;
																guiasAcumuladasController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Pis Data Pagamento',
																labelText: 'Data Pagamento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: guiasAcumuladasController.guiasAcumuladasModel.pisDataPagamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	guiasAcumuladasController.guiasAcumuladasModel.pisDataPagamento = value;
																	guiasAcumuladasController.formWasChanged = true;
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
			),
		);
	}
}
