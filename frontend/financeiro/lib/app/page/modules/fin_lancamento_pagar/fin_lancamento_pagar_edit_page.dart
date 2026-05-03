import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro/app/controller/fin_lancamento_pagar_controller.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/page/shared_widget/input/input_imports.dart';

class FinLancamentoPagarEditPage extends StatelessWidget {
	FinLancamentoPagarEditPage({Key? key}) : super(key: key);
	final finLancamentoPagarController = Get.find<FinLancamentoPagarController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: finLancamentoPagarController.finLancamentoPagarEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: finLancamentoPagarController.finLancamentoPagarEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: finLancamentoPagarController.scrollController,
							child: SingleChildScrollView(
								controller: finLancamentoPagarController.scrollController,
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
																		controller: finLancamentoPagarController.viewPessoaFornecedorModelController,
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
																child: lookupButton(onPressed: finLancamentoPagarController.callViewPessoaFornecedorLookup),
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
																		controller: finLancamentoPagarController.bancoContaCaixaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Conta/Caixa',
																			labelText: 'Conta/Caixa *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: finLancamentoPagarController.callBancoContaCaixaLookup),
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: finLancamentoPagarController.finDocumentoOrigemModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Documento Origem',
																			labelText: 'Documento Origem *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: finLancamentoPagarController.callFinDocumentoOrigemLookup),
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
																		controller: finLancamentoPagarController.finNaturezaFinanceiraModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Natureza Financeira',
																			labelText: 'Natureza Financeira *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: finLancamentoPagarController.callFinNaturezaFinanceiraLookup),
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
															controller: finLancamentoPagarController.quantidadeParcelaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Parcela',
																labelText: 'Quantidade Parcela',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finLancamentoPagarController.finLancamentoPagarModel.quantidadeParcela = int.tryParse(text);
																finLancamentoPagarController.formWasChanged = true;
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
															controller: finLancamentoPagarController.valorAPagarController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor A Pagar',
																labelText: 'Valor A Pagar',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finLancamentoPagarController.finLancamentoPagarModel.valorAPagar = finLancamentoPagarController.valorAPagarController.numberValue;
																finLancamentoPagarController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Lancamento',
																labelText: 'Data Lancamento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: finLancamentoPagarController.finLancamentoPagarModel.dataLancamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finLancamentoPagarController.finLancamentoPagarModel.dataLancamento = value;
																	finLancamentoPagarController.formWasChanged = true;
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
															maxLength: 50,
															controller: finLancamentoPagarController.numeroDocumentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Documento',
																labelText: 'Numero Documento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finLancamentoPagarController.finLancamentoPagarModel.numeroDocumento = text;
																finLancamentoPagarController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Primeiro Vencimento',
																labelText: 'Primeiro Vencimento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: finLancamentoPagarController.finLancamentoPagarModel.primeiroVencimento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finLancamentoPagarController.finLancamentoPagarModel.primeiroVencimento = value;
																	finLancamentoPagarController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: finLancamentoPagarController.intervaloEntreParcelasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Intervalo Entre Parcelas',
																labelText: 'Intervalo Entre Parcelas',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finLancamentoPagarController.finLancamentoPagarModel.intervaloEntreParcelas = int.tryParse(text);
																finLancamentoPagarController.formWasChanged = true;
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
															controller: finLancamentoPagarController.diaFixoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dia Fixo',
																labelText: 'Dia Fixo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finLancamentoPagarController.finLancamentoPagarModel.diaFixo = text;
																finLancamentoPagarController.formWasChanged = true;
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
