import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:compras/app/page/shared_widget/shared_widget_imports.dart';
import 'package:compras/app/controller/compra_pedido_controller.dart';
import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/page/shared_widget/input/input_imports.dart';

class CompraPedidoEditPage extends StatelessWidget {
	CompraPedidoEditPage({Key? key}) : super(key: key);
	final compraPedidoController = Get.find<CompraPedidoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: compraPedidoController.compraPedidoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: compraPedidoController.compraPedidoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: compraPedidoController.scrollController,
							child: SingleChildScrollView(
								controller: compraPedidoController.scrollController,
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
													sizes: 'col-12 col-md-6',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: compraPedidoController.compraTipoPedidoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Tipo Pedido',
																			labelText: 'Tipo Pedido *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: compraPedidoController.callCompraTipoPedidoLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: compraPedidoController.viewPessoaColaboradorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Colaborador',
																			labelText: 'Colaborador *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: compraPedidoController.callViewPessoaColaboradorLookup),
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
													sizes: 'col-12 col-md-8',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: compraPedidoController.viewPessoaFornecedorModelController,
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
																child: lookupButton(onPressed: compraPedidoController.callViewPessoaFornecedorLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 32,
															controller: compraPedidoController.codigoCotacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Cotacao',
																labelText: 'Codigo Cotacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.codigoCotacao = text;
																compraPedidoController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Pedido',
																labelText: 'Data Pedido',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: compraPedidoController.compraPedidoModel.dataPedido,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	compraPedidoController.compraPedidoModel.dataPedido = value;
																	compraPedidoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Prevista Entrega',
																labelText: 'Data Prevista Entrega',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: compraPedidoController.compraPedidoModel.dataPrevistaEntrega,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	compraPedidoController.compraPedidoModel.dataPrevistaEntrega = value;
																	compraPedidoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Previsao Pagamento',
																labelText: 'Data Previsao Pagamento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: compraPedidoController.compraPedidoModel.dataPrevisaoPagamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	compraPedidoController.compraPedidoModel.dataPrevisaoPagamento = value;
																	compraPedidoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: compraPedidoController.localEntregaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Local Entrega',
																labelText: 'Local Entrega',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.localEntrega = text;
																compraPedidoController.formWasChanged = true;
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
															maxLength: 100,
															controller: compraPedidoController.localCobrancaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Local Cobranca',
																labelText: 'Local Cobranca',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.localCobranca = text;
																compraPedidoController.formWasChanged = true;
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
															maxLength: 50,
															controller: compraPedidoController.contatoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Contato',
																labelText: 'Contato',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.contato = text;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.valorSubtotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Subtotal',
																labelText: 'Valor Subtotal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.valorSubtotal = compraPedidoController.valorSubtotalController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.taxaDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Desconto',
																labelText: 'Taxa Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.taxaDesconto = compraPedidoController.taxaDescontoController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.valorDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto',
																labelText: 'Valor Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.valorDesconto = compraPedidoController.valorDescontoController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.valorTotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total',
																labelText: 'Valor Total',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.valorTotal = compraPedidoController.valorTotalController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															value: compraPedidoController.compraPedidoModel.tipoFrete ?? 'CIF',
															labelText: 'Tipo Frete',
															hintText: 'Informe os dados para o campo Tipo Frete',
															items: const ['CIF','FOB'],
															onChanged: (dynamic newValue) {
																compraPedidoController.compraPedidoModel.tipoFrete = newValue;
																compraPedidoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: compraPedidoController.compraPedidoModel.formaPagamento ?? 'Vista',
															labelText: 'Forma Pagamento',
															hintText: 'Informe os dados para o campo Forma Pagamento',
															items: const ['Vista','Prazo','Outros'],
															onChanged: (dynamic newValue) {
																compraPedidoController.compraPedidoModel.formaPagamento = newValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.baseCalculoIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Icms',
																labelText: 'Base Calculo Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.baseCalculoIcms = compraPedidoController.baseCalculoIcmsController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.valorIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms',
																labelText: 'Valor Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.valorIcms = compraPedidoController.valorIcmsController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.baseCalculoIcmsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Icms St',
																labelText: 'Base Calculo Icms St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.baseCalculoIcmsSt = compraPedidoController.baseCalculoIcmsStController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.valorIcmsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms St',
																labelText: 'Valor Icms St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.valorIcmsSt = compraPedidoController.valorIcmsStController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.valorTotalProdutosController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Produtos',
																labelText: 'Valor Total Produtos',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.valorTotalProdutos = compraPedidoController.valorTotalProdutosController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.valorFreteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Frete',
																labelText: 'Valor Frete',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.valorFrete = compraPedidoController.valorFreteController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.valorSeguroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Seguro',
																labelText: 'Valor Seguro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.valorSeguro = compraPedidoController.valorSeguroController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.valorOutrasDespesasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Outras Despesas',
																labelText: 'Valor Outras Despesas',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.valorOutrasDespesas = compraPedidoController.valorOutrasDespesasController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.valorIpiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Ipi',
																labelText: 'Valor Ipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.valorIpi = compraPedidoController.valorIpiController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.valorTotalNfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Nf',
																labelText: 'Valor Total Nf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.valorTotalNf = compraPedidoController.valorTotalNfController.numberValue;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.quantidadeParcelasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Parcelas',
																labelText: 'Quantidade Parcelas',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.quantidadeParcelas = int.tryParse(text);
																compraPedidoController.formWasChanged = true;
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
															maxLength: 2,
															controller: compraPedidoController.diaPrimeiroVencimentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dia Primeiro Vencimento',
																labelText: 'Dia Primeiro Vencimento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.diaPrimeiroVencimento = text;
																compraPedidoController.formWasChanged = true;
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
															controller: compraPedidoController.intervaloEntreParcelasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Intervalo Entre Parcelas',
																labelText: 'Intervalo Entre Parcelas',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.intervaloEntreParcelas = int.tryParse(text);
																compraPedidoController.formWasChanged = true;
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
															maxLength: 2,
															controller: compraPedidoController.diaFixoParcelaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dia Fixo Parcela',
																labelText: 'Dia Fixo Parcela',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																compraPedidoController.compraPedidoModel.diaFixoParcela = text;
																compraPedidoController.formWasChanged = true;
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
