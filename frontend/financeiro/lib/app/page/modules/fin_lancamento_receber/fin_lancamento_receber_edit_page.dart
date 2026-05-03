import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro/app/controller/fin_lancamento_receber_controller.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/page/shared_widget/input/input_imports.dart';

class FinLancamentoReceberEditPage extends StatelessWidget {
	FinLancamentoReceberEditPage({Key? key}) : super(key: key);
	final finLancamentoReceberController = Get.find<FinLancamentoReceberController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: finLancamentoReceberController.finLancamentoReceberEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: finLancamentoReceberController.finLancamentoReceberEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: finLancamentoReceberController.scrollController,
							child: SingleChildScrollView(
								controller: finLancamentoReceberController.scrollController,
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
																		controller: finLancamentoReceberController.viewPessoaClienteModelController,
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
																child: lookupButton(onPressed: finLancamentoReceberController.callViewPessoaClienteLookup),
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
																		controller: finLancamentoReceberController.bancoContaCaixaModelController,
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
																child: lookupButton(onPressed: finLancamentoReceberController.callBancoContaCaixaLookup),
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
																		controller: finLancamentoReceberController.finDocumentoOrigemModelController,
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
																child: lookupButton(onPressed: finLancamentoReceberController.callFinDocumentoOrigemLookup),
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
																		controller: finLancamentoReceberController.finNaturezaFinanceiraModelController,
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
																child: lookupButton(onPressed: finLancamentoReceberController.callFinNaturezaFinanceiraLookup),
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
															controller: finLancamentoReceberController.quantidadeParcelaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Parcela',
																labelText: 'Quantidade Parcela',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finLancamentoReceberController.finLancamentoReceberModel.quantidadeParcela = int.tryParse(text);
																finLancamentoReceberController.formWasChanged = true;
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
															controller: finLancamentoReceberController.valorAReceberController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor A Receber',
																labelText: 'Valor A Receber',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finLancamentoReceberController.finLancamentoReceberModel.valorAReceber = finLancamentoReceberController.valorAReceberController.numberValue;
																finLancamentoReceberController.formWasChanged = true;
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
																dateTime: finLancamentoReceberController.finLancamentoReceberModel.dataLancamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finLancamentoReceberController.finLancamentoReceberModel.dataLancamento = value;
																	finLancamentoReceberController.formWasChanged = true;
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
															maxLength: 50,
															controller: finLancamentoReceberController.numeroDocumentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Documento',
																labelText: 'Numero Documento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finLancamentoReceberController.finLancamentoReceberModel.numeroDocumento = text;
																finLancamentoReceberController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
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
																dateTime: finLancamentoReceberController.finLancamentoReceberModel.primeiroVencimento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finLancamentoReceberController.finLancamentoReceberModel.primeiroVencimento = value;
																	finLancamentoReceberController.formWasChanged = true;
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
															controller: finLancamentoReceberController.taxaComissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Comissao',
																labelText: 'Taxa Comissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finLancamentoReceberController.finLancamentoReceberModel.taxaComissao = finLancamentoReceberController.taxaComissaoController.numberValue;
																finLancamentoReceberController.formWasChanged = true;
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
															controller: finLancamentoReceberController.valorComissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Comissao',
																labelText: 'Valor Comissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finLancamentoReceberController.finLancamentoReceberModel.valorComissao = finLancamentoReceberController.valorComissaoController.numberValue;
																finLancamentoReceberController.formWasChanged = true;
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
															controller: finLancamentoReceberController.intervaloEntreParcelasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Intervalo Entre Parcelas',
																labelText: 'Intervalo Entre Parcelas',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finLancamentoReceberController.finLancamentoReceberModel.intervaloEntreParcelas = int.tryParse(text);
																finLancamentoReceberController.formWasChanged = true;
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
															controller: finLancamentoReceberController.diaFixoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dia Fixo',
																labelText: 'Dia Fixo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finLancamentoReceberController.finLancamentoReceberModel.diaFixo = text;
																finLancamentoReceberController.formWasChanged = true;
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
