import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_rodoviario_occ_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteRodoviarioOccEditPage extends StatelessWidget {
	CteRodoviarioOccEditPage({Key? key}) : super(key: key);
	final cteRodoviarioOccController = Get.find<CteRodoviarioOccController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					cteRodoviarioOccController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: cteRodoviarioOccController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Cte Rodoviario Occ - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteRodoviarioOccController.save),
						cancelAndExitButton(onPressed: cteRodoviarioOccController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteRodoviarioOccController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteRodoviarioOccController.scrollController,
							child: SingleChildScrollView(
								controller: cteRodoviarioOccController.scrollController,
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
																		controller: cteRodoviarioOccController.cteRodoviarioModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Cte Rodoviario',
																			labelText: 'Id Cte Rodoviario *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: cteRodoviarioOccController.callCteRodoviarioLookup),
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
															value: cteRodoviarioOccController.cteRodoviarioOccModel.serie ?? 'AAA',
															labelText: 'Serie',
															hintText: 'Informe os dados para o campo Serie',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteRodoviarioOccController.cteRodoviarioOccModel.serie = newValue;
																cteRodoviarioOccController.formWasChanged = true;
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
															controller: cteRodoviarioOccController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioOccController.cteRodoviarioOccModel.numero = int.tryParse(text);
																cteRodoviarioOccController.formWasChanged = true;
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
																dateTime: cteRodoviarioOccController.cteRodoviarioOccModel.dataEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	cteRodoviarioOccController.cteRodoviarioOccModel.dataEmissao = value;
																	cteRodoviarioOccController.formWasChanged = true;
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
															controller: cteRodoviarioOccController.cnpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj',
																labelText: 'Cnpj',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioOccController.cteRodoviarioOccModel.cnpj = text;
																cteRodoviarioOccController.formWasChanged = true;
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
															maxLength: 10,
															controller: cteRodoviarioOccController.codigoInternoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Interno',
																labelText: 'Codigo Interno',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioOccController.cteRodoviarioOccModel.codigoInterno = text;
																cteRodoviarioOccController.formWasChanged = true;
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
															controller: cteRodoviarioOccController.ieController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ie',
																labelText: 'Ie',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioOccController.cteRodoviarioOccModel.ie = text;
																cteRodoviarioOccController.formWasChanged = true;
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
															value: cteRodoviarioOccController.cteRodoviarioOccModel.uf ?? 'AC',
															labelText: 'Uf',
															hintText: 'Informe os dados para o campo Uf',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																cteRodoviarioOccController.cteRodoviarioOccModel.uf = newValue;
																cteRodoviarioOccController.formWasChanged = true;
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
															controller: cteRodoviarioOccController.telefoneController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Telefone',
																labelText: 'Telefone',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteRodoviarioOccController.cteRodoviarioOccModel.telefone = text;
																cteRodoviarioOccController.formWasChanged = true;
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
