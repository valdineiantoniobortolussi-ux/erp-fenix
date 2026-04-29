import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:compras/app/page/shared_widget/shared_widget_imports.dart';
import 'package:compras/app/controller/compra_requisicao_detalhe_controller.dart';
import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/page/shared_widget/input/input_imports.dart';

class CompraRequisicaoDetalheEditPage extends StatelessWidget {
	CompraRequisicaoDetalheEditPage({Key? key}) : super(key: key);
	final compraRequisicaoDetalheController = Get.find<CompraRequisicaoDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: compraRequisicaoDetalheController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Itens Requisição - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: compraRequisicaoDetalheController.save),
						cancelAndExitButton(onPressed: compraRequisicaoDetalheController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: compraRequisicaoDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: compraRequisicaoDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: compraRequisicaoDetalheController.scrollController,
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
													sizes: 'col-12 col-md-10',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: compraRequisicaoDetalheController.produtoModelController,
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
																child: lookupButton(onPressed: compraRequisicaoDetalheController.callProdutoLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: compraRequisicaoDetalheController.quantidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade',
																labelText: 'Quantidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraRequisicaoDetalheController.compraRequisicaoDetalheModel.quantidade = compraRequisicaoDetalheController.quantidadeController.numberValue;
																compraRequisicaoDetalheController.formWasChanged = true;
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
