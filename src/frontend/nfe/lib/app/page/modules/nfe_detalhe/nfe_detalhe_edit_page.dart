import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_detalhe_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeDetalheEditPage extends StatelessWidget {
	NfeDetalheEditPage({Key? key}) : super(key: key);
	final nfeDetalheController = Get.find<NfeDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeDetalheController.nfeDetalheEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeDetalheController.nfeDetalheEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: nfeDetalheController.scrollController,
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
																		controller: nfeDetalheController.nfeCabecalhoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Nfe Cabecalho',
																			labelText: 'NF-e *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: nfeDetalheController.callNfeCabecalhoLookup),
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: nfeDetalheController.produtoModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Produto',
																			labelText: 'Id Produto',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: nfeDetalheController.callProdutoLookup),
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
															controller: nfeDetalheController.numeroItemController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Item',
																labelText: 'Numero Item',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.numeroItem = int.tryParse(text);
																nfeDetalheController.formWasChanged = true;
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
															maxLength: 60,
															controller: nfeDetalheController.codigoProdutoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Produto',
																labelText: 'Codigo Produto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.codigoProduto = text;
																nfeDetalheController.formWasChanged = true;
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
															maxLength: 14,
															controller: nfeDetalheController.gtinController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Gtin',
																labelText: 'Gtin',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.gtin = text;
																nfeDetalheController.formWasChanged = true;
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
															maxLength: 120,
															controller: nfeDetalheController.nomeProdutoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Produto',
																labelText: 'Nome Produto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.nomeProduto = text;
																nfeDetalheController.formWasChanged = true;
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
															maxLength: 8,
															controller: nfeDetalheController.ncmController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ncm',
																labelText: 'Ncm',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.ncm = text;
																nfeDetalheController.formWasChanged = true;
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
															maxLength: 6,
															controller: nfeDetalheController.nveController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nve',
																labelText: 'Nve',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.nve = text;
																nfeDetalheController.formWasChanged = true;
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
															maxLength: 7,
															controller: nfeDetalheController.cestController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cest',
																labelText: 'Cest',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.cest = text;
																nfeDetalheController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: nfeDetalheController.nfeDetalheModel.indicadorEscalaRelevante ?? 'Sim',
															labelText: 'Indicador Escala Relevante',
															hintText: 'Informe os dados para o campo Indicador Escala Relevante',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																nfeDetalheController.nfeDetalheModel.indicadorEscalaRelevante = newValue;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.cnpjFabricanteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj Fabricante',
																labelText: 'Cnpj Fabricante',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.cnpjFabricante = text;
																nfeDetalheController.formWasChanged = true;
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
															maxLength: 10,
															controller: nfeDetalheController.codigoBeneficioFiscalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Beneficio Fiscal',
																labelText: 'Codigo Beneficio Fiscal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.codigoBeneficioFiscal = text;
																nfeDetalheController.formWasChanged = true;
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
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: nfeDetalheController.exTipiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ex Tipi',
																labelText: 'Ex Tipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.exTipi = int.tryParse(text);
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.cfopController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cfop',
																labelText: 'Cfop',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.cfop = int.tryParse(text);
																nfeDetalheController.formWasChanged = true;
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
															maxLength: 6,
															controller: nfeDetalheController.unidadeComercialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Unidade Comercial',
																labelText: 'Unidade Comercial',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.unidadeComercial = text;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.quantidadeComercialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Comercial',
																labelText: 'Quantidade Comercial',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.quantidadeComercial = nfeDetalheController.quantidadeComercialController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
															maxLength: 15,
															controller: nfeDetalheController.numeroPedidoCompraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Pedido Compra',
																labelText: 'Numero Pedido Compra',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.numeroPedidoCompra = text;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.itemPedidoCompraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Item Pedido Compra',
																labelText: 'Item Pedido Compra',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.itemPedidoCompra = int.tryParse(text);
																nfeDetalheController.formWasChanged = true;
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
															maxLength: 36,
															controller: nfeDetalheController.numeroFciController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Fci',
																labelText: 'Numero Fci',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.numeroFci = text;
																nfeDetalheController.formWasChanged = true;
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
															maxLength: 20,
															controller: nfeDetalheController.numeroRecopiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Recopi',
																labelText: 'Numero Recopi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.numeroRecopi = text;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.valorUnitarioComercialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Unitario Comercial',
																labelText: 'Valor Unitario Comercial',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.valorUnitarioComercial = nfeDetalheController.valorUnitarioComercialController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.valorBrutoProdutoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bruto Produto',
																labelText: 'Valor Bruto Produto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.valorBrutoProduto = nfeDetalheController.valorBrutoProdutoController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
															maxLength: 14,
															controller: nfeDetalheController.gtinUnidadeTributavelController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Gtin Unidade Tributavel',
																labelText: 'Gtin Unidade Tributavel',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.gtinUnidadeTributavel = text;
																nfeDetalheController.formWasChanged = true;
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
															maxLength: 6,
															controller: nfeDetalheController.unidadeTributavelController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Unidade Tributavel',
																labelText: 'Unidade Tributavel',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.unidadeTributavel = text;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.quantidadeTributavelController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Tributavel',
																labelText: 'Quantidade Tributavel',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.quantidadeTributavel = nfeDetalheController.quantidadeTributavelController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.valorUnitarioTributavelController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Unitario Tributavel',
																labelText: 'Valor Unitario Tributavel',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.valorUnitarioTributavel = nfeDetalheController.valorUnitarioTributavelController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.valorFreteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Frete',
																labelText: 'Valor Frete',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.valorFrete = nfeDetalheController.valorFreteController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.valorSeguroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Seguro',
																labelText: 'Valor Seguro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.valorSeguro = nfeDetalheController.valorSeguroController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.valorDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto',
																labelText: 'Valor Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.valorDesconto = nfeDetalheController.valorDescontoController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.valorOutrasDespesasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Outras Despesas',
																labelText: 'Valor Outras Despesas',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.valorOutrasDespesas = nfeDetalheController.valorOutrasDespesasController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: nfeDetalheController.nfeDetalheModel.entraTotal ?? '0=Valor do item (vProd) não compõe o valor total da NF-e',
															labelText: 'Entra Total',
															hintText: 'Informe os dados para o campo Entra Total',
															items: const ['0=Valor do item (vProd) não compõe o valor total da NF-e','1=Valor do item (vProd) compõe o valor total da NF-e (vProd)'],
															onChanged: (dynamic newValue) {
																nfeDetalheController.nfeDetalheModel.entraTotal = newValue;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.valorTotalTributosController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Tributos',
																labelText: 'Valor Total Tributos',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.valorTotalTributos = nfeDetalheController.valorTotalTributosController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.percentualDevolvidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Devolvido',
																labelText: 'Percentual Devolvido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.percentualDevolvido = nfeDetalheController.percentualDevolvidoController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.valorIpiDevolvidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Ipi Devolvido',
																labelText: 'Valor Ipi Devolvido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.valorIpiDevolvido = nfeDetalheController.valorIpiDevolvidoController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.informacoesAdicionaisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Informacoes Adicionais',
																labelText: 'Informacoes Adicionais',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.informacoesAdicionais = text;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.valorSubtotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Subtotal',
																labelText: 'Valor Subtotal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.valorSubtotal = nfeDetalheController.valorSubtotalController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
															controller: nfeDetalheController.valorTotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total',
																labelText: 'Valor Total',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheController.nfeDetalheModel.valorTotal = nfeDetalheController.valorTotalController.numberValue;
																nfeDetalheController.formWasChanged = true;
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
