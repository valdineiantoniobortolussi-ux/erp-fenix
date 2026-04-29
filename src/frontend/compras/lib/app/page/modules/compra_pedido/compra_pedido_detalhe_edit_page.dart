import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:compras/app/page/shared_widget/shared_widget_imports.dart';
import 'package:compras/app/controller/compra_pedido_detalhe_controller.dart';
import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/page/shared_widget/input/input_imports.dart';

class CompraPedidoDetalheEditPage extends StatelessWidget {
	CompraPedidoDetalheEditPage({Key? key}) : super(key: key);
	final compraPedidoDetalheController = Get.find<CompraPedidoDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: compraPedidoDetalheController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Itens Pedido - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: compraPedidoDetalheController.save),
						cancelAndExitButton(onPressed: compraPedidoDetalheController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: compraPedidoDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: compraPedidoDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: compraPedidoDetalheController.scrollController,
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
																		controller: compraPedidoDetalheController.produtoModelController,
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
																child: lookupButton(onPressed: compraPedidoDetalheController.callProdutoLookup),
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
															controller: compraPedidoDetalheController.quantidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade',
																labelText: 'Quantidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.quantidade = compraPedidoDetalheController.quantidadeController.numberValue;
																compraPedidoDetalheController.formWasChanged = true;
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
															controller: compraPedidoDetalheController.valorUnitarioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Unitario',
																labelText: 'Valor Unitario',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.valorUnitario = compraPedidoDetalheController.valorUnitarioController.numberValue;
																compraPedidoDetalheController.formWasChanged = true;
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
															controller: compraPedidoDetalheController.valorSubtotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Subtotal',
																labelText: 'Valor Subtotal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.valorSubtotal = compraPedidoDetalheController.valorSubtotalController.numberValue;
																compraPedidoDetalheController.formWasChanged = true;
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
															controller: compraPedidoDetalheController.taxaDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Desconto',
																labelText: 'Taxa Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.taxaDesconto = compraPedidoDetalheController.taxaDescontoController.numberValue;
																compraPedidoDetalheController.formWasChanged = true;
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
															controller: compraPedidoDetalheController.valorDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto',
																labelText: 'Valor Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.valorDesconto = compraPedidoDetalheController.valorDescontoController.numberValue;
																compraPedidoDetalheController.formWasChanged = true;
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
															controller: compraPedidoDetalheController.valorTotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total',
																labelText: 'Valor Total',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.valorTotal = compraPedidoDetalheController.valorTotalController.numberValue;
																compraPedidoDetalheController.formWasChanged = true;
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
															maxLength: 2,
															controller: compraPedidoDetalheController.cstController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cst',
																labelText: 'Cst',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.cst = text;
																compraPedidoDetalheController.formWasChanged = true;
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
															maxLength: 3,
															controller: compraPedidoDetalheController.csosnController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Csosn',
																labelText: 'Csosn',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.csosn = text;
																compraPedidoDetalheController.formWasChanged = true;
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
															controller: compraPedidoDetalheController.cfopController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cfop',
																labelText: 'Cfop',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.cfop = int.tryParse(text);
																compraPedidoDetalheController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: compraPedidoDetalheController.baseCalculoIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Icms',
																labelText: 'Base Calculo Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.baseCalculoIcms = compraPedidoDetalheController.baseCalculoIcmsController.numberValue;
																compraPedidoDetalheController.formWasChanged = true;
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
															controller: compraPedidoDetalheController.valorIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms',
																labelText: 'Valor Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.valorIcms = compraPedidoDetalheController.valorIcmsController.numberValue;
																compraPedidoDetalheController.formWasChanged = true;
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
															controller: compraPedidoDetalheController.valorIpiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Ipi',
																labelText: 'Valor Ipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.valorIpi = compraPedidoDetalheController.valorIpiController.numberValue;
																compraPedidoDetalheController.formWasChanged = true;
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
															controller: compraPedidoDetalheController.aliquotaIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Icms',
																labelText: 'Aliquota Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.aliquotaIcms = compraPedidoDetalheController.aliquotaIcmsController.numberValue;
																compraPedidoDetalheController.formWasChanged = true;
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
															controller: compraPedidoDetalheController.aliquotaIpiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Ipi',
																labelText: 'Aliquota Ipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoDetalheController.compraPedidoDetalheModel.aliquotaIpi = compraPedidoDetalheController.aliquotaIpiController.numberValue;
																compraPedidoDetalheController.formWasChanged = true;
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
