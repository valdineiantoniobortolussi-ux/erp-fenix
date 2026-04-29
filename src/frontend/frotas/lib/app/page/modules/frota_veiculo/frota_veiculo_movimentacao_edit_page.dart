import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:frotas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:frotas/app/controller/frota_veiculo_movimentacao_controller.dart';
import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/page/shared_widget/input/input_imports.dart';

class FrotaVeiculoMovimentacaoEditPage extends StatelessWidget {
	FrotaVeiculoMovimentacaoEditPage({Key? key}) : super(key: key);
	final frotaVeiculoMovimentacaoController = Get.find<FrotaVeiculoMovimentacaoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: frotaVeiculoMovimentacaoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Movimentação - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: frotaVeiculoMovimentacaoController.save),
						cancelAndExitButton(onPressed: frotaVeiculoMovimentacaoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: frotaVeiculoMovimentacaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: frotaVeiculoMovimentacaoController.scrollController,
							child: SingleChildScrollView(
								controller: frotaVeiculoMovimentacaoController.scrollController,
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
																		controller: frotaVeiculoMovimentacaoController.frotaMotoristaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Motorista',
																			labelText: 'Motorista *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: frotaVeiculoMovimentacaoController.callFrotaMotoristaLookup),
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Saida',
																labelText: 'Data Saida',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: frotaVeiculoMovimentacaoController.frotaVeiculoMovimentacaoModel.dataSaida,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	frotaVeiculoMovimentacaoController.frotaVeiculoMovimentacaoModel.dataSaida = value;
																	frotaVeiculoMovimentacaoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: frotaVeiculoMovimentacaoController.horaSaidaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Saida',
																labelText: 'Hora Saida',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoMovimentacaoController.frotaVeiculoMovimentacaoModel.horaSaida = text;
																frotaVeiculoMovimentacaoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Entrada',
																labelText: 'Data Entrada',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: frotaVeiculoMovimentacaoController.frotaVeiculoMovimentacaoModel.dataEntrada,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	frotaVeiculoMovimentacaoController.frotaVeiculoMovimentacaoModel.dataEntrada = value;
																	frotaVeiculoMovimentacaoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: frotaVeiculoMovimentacaoController.horaEntradaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Entrada',
																labelText: 'Hora Entrada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoMovimentacaoController.frotaVeiculoMovimentacaoModel.horaEntrada = text;
																frotaVeiculoMovimentacaoController.formWasChanged = true;
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
															maxLines: 3,
															controller: frotaVeiculoMovimentacaoController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoMovimentacaoController.frotaVeiculoMovimentacaoModel.observacao = text;
																frotaVeiculoMovimentacaoController.formWasChanged = true;
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
