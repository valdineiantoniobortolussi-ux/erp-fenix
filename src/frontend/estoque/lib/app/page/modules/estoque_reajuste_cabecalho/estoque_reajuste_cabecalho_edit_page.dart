import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:estoque/app/page/shared_widget/shared_widget_imports.dart';
import 'package:estoque/app/controller/estoque_reajuste_cabecalho_controller.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/page/shared_widget/input/input_imports.dart';

class EstoqueReajusteCabecalhoEditPage extends StatelessWidget {
	EstoqueReajusteCabecalhoEditPage({Key? key}) : super(key: key);
	final estoqueReajusteCabecalhoController = Get.find<EstoqueReajusteCabecalhoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: estoqueReajusteCabecalhoController.estoqueReajusteCabecalhoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: estoqueReajusteCabecalhoController.estoqueReajusteCabecalhoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: estoqueReajusteCabecalhoController.scrollController,
							child: SingleChildScrollView(
								controller: estoqueReajusteCabecalhoController.scrollController,
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
																		controller: estoqueReajusteCabecalhoController.viewPessoaColaboradorModelController,
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
																child: lookupButton(onPressed: estoqueReajusteCabecalhoController.callViewPessoaColaboradorLookup),
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Reajuste',
																labelText: 'Data Reajuste',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: estoqueReajusteCabecalhoController.estoqueReajusteCabecalhoModel.dataReajuste,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	estoqueReajusteCabecalhoController.estoqueReajusteCabecalhoModel.dataReajuste = value;
																	estoqueReajusteCabecalhoController.formWasChanged = true;
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
															controller: estoqueReajusteCabecalhoController.taxaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa',
																labelText: 'Taxa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																estoqueReajusteCabecalhoController.estoqueReajusteCabecalhoModel.taxa = estoqueReajusteCabecalhoController.taxaController.numberValue;
																estoqueReajusteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: estoqueReajusteCabecalhoController.estoqueReajusteCabecalhoModel.tipoReajuste ?? 'Aumentar',
															labelText: 'Tipo Reajuste',
															hintText: 'Informe os dados para o campo Tipo Reajuste',
															items: const ['Aumentar','Diminuir'],
															onChanged: (dynamic newValue) {
																estoqueReajusteCabecalhoController.estoqueReajusteCabecalhoModel.tipoReajuste = newValue;
																estoqueReajusteCabecalhoController.formWasChanged = true;
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
															controller: estoqueReajusteCabecalhoController.justificativaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Justificativa',
																labelText: 'Justificativa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																estoqueReajusteCabecalhoController.estoqueReajusteCabecalhoModel.justificativa = text;
																estoqueReajusteCabecalhoController.formWasChanged = true;
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
