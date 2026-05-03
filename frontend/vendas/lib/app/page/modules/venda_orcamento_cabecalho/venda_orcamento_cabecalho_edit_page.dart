import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:vendas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:vendas/app/controller/venda_orcamento_cabecalho_controller.dart';
import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/page/shared_widget/input/input_imports.dart';

class VendaOrcamentoCabecalhoEditPage extends StatelessWidget {
	VendaOrcamentoCabecalhoEditPage({Key? key}) : super(key: key);
	final vendaOrcamentoCabecalhoController = Get.find<VendaOrcamentoCabecalhoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: vendaOrcamentoCabecalhoController.scrollController,
							child: SingleChildScrollView(
								controller: vendaOrcamentoCabecalhoController.scrollController,
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
																		controller: vendaOrcamentoCabecalhoController.viewPessoaVendedorModelController,
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
																child: lookupButton(onPressed: vendaOrcamentoCabecalhoController.callViewPessoaVendedorLookup),
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
																		controller: vendaOrcamentoCabecalhoController.viewPessoaClienteModelController,
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
																child: lookupButton(onPressed: vendaOrcamentoCabecalhoController.callViewPessoaClienteLookup),
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
													sizes: 'col-12 col-md-5',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: vendaOrcamentoCabecalhoController.vendaCondicoesPagamentoModelController,
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
																child: lookupButton(onPressed: vendaOrcamentoCabecalhoController.callVendaCondicoesPagamentoLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-5',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: vendaOrcamentoCabecalhoController.viewPessoaTransportadoraModelController,
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
																child: lookupButton(onPressed: vendaOrcamentoCabecalhoController.callViewPessoaTransportadoraLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.tipoFrete ?? 'CIF',
															labelText: 'Tipo Frete',
															hintText: 'Informe os dados para o campo Tipo Frete',
															items: const ['CIF','FOB'],
															onChanged: (dynamic newValue) {
																vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.tipoFrete = newValue;
																vendaOrcamentoCabecalhoController.formWasChanged = true;
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
															maxLength: 20,
															controller: vendaOrcamentoCabecalhoController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.codigo = text;
																vendaOrcamentoCabecalhoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Cadastro',
																labelText: 'Data Cadastro',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.dataCadastro,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.dataCadastro = value;
																	vendaOrcamentoCabecalhoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Entrega',
																labelText: 'Data Entrega',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.dataEntrega,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.dataEntrega = value;
																	vendaOrcamentoCabecalhoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Fill with the Data Validade',
																labelText: 'Data Validade',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.dataValidade,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.dataValidade = value;
																	vendaOrcamentoCabecalhoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: vendaOrcamentoCabecalhoController.valorSubtotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Subtotal',
																labelText: 'Valor Subtotal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.valorSubtotal = vendaOrcamentoCabecalhoController.valorSubtotalController.numberValue;
																vendaOrcamentoCabecalhoController.formWasChanged = true;
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
															controller: vendaOrcamentoCabecalhoController.valorFreteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Frete',
																labelText: 'Valor Frete',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.valorFrete = vendaOrcamentoCabecalhoController.valorFreteController.numberValue;
																vendaOrcamentoCabecalhoController.formWasChanged = true;
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
															controller: vendaOrcamentoCabecalhoController.taxaComissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Comissao',
																labelText: 'Taxa Comissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.taxaComissao = vendaOrcamentoCabecalhoController.taxaComissaoController.numberValue;
																vendaOrcamentoCabecalhoController.formWasChanged = true;
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
															controller: vendaOrcamentoCabecalhoController.valorComissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Comissao',
																labelText: 'Valor Comissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.valorComissao = vendaOrcamentoCabecalhoController.valorComissaoController.numberValue;
																vendaOrcamentoCabecalhoController.formWasChanged = true;
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
															controller: vendaOrcamentoCabecalhoController.taxaDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Desconto',
																labelText: 'Taxa Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.taxaDesconto = vendaOrcamentoCabecalhoController.taxaDescontoController.numberValue;
																vendaOrcamentoCabecalhoController.formWasChanged = true;
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
															controller: vendaOrcamentoCabecalhoController.valorDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto',
																labelText: 'Valor Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.valorDesconto = vendaOrcamentoCabecalhoController.valorDescontoController.numberValue;
																vendaOrcamentoCabecalhoController.formWasChanged = true;
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
															controller: vendaOrcamentoCabecalhoController.valorTotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total',
																labelText: 'Valor Total',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.valorTotal = vendaOrcamentoCabecalhoController.valorTotalController.numberValue;
																vendaOrcamentoCabecalhoController.formWasChanged = true;
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
															controller: vendaOrcamentoCabecalhoController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoModel.observacao = text;
																vendaOrcamentoCabecalhoController.formWasChanged = true;
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
