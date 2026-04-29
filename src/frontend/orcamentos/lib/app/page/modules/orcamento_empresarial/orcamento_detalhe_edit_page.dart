import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:orcamentos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:orcamentos/app/controller/orcamento_detalhe_controller.dart';
import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/page/shared_widget/input/input_imports.dart';

class OrcamentoDetalheEditPage extends StatelessWidget {
	OrcamentoDetalheEditPage({Key? key}) : super(key: key);
	final orcamentoDetalheController = Get.find<OrcamentoDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: orcamentoDetalheController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Itens - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: orcamentoDetalheController.save),
						cancelAndExitButton(onPressed: orcamentoDetalheController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: orcamentoDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: orcamentoDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: orcamentoDetalheController.scrollController,
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
																		controller: orcamentoDetalheController.finNaturezaFinanceiraModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Natureza Financeira',
																			labelText: 'Natureza Financeira *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: orcamentoDetalheController.callFinNaturezaFinanceiraLookup),
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
														child: TextFormField(
															autofocus: true,
															maxLength: 10,
															controller: orcamentoDetalheController.periodoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Periodo',
																labelText: 'Periodo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																orcamentoDetalheController.orcamentoDetalheModel.periodo = text;
																orcamentoDetalheController.formWasChanged = true;
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
															controller: orcamentoDetalheController.valorOrcadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Orcado',
																labelText: 'Valor Orcado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																orcamentoDetalheController.orcamentoDetalheModel.valorOrcado = orcamentoDetalheController.valorOrcadoController.numberValue;
																orcamentoDetalheController.formWasChanged = true;
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
															controller: orcamentoDetalheController.valorRealizadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Realizado',
																labelText: 'Valor Realizado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																orcamentoDetalheController.orcamentoDetalheModel.valorRealizado = orcamentoDetalheController.valorRealizadoController.numberValue;
																orcamentoDetalheController.formWasChanged = true;
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
															controller: orcamentoDetalheController.taxaVariacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Variacao',
																labelText: 'Taxa Variacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																orcamentoDetalheController.orcamentoDetalheModel.taxaVariacao = orcamentoDetalheController.taxaVariacaoController.numberValue;
																orcamentoDetalheController.formWasChanged = true;
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
															controller: orcamentoDetalheController.valorVariacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Variacao',
																labelText: 'Valor Variacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																orcamentoDetalheController.orcamentoDetalheModel.valorVariacao = orcamentoDetalheController.valorVariacaoController.numberValue;
																orcamentoDetalheController.formWasChanged = true;
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
