import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:orcamentos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:orcamentos/app/controller/orcamento_fluxo_caixa_controller.dart';
import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/page/shared_widget/input/input_imports.dart';

class OrcamentoFluxoCaixaEditPage extends StatelessWidget {
	OrcamentoFluxoCaixaEditPage({Key? key}) : super(key: key);
	final orcamentoFluxoCaixaController = Get.find<OrcamentoFluxoCaixaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: orcamentoFluxoCaixaController.orcamentoFluxoCaixaEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: orcamentoFluxoCaixaController.orcamentoFluxoCaixaEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: orcamentoFluxoCaixaController.scrollController,
							child: SingleChildScrollView(
								controller: orcamentoFluxoCaixaController.scrollController,
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
																		controller: orcamentoFluxoCaixaController.orcamentoFluxoCaixaPeriodoModelController,
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
																child: lookupButton(onPressed: orcamentoFluxoCaixaController.callOrcamentoFluxoCaixaPeriodoLookup),
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
															controller: orcamentoFluxoCaixaController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																orcamentoFluxoCaixaController.orcamentoFluxoCaixaModel.nome = text;
																orcamentoFluxoCaixaController.formWasChanged = true;
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
																dateTime: orcamentoFluxoCaixaController.orcamentoFluxoCaixaModel.dataInicial,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	orcamentoFluxoCaixaController.orcamentoFluxoCaixaModel.dataInicial = value;
																	orcamentoFluxoCaixaController.formWasChanged = true;
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
															controller: orcamentoFluxoCaixaController.numeroPeriodosController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Periodos',
																labelText: 'Numero Periodos',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																orcamentoFluxoCaixaController.orcamentoFluxoCaixaModel.numeroPeriodos = int.tryParse(text);
																orcamentoFluxoCaixaController.formWasChanged = true;
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
																dateTime: orcamentoFluxoCaixaController.orcamentoFluxoCaixaModel.dataBase,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	orcamentoFluxoCaixaController.orcamentoFluxoCaixaModel.dataBase = value;
																	orcamentoFluxoCaixaController.formWasChanged = true;
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
															controller: orcamentoFluxoCaixaController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																orcamentoFluxoCaixaController.orcamentoFluxoCaixaModel.descricao = text;
																orcamentoFluxoCaixaController.formWasChanged = true;
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
