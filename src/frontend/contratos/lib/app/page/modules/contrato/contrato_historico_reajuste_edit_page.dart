import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contratos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contratos/app/controller/contrato_historico_reajuste_controller.dart';
import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/page/shared_widget/input/input_imports.dart';

class ContratoHistoricoReajusteEditPage extends StatelessWidget {
	ContratoHistoricoReajusteEditPage({Key? key}) : super(key: key);
	final contratoHistoricoReajusteController = Get.find<ContratoHistoricoReajusteController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: contratoHistoricoReajusteController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Histórico de Reajustes - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: contratoHistoricoReajusteController.save),
						cancelAndExitButton(onPressed: contratoHistoricoReajusteController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contratoHistoricoReajusteController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contratoHistoricoReajusteController.scrollController,
							child: SingleChildScrollView(
								controller: contratoHistoricoReajusteController.scrollController,
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
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: contratoHistoricoReajusteController.indiceController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Indice',
																labelText: 'Indice',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contratoHistoricoReajusteController.contratoHistoricoReajusteModel.indice = contratoHistoricoReajusteController.indiceController.numberValue;
																contratoHistoricoReajusteController.formWasChanged = true;
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
															controller: contratoHistoricoReajusteController.valorAnteriorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Anterior',
																labelText: 'Valor Anterior',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contratoHistoricoReajusteController.contratoHistoricoReajusteModel.valorAnterior = contratoHistoricoReajusteController.valorAnteriorController.numberValue;
																contratoHistoricoReajusteController.formWasChanged = true;
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
															controller: contratoHistoricoReajusteController.valorAtualController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Atual',
																labelText: 'Valor Atual',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contratoHistoricoReajusteController.contratoHistoricoReajusteModel.valorAtual = contratoHistoricoReajusteController.valorAtualController.numberValue;
																contratoHistoricoReajusteController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Reajuste',
																labelText: 'Data Reajuste',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: contratoHistoricoReajusteController.contratoHistoricoReajusteModel.dataReajuste,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contratoHistoricoReajusteController.contratoHistoricoReajusteModel.dataReajuste = value;
																	contratoHistoricoReajusteController.formWasChanged = true;
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
															controller: contratoHistoricoReajusteController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contratoHistoricoReajusteController.contratoHistoricoReajusteModel.observacao = text;
																contratoHistoricoReajusteController.formWasChanged = true;
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
