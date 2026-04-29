import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:compras/app/page/shared_widget/shared_widget_imports.dart';
import 'package:compras/app/controller/compra_cotacao_detalhe_controller.dart';
import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/page/shared_widget/input/input_imports.dart';

class CompraCotacaoDetalheEditPage extends StatelessWidget {
	CompraCotacaoDetalheEditPage({Key? key}) : super(key: key);
	final compraCotacaoDetalheController = Get.find<CompraCotacaoDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: compraCotacaoDetalheController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Itens Cotação - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: compraCotacaoDetalheController.save),
						cancelAndExitButton(onPressed: compraCotacaoDetalheController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: compraCotacaoDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: compraCotacaoDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: compraCotacaoDetalheController.scrollController,
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
																		controller: compraCotacaoDetalheController.produtoModelController,
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
																child: lookupButton(onPressed: compraCotacaoDetalheController.callProdutoLookup),
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
															controller: compraCotacaoDetalheController.quantidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade',
																labelText: 'Quantidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraCotacaoDetalheController.compraCotacaoDetalheModel.quantidade = compraCotacaoDetalheController.quantidadeController.numberValue;
																compraCotacaoDetalheController.formWasChanged = true;
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
															controller: compraCotacaoDetalheController.valorUnitarioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Unitario',
																labelText: 'Valor Unitario',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraCotacaoDetalheController.compraCotacaoDetalheModel.valorUnitario = compraCotacaoDetalheController.valorUnitarioController.numberValue;
																compraCotacaoDetalheController.formWasChanged = true;
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
															controller: compraCotacaoDetalheController.valorSubtotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Subtotal',
																labelText: 'Valor Subtotal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraCotacaoDetalheController.compraCotacaoDetalheModel.valorSubtotal = compraCotacaoDetalheController.valorSubtotalController.numberValue;
																compraCotacaoDetalheController.formWasChanged = true;
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
															controller: compraCotacaoDetalheController.taxaDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Desconto',
																labelText: 'Taxa Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraCotacaoDetalheController.compraCotacaoDetalheModel.taxaDesconto = compraCotacaoDetalheController.taxaDescontoController.numberValue;
																compraCotacaoDetalheController.formWasChanged = true;
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
															controller: compraCotacaoDetalheController.valorDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto',
																labelText: 'Valor Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraCotacaoDetalheController.compraCotacaoDetalheModel.valorDesconto = compraCotacaoDetalheController.valorDescontoController.numberValue;
																compraCotacaoDetalheController.formWasChanged = true;
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
															controller: compraCotacaoDetalheController.valorTotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total',
																labelText: 'Valor Total',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraCotacaoDetalheController.compraCotacaoDetalheModel.valorTotal = compraCotacaoDetalheController.valorTotalController.numberValue;
																compraCotacaoDetalheController.formWasChanged = true;
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
