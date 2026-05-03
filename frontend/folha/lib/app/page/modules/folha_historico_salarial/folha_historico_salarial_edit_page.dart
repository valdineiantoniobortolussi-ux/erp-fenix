import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/folha_historico_salarial_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FolhaHistoricoSalarialEditPage extends StatelessWidget {
	FolhaHistoricoSalarialEditPage({Key? key}) : super(key: key);
	final folhaHistoricoSalarialController = Get.find<FolhaHistoricoSalarialController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					folhaHistoricoSalarialController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: folhaHistoricoSalarialController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Histórico Salarial - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: folhaHistoricoSalarialController.save),
						cancelAndExitButton(onPressed: folhaHistoricoSalarialController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: folhaHistoricoSalarialController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: folhaHistoricoSalarialController.scrollController,
							child: SingleChildScrollView(
								controller: folhaHistoricoSalarialController.scrollController,
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
																		controller: folhaHistoricoSalarialController.viewPessoaColaboradorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Colaborador',
																			labelText: 'Colaborador *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: folhaHistoricoSalarialController.callViewPessoaColaboradorLookup),
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: folhaHistoricoSalarialController.competenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Competencia',
																labelText: 'Competencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaHistoricoSalarialController.folhaHistoricoSalarialModel.competencia = text;
																folhaHistoricoSalarialController.formWasChanged = true;
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
															controller: folhaHistoricoSalarialController.salarioAtualController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Salario Atual',
																labelText: 'Salario Atual',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaHistoricoSalarialController.folhaHistoricoSalarialModel.salarioAtual = folhaHistoricoSalarialController.salarioAtualController.numberValue;
																folhaHistoricoSalarialController.formWasChanged = true;
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
															controller: folhaHistoricoSalarialController.percentualAumentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Aumento',
																labelText: 'Percentual Aumento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaHistoricoSalarialController.folhaHistoricoSalarialModel.percentualAumento = folhaHistoricoSalarialController.percentualAumentoController.numberValue;
																folhaHistoricoSalarialController.formWasChanged = true;
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
															controller: folhaHistoricoSalarialController.salarioNovoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Salario Novo',
																labelText: 'Salario Novo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaHistoricoSalarialController.folhaHistoricoSalarialModel.salarioNovo = folhaHistoricoSalarialController.salarioNovoController.numberValue;
																folhaHistoricoSalarialController.formWasChanged = true;
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
															controller: folhaHistoricoSalarialController.validoAPartirController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valido A Partir',
																labelText: 'Valido A Partir',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaHistoricoSalarialController.folhaHistoricoSalarialModel.validoAPartir = text;
																folhaHistoricoSalarialController.formWasChanged = true;
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
															controller: folhaHistoricoSalarialController.motivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Motivo',
																labelText: 'Motivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaHistoricoSalarialController.folhaHistoricoSalarialModel.motivo = text;
																folhaHistoricoSalarialController.formWasChanged = true;
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
