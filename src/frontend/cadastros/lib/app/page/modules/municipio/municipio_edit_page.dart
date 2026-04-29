import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/municipio_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class MunicipioEditPage extends StatelessWidget {
	MunicipioEditPage({Key? key}) : super(key: key);
	final municipioController = Get.find<MunicipioController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					municipioController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: municipioController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Município - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: municipioController.save),
						cancelAndExitButton(onPressed: municipioController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: municipioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: municipioController.scrollController,
							child: SingleChildScrollView(
								controller: municipioController.scrollController,
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: municipioController.ufModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo UF',
																			labelText: 'UF *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: municipioController.callUfLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-9',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: municipioController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																municipioController.municipioModel.nome = text;
																municipioController.formWasChanged = true;
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
															controller: municipioController.codigoIbgeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo IBGE',
																labelText: 'Codigo IBGE',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																municipioController.municipioModel.codigoIbge = int.tryParse(text);
																municipioController.formWasChanged = true;
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
															controller: municipioController.codigoReceitaFederalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Receita Federal',
																labelText: 'Codigo Receita Federal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																municipioController.municipioModel.codigoReceitaFederal = int.tryParse(text);
																municipioController.formWasChanged = true;
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
															controller: municipioController.codigoEstadualController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Estadual',
																labelText: 'Codigo Estadual',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																municipioController.municipioModel.codigoEstadual = int.tryParse(text);
																municipioController.formWasChanged = true;
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
