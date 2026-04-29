import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:compras/app/page/shared_widget/shared_widget_imports.dart';
import 'package:compras/app/controller/compra_fornecedor_cotacao_controller.dart';
import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/page/shared_widget/input/input_imports.dart';

class CompraFornecedorCotacaoEditPage extends StatelessWidget {
	CompraFornecedorCotacaoEditPage({Key? key}) : super(key: key);
	final compraFornecedorCotacaoController = Get.find<CompraFornecedorCotacaoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: compraFornecedorCotacaoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Fornecedores - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: compraFornecedorCotacaoController.save),
						cancelAndExitButton(onPressed: compraFornecedorCotacaoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: compraFornecedorCotacaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: compraFornecedorCotacaoController.scrollController,
							child: SingleChildScrollView(
								controller: compraFornecedorCotacaoController.scrollController,
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
																		controller: compraFornecedorCotacaoController.viewPessoaFornecedorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Fornecedor',
																			labelText: 'Fornecedor *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: compraFornecedorCotacaoController.callViewPessoaFornecedorLookup),
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
															maxLength: 32,
															controller: compraFornecedorCotacaoController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraFornecedorCotacaoController.compraFornecedorCotacaoModel.codigo = text;
																compraFornecedorCotacaoController.formWasChanged = true;
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
															maxLength: 50,
															controller: compraFornecedorCotacaoController.prazoEntregaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Prazo Entrega',
																labelText: 'Prazo Entrega',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraFornecedorCotacaoController.compraFornecedorCotacaoModel.prazoEntrega = text;
																compraFornecedorCotacaoController.formWasChanged = true;
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
															maxLength: 50,
															controller: compraFornecedorCotacaoController.vendaCondicoesPagamentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Venda Condicoes Pagamento',
																labelText: 'Venda Condicoes Pagamento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraFornecedorCotacaoController.compraFornecedorCotacaoModel.vendaCondicoesPagamento = text;
																compraFornecedorCotacaoController.formWasChanged = true;
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
															controller: compraFornecedorCotacaoController.valorSubtotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Subtotal',
																labelText: 'Valor Subtotal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraFornecedorCotacaoController.compraFornecedorCotacaoModel.valorSubtotal = compraFornecedorCotacaoController.valorSubtotalController.numberValue;
																compraFornecedorCotacaoController.formWasChanged = true;
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
															controller: compraFornecedorCotacaoController.taxaDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Desconto',
																labelText: 'Taxa Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraFornecedorCotacaoController.compraFornecedorCotacaoModel.taxaDesconto = compraFornecedorCotacaoController.taxaDescontoController.numberValue;
																compraFornecedorCotacaoController.formWasChanged = true;
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
															controller: compraFornecedorCotacaoController.valorDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto',
																labelText: 'Valor Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraFornecedorCotacaoController.compraFornecedorCotacaoModel.valorDesconto = compraFornecedorCotacaoController.valorDescontoController.numberValue;
																compraFornecedorCotacaoController.formWasChanged = true;
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
															controller: compraFornecedorCotacaoController.valorTotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total',
																labelText: 'Valor Total',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraFornecedorCotacaoController.compraFornecedorCotacaoModel.valorTotal = compraFornecedorCotacaoController.valorTotalController.numberValue;
																compraFornecedorCotacaoController.formWasChanged = true;
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
