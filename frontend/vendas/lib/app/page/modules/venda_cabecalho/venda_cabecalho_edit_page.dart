import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:vendas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:vendas/app/controller/venda_cabecalho_controller.dart';
import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/page/shared_widget/input/input_imports.dart';

class VendaCabecalhoEditPage extends StatelessWidget {
	VendaCabecalhoEditPage({Key? key}) : super(key: key);
	final vendaCabecalhoController = Get.find<VendaCabecalhoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: vendaCabecalhoController.vendaCabecalhoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: vendaCabecalhoController.vendaCabecalhoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: vendaCabecalhoController.scrollController,
							child: SingleChildScrollView(
								controller: vendaCabecalhoController.scrollController,
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
													sizes: 'col-12 col-md-4',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: vendaCabecalhoController.vendaOrcamentoCabecalhoModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Orçamento',
																			labelText: 'Orçamento',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: vendaCabecalhoController.callVendaOrcamentoCabecalhoLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: vendaCabecalhoController.notaFiscalTipoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Tipo Nota Fiscal',
																			labelText: 'Tipo Nota Fiscal *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: vendaCabecalhoController.callNotaFiscalTipoLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: vendaCabecalhoController.viewPessoaVendedorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Vendedor',
																			labelText: 'Vendedor *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: vendaCabecalhoController.callViewPessoaVendedorLookup),
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: vendaCabecalhoController.vendaCondicoesPagamentoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Condicoes Pagamento',
																			labelText: 'Condicoes Pagamento *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: vendaCabecalhoController.callVendaCondicoesPagamentoLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: vendaCabecalhoController.viewPessoaTransportadoraModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Transportadora',
																			labelText: 'Transportadora *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: vendaCabecalhoController.callViewPessoaTransportadoraLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: vendaCabecalhoController.viewPessoaClienteModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Cliente',
																			labelText: 'Cliente *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: vendaCabecalhoController.callViewPessoaClienteLookup),
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
															maxLength: 100,
															controller: vendaCabecalhoController.localEntregaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Local Entrega',
																labelText: 'Local Entrega',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.localEntrega = text;
																vendaCabecalhoController.formWasChanged = true;
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
															controller: vendaCabecalhoController.localCobrancaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Local Cobranca',
																labelText: 'Local Cobranca',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.localCobranca = text;
																vendaCabecalhoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: vendaCabecalhoController.vendaCabecalhoModel.tipoFrete ?? 'CIF',
															labelText: 'Tipo Frete',
															hintText: 'Informe os dados para o campo Tipo Frete',
															items: const ['CIF','FOB'],
															onChanged: (dynamic newValue) {
																vendaCabecalhoController.vendaCabecalhoModel.tipoFrete = newValue;
																vendaCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: vendaCabecalhoController.vendaCabecalhoModel.formaPagamento ?? 'A Vista',
															labelText: 'Forma Pagamento',
															hintText: 'Informe os dados para o campo Forma Pagamento',
															items: const ['A Vista','A Prazo','Outros'],
															onChanged: (dynamic newValue) {
																vendaCabecalhoController.vendaCabecalhoModel.formaPagamento = newValue;
																vendaCabecalhoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Venda',
																labelText: 'Data Venda',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: vendaCabecalhoController.vendaCabecalhoModel.dataVenda,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	vendaCabecalhoController.vendaCabecalhoModel.dataVenda = value;
																	vendaCabecalhoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Saida',
																labelText: 'Data Saida',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: vendaCabecalhoController.vendaCabecalhoModel.dataSaida,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	vendaCabecalhoController.vendaCabecalhoModel.dataSaida = value;
																	vendaCabecalhoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: vendaCabecalhoController.horaSaidaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Saida',
																labelText: 'Hora Saida',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.horaSaida = text;
																vendaCabecalhoController.formWasChanged = true;
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
															controller: vendaCabecalhoController.numeroFaturaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Fatura',
																labelText: 'Numero Fatura',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.numeroFatura = int.tryParse(text);
																vendaCabecalhoController.formWasChanged = true;
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
															controller: vendaCabecalhoController.valorFreteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Frete',
																labelText: 'Valor Frete',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.valorFrete = vendaCabecalhoController.valorFreteController.numberValue;
																vendaCabecalhoController.formWasChanged = true;
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
															controller: vendaCabecalhoController.valorSeguroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Seguro',
																labelText: 'Valor Seguro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.valorSeguro = vendaCabecalhoController.valorSeguroController.numberValue;
																vendaCabecalhoController.formWasChanged = true;
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
															controller: vendaCabecalhoController.valorSubtotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Subtotal',
																labelText: 'Valor Subtotal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.valorSubtotal = vendaCabecalhoController.valorSubtotalController.numberValue;
																vendaCabecalhoController.formWasChanged = true;
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
															controller: vendaCabecalhoController.taxaComissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Comissao',
																labelText: 'Taxa Comissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.taxaComissao = vendaCabecalhoController.taxaComissaoController.numberValue;
																vendaCabecalhoController.formWasChanged = true;
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
															controller: vendaCabecalhoController.valorComissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Comissao',
																labelText: 'Valor Comissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.valorComissao = vendaCabecalhoController.valorComissaoController.numberValue;
																vendaCabecalhoController.formWasChanged = true;
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
															controller: vendaCabecalhoController.taxaDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Desconto',
																labelText: 'Taxa Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.taxaDesconto = vendaCabecalhoController.taxaDescontoController.numberValue;
																vendaCabecalhoController.formWasChanged = true;
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
															controller: vendaCabecalhoController.valorDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto',
																labelText: 'Valor Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.valorDesconto = vendaCabecalhoController.valorDescontoController.numberValue;
																vendaCabecalhoController.formWasChanged = true;
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
															controller: vendaCabecalhoController.valorTotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total',
																labelText: 'Valor Total',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.valorTotal = vendaCabecalhoController.valorTotalController.numberValue;
																vendaCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: vendaCabecalhoController.vendaCabecalhoModel.situacao ?? 'Digitação',
															labelText: 'Situacao',
															hintText: 'Informe os dados para o campo Situacao',
															items: const ['Digitação','Produção','Expedição','Faturado','Entregue','Devolução'],
															onChanged: (dynamic newValue) {
																vendaCabecalhoController.vendaCabecalhoModel.situacao = newValue;
																vendaCabecalhoController.formWasChanged = true;
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
															maxLength: 2,
															controller: vendaCabecalhoController.diaFixoParcelaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dia Fixo Parcela',
																labelText: 'Dia Fixo Parcela',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.diaFixoParcela = text;
																vendaCabecalhoController.formWasChanged = true;
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
															controller: vendaCabecalhoController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCabecalhoController.vendaCabecalhoModel.observacao = text;
																vendaCabecalhoController.formWasChanged = true;
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
