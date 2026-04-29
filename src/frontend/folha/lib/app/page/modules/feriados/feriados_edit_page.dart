import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/feriados_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FeriadosEditPage extends StatelessWidget {
	FeriadosEditPage({Key? key}) : super(key: key);
	final feriadosController = Get.find<FeriadosController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					feriadosController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: feriadosController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Feriados - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: feriadosController.save),
						cancelAndExitButton(onPressed: feriadosController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: feriadosController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: feriadosController.scrollController,
							child: SingleChildScrollView(
								controller: feriadosController.scrollController,
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
														child: TextFormField(
															autofocus: true,
															maxLength: 4,
															controller: feriadosController.anoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ano',
																labelText: 'Ano',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																feriadosController.feriadosModel.ano = text;
																feriadosController.formWasChanged = true;
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
															controller: feriadosController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																feriadosController.feriadosModel.nome = text;
																feriadosController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: feriadosController.feriadosModel.abrangencia ?? 'Federal',
															labelText: 'Abrangencia',
															hintText: 'Informe os dados para o campo Abrangencia',
															items: const ['Federal','Estadual','Municipal'],
															onChanged: (dynamic newValue) {
																feriadosController.feriadosModel.abrangencia = newValue;
																feriadosController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: feriadosController.feriadosModel.uf ?? 'AC',
															labelText: 'Uf',
															hintText: 'Informe os dados para o campo Uf',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																feriadosController.feriadosModel.uf = newValue;
																feriadosController.formWasChanged = true;
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
															controller: feriadosController.municipioIbgeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Municipio Ibge',
																labelText: 'Municipio Ibge',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																feriadosController.feriadosModel.municipioIbge = int.tryParse(text);
																feriadosController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: feriadosController.feriadosModel.tipo ?? 'Fixo.Movel',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Fixo.Movel'],
															onChanged: (dynamic newValue) {
																feriadosController.feriadosModel.tipo = newValue;
																feriadosController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Feriado',
																labelText: 'Data Feriado',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: feriadosController.feriadosModel.dataFeriado,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	feriadosController.feriadosModel.dataFeriado = value;
																	feriadosController.formWasChanged = true;
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
