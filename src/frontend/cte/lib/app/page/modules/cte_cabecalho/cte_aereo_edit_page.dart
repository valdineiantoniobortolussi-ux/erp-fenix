import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_aereo_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteAereoEditPage extends StatelessWidget {
	CteAereoEditPage({Key? key}) : super(key: key);
	final cteAereoController = Get.find<CteAereoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: cteAereoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Aéreo - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteAereoController.save),
						cancelAndExitButton(onPressed: cteAereoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteAereoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteAereoController.scrollController,
							child: SingleChildScrollView(
								controller: cteAereoController.scrollController,
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: cteAereoController.numeroMinutaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Minuta',
																labelText: 'Numero Minuta',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAereoController.cteAereoModel.numeroMinuta = int.tryParse(text);
																cteAereoController.formWasChanged = true;
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
															controller: cteAereoController.numeroConhecimentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Conhecimento',
																labelText: 'Numero Conhecimento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAereoController.cteAereoModel.numeroConhecimento = int.tryParse(text);
																cteAereoController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Prevista Entrega',
																labelText: 'Data Prevista Entrega',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: cteAereoController.cteAereoModel.dataPrevistaEntrega,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	cteAereoController.cteAereoModel.dataPrevistaEntrega = value;
																	cteAereoController.formWasChanged = true;
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
															maxLength: 20,
															controller: cteAereoController.idEmissorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Emissor',
																labelText: 'Id Emissor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAereoController.cteAereoModel.idEmissor = text;
																cteAereoController.formWasChanged = true;
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
															maxLength: 14,
															controller: cteAereoController.idInternaTomadorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Interna Tomador',
																labelText: 'Id Interna Tomador',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAereoController.cteAereoModel.idInternaTomador = text;
																cteAereoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: cteAereoController.cteAereoModel.tarifaClasse ?? 'AAA',
															labelText: 'Tarifa Classe',
															hintText: 'Informe os dados para o campo Tarifa Classe',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteAereoController.cteAereoModel.tarifaClasse = newValue;
																cteAereoController.formWasChanged = true;
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
															maxLength: 4,
															controller: cteAereoController.tarifaCodigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Tarifa Codigo',
																labelText: 'Tarifa Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAereoController.cteAereoModel.tarifaCodigo = text;
																cteAereoController.formWasChanged = true;
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
															controller: cteAereoController.tarifaValorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Tarifa Valor',
																labelText: 'Tarifa Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAereoController.cteAereoModel.tarifaValor = cteAereoController.tarifaValorController.numberValue;
																cteAereoController.formWasChanged = true;
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
															maxLength: 14,
															controller: cteAereoController.cargaDimensaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Carga Dimensao',
																labelText: 'Carga Dimensao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAereoController.cteAereoModel.cargaDimensao = text;
																cteAereoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: cteAereoController.cteAereoModel.cargaInformacaoManuseio ?? 'AAA',
															labelText: 'Carga Informacao Manuseio',
															hintText: 'Informe os dados para o campo Carga Informacao Manuseio',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteAereoController.cteAereoModel.cargaInformacaoManuseio = newValue;
																cteAereoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: cteAereoController.cteAereoModel.cargaEspecial ?? 'AAA',
															labelText: 'Carga Especial',
															hintText: 'Informe os dados para o campo Carga Especial',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteAereoController.cteAereoModel.cargaEspecial = newValue;
																cteAereoController.formWasChanged = true;
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
