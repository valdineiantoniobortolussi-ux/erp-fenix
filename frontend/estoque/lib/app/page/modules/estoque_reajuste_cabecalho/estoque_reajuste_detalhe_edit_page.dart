import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:estoque/app/page/shared_widget/shared_widget_imports.dart';
import 'package:estoque/app/controller/estoque_reajuste_detalhe_controller.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/page/shared_widget/input/input_imports.dart';

class EstoqueReajusteDetalheEditPage extends StatelessWidget {
	EstoqueReajusteDetalheEditPage({Key? key}) : super(key: key);
	final estoqueReajusteDetalheController = Get.find<EstoqueReajusteDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: estoqueReajusteDetalheController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Itens do Reajuste - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: estoqueReajusteDetalheController.save),
						cancelAndExitButton(onPressed: estoqueReajusteDetalheController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: estoqueReajusteDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: estoqueReajusteDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: estoqueReajusteDetalheController.scrollController,
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
																		controller: estoqueReajusteDetalheController.produtoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Produto',
																			labelText: 'Produto *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: estoqueReajusteDetalheController.callProdutoLookup),
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: estoqueReajusteDetalheController.valorOriginalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Original',
																labelText: 'Valor Original',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																estoqueReajusteDetalheController.estoqueReajusteDetalheModel.valorOriginal = estoqueReajusteDetalheController.valorOriginalController.numberValue;
																estoqueReajusteDetalheController.formWasChanged = true;
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
															controller: estoqueReajusteDetalheController.valorReajusteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Reajuste',
																labelText: 'Valor Reajuste',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																estoqueReajusteDetalheController.estoqueReajusteDetalheModel.valorReajuste = estoqueReajusteDetalheController.valorReajusteController.numberValue;
																estoqueReajusteDetalheController.formWasChanged = true;
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
