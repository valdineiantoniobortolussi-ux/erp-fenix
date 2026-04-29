import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_documento_anterior_id_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteDocumentoAnteriorIdEditPage extends StatelessWidget {
	CteDocumentoAnteriorIdEditPage({Key? key}) : super(key: key);
	final cteDocumentoAnteriorIdController = Get.find<CteDocumentoAnteriorIdController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					cteDocumentoAnteriorIdController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: cteDocumentoAnteriorIdController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Cte Documento Anterior Id - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteDocumentoAnteriorIdController.save),
						cancelAndExitButton(onPressed: cteDocumentoAnteriorIdController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteDocumentoAnteriorIdController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteDocumentoAnteriorIdController.scrollController,
							child: SingleChildScrollView(
								controller: cteDocumentoAnteriorIdController.scrollController,
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: cteDocumentoAnteriorIdController.cteDocumentoAnteriorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Cte Documento Anterior',
																			labelText: 'Id Cte Documento Anterior *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: cteDocumentoAnteriorIdController.callCteDocumentoAnteriorLookup),
															),
														],
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
															value: cteDocumentoAnteriorIdController.cteDocumentoAnteriorIdModel.tipo ?? 'AAA',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteDocumentoAnteriorIdController.cteDocumentoAnteriorIdModel.tipo = newValue;
																cteDocumentoAnteriorIdController.formWasChanged = true;
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
															value: cteDocumentoAnteriorIdController.cteDocumentoAnteriorIdModel.serie ?? 'AAA',
															labelText: 'Serie',
															hintText: 'Informe os dados para o campo Serie',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteDocumentoAnteriorIdController.cteDocumentoAnteriorIdModel.serie = newValue;
																cteDocumentoAnteriorIdController.formWasChanged = true;
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
															value: cteDocumentoAnteriorIdController.cteDocumentoAnteriorIdModel.subserie ?? 'AAA',
															labelText: 'Subserie',
															hintText: 'Informe os dados para o campo Subserie',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteDocumentoAnteriorIdController.cteDocumentoAnteriorIdModel.subserie = newValue;
																cteDocumentoAnteriorIdController.formWasChanged = true;
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
															maxLength: 20,
															controller: cteDocumentoAnteriorIdController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteDocumentoAnteriorIdController.cteDocumentoAnteriorIdModel.numero = text;
																cteDocumentoAnteriorIdController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Emissao',
																labelText: 'Data Emissao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: cteDocumentoAnteriorIdController.cteDocumentoAnteriorIdModel.dataEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	cteDocumentoAnteriorIdController.cteDocumentoAnteriorIdModel.dataEmissao = value;
																	cteDocumentoAnteriorIdController.formWasChanged = true;
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
															maxLength: 44,
															controller: cteDocumentoAnteriorIdController.chaveCteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Chave Cte',
																labelText: 'Chave Cte',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteDocumentoAnteriorIdController.cteDocumentoAnteriorIdModel.chaveCte = text;
																cteDocumentoAnteriorIdController.formWasChanged = true;
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
