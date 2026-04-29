import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:orcamentos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:orcamentos/app/controller/orcamento_empresarial_controller.dart';
import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/page/shared_widget/input/input_imports.dart';

class OrcamentoEmpresarialEditPage extends StatelessWidget {
	OrcamentoEmpresarialEditPage({Key? key}) : super(key: key);
	final orcamentoEmpresarialController = Get.find<OrcamentoEmpresarialController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: orcamentoEmpresarialController.orcamentoEmpresarialEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: orcamentoEmpresarialController.orcamentoEmpresarialEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: orcamentoEmpresarialController.scrollController,
							child: SingleChildScrollView(
								controller: orcamentoEmpresarialController.scrollController,
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
																		controller: orcamentoEmpresarialController.orcamentoPeriodoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Periodo',
																			labelText: 'Periodo *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: orcamentoEmpresarialController.callOrcamentoPeriodoLookup),
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
														child: TextFormField(
															autofocus: true,
															maxLength: 30,
															controller: orcamentoEmpresarialController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																orcamentoEmpresarialController.orcamentoEmpresarialModel.nome = text;
																orcamentoEmpresarialController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Inicial',
																labelText: 'Data Inicial',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: orcamentoEmpresarialController.orcamentoEmpresarialModel.dataInicial,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	orcamentoEmpresarialController.orcamentoEmpresarialModel.dataInicial = value;
																	orcamentoEmpresarialController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: orcamentoEmpresarialController.numeroPeriodosController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Periodos',
																labelText: 'Numero Periodos',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																orcamentoEmpresarialController.orcamentoEmpresarialModel.numeroPeriodos = int.tryParse(text);
																orcamentoEmpresarialController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Base',
																labelText: 'Data Base',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: orcamentoEmpresarialController.orcamentoEmpresarialModel.dataBase,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	orcamentoEmpresarialController.orcamentoEmpresarialModel.dataBase = value;
																	orcamentoEmpresarialController.formWasChanged = true;
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
															controller: orcamentoEmpresarialController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																orcamentoEmpresarialController.orcamentoEmpresarialModel.descricao = text;
																orcamentoEmpresarialController.formWasChanged = true;
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
