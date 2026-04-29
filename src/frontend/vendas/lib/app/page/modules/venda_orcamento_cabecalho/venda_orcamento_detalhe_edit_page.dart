import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:vendas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:vendas/app/controller/venda_orcamento_detalhe_controller.dart';
import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/page/shared_widget/input/input_imports.dart';

class VendaOrcamentoDetalheEditPage extends StatelessWidget {
	VendaOrcamentoDetalheEditPage({Key? key}) : super(key: key);
	final vendaOrcamentoDetalheController = Get.find<VendaOrcamentoDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: vendaOrcamentoDetalheController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Itens do Orçamento - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: vendaOrcamentoDetalheController.save),
						cancelAndExitButton(onPressed: vendaOrcamentoDetalheController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: vendaOrcamentoDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: vendaOrcamentoDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: vendaOrcamentoDetalheController.scrollController,
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
																		controller: vendaOrcamentoDetalheController.produtoModelController,
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
																child: lookupButton(onPressed: vendaOrcamentoDetalheController.callProdutoLookup),
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
															controller: vendaOrcamentoDetalheController.quantidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade',
																labelText: 'Quantidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoDetalheController.vendaOrcamentoDetalheModel.quantidade = vendaOrcamentoDetalheController.quantidadeController.numberValue;
																vendaOrcamentoDetalheController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: vendaOrcamentoDetalheController.valorUnitarioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Unitario',
																labelText: 'Valor Unitario',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoDetalheController.vendaOrcamentoDetalheModel.valorUnitario = vendaOrcamentoDetalheController.valorUnitarioController.numberValue;
																vendaOrcamentoDetalheController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: vendaOrcamentoDetalheController.valorSubtotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Subtotal',
																labelText: 'Valor Subtotal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoDetalheController.vendaOrcamentoDetalheModel.valorSubtotal = vendaOrcamentoDetalheController.valorSubtotalController.numberValue;
																vendaOrcamentoDetalheController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: vendaOrcamentoDetalheController.taxaDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Desconto',
																labelText: 'Taxa Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoDetalheController.vendaOrcamentoDetalheModel.taxaDesconto = vendaOrcamentoDetalheController.taxaDescontoController.numberValue;
																vendaOrcamentoDetalheController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: vendaOrcamentoDetalheController.valorDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto',
																labelText: 'Valor Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoDetalheController.vendaOrcamentoDetalheModel.valorDesconto = vendaOrcamentoDetalheController.valorDescontoController.numberValue;
																vendaOrcamentoDetalheController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: vendaOrcamentoDetalheController.valorTotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total',
																labelText: 'Valor Total',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoDetalheController.vendaOrcamentoDetalheModel.valorTotal = vendaOrcamentoDetalheController.valorTotalController.numberValue;
																vendaOrcamentoDetalheController.formWasChanged = true;
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
