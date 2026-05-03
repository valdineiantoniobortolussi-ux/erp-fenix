import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:projetos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:projetos/app/controller/projeto_custo_controller.dart';
import 'package:projetos/app/infra/infra_imports.dart';
import 'package:projetos/app/page/shared_widget/input/input_imports.dart';

class ProjetoCustoEditPage extends StatelessWidget {
	ProjetoCustoEditPage({Key? key}) : super(key: key);
	final projetoCustoController = Get.find<ProjetoCustoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: projetoCustoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Custos - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: projetoCustoController.save),
						cancelAndExitButton(onPressed: projetoCustoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: projetoCustoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: projetoCustoController.scrollController,
							child: SingleChildScrollView(
								controller: projetoCustoController.scrollController,
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
																		controller: projetoCustoController.finNaturezaFinanceiraModelController,
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
																child: lookupButton(onPressed: projetoCustoController.callFinNaturezaFinanceiraLookup),
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
															maxLength: 100,
															controller: projetoCustoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoCustoController.projetoCustoModel.nome = text;
																projetoCustoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: projetoCustoController.valorMensalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Mensal',
																labelText: 'Valor Mensal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoCustoController.projetoCustoModel.valorMensal = projetoCustoController.valorMensalController.numberValue;
																projetoCustoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: projetoCustoController.valorTotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total',
																labelText: 'Valor Total',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoCustoController.projetoCustoModel.valorTotal = projetoCustoController.valorTotalController.numberValue;
																projetoCustoController.formWasChanged = true;
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
															controller: projetoCustoController.justificativaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Justificativa',
																labelText: 'Justificativa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoCustoController.projetoCustoModel.justificativa = text;
																projetoCustoController.formWasChanged = true;
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
