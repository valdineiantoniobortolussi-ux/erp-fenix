import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro/app/controller/fin_parcela_pagar_controller.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/page/shared_widget/input/input_imports.dart';

class FinParcelaPagarEditPage extends StatelessWidget {
	FinParcelaPagarEditPage({Key? key}) : super(key: key);
	final finParcelaPagarController = Get.find<FinParcelaPagarController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: finParcelaPagarController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Parcelas - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: finParcelaPagarController.save),
						cancelAndExitButton(onPressed: finParcelaPagarController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: finParcelaPagarController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: finParcelaPagarController.scrollController,
							child: SingleChildScrollView(
								controller: finParcelaPagarController.scrollController,
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
																		controller: finParcelaPagarController.finStatusParcelaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Status Parcela',
																			labelText: 'Status Parcela *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: finParcelaPagarController.callFinStatusParcelaLookup),
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
																		controller: finParcelaPagarController.finTipoPagamentoModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Tipo Pagamento',
																			labelText: 'Tipo Pagamento',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: finParcelaPagarController.callFinTipoPagamentoLookup),
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
															controller: finParcelaPagarController.numeroParcelaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Parcela',
																labelText: 'Numero Parcela',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaPagarController.finParcelaPagarModel.numeroParcela = int.tryParse(text);
																finParcelaPagarController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Emissao',
																labelText: 'Data Emissao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: finParcelaPagarController.finParcelaPagarModel.dataEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finParcelaPagarController.finParcelaPagarModel.dataEmissao = value;
																	finParcelaPagarController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Vencimento',
																labelText: 'Data Vencimento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: finParcelaPagarController.finParcelaPagarModel.dataVencimento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finParcelaPagarController.finParcelaPagarModel.dataVencimento = value;
																	finParcelaPagarController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Pagamento',
																labelText: 'Data Pagamento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: finParcelaPagarController.finParcelaPagarModel.dataPagamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finParcelaPagarController.finParcelaPagarModel.dataPagamento = value;
																	finParcelaPagarController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Desconto Ate',
																labelText: 'Desconto Ate',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: finParcelaPagarController.finParcelaPagarModel.descontoAte,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finParcelaPagarController.finParcelaPagarModel.descontoAte = value;
																	finParcelaPagarController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: finParcelaPagarController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaPagarController.finParcelaPagarModel.valor = finParcelaPagarController.valorController.numberValue;
																finParcelaPagarController.formWasChanged = true;
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
															controller: finParcelaPagarController.taxaJuroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Juro',
																labelText: 'Taxa Juro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaPagarController.finParcelaPagarModel.taxaJuro = finParcelaPagarController.taxaJuroController.numberValue;
																finParcelaPagarController.formWasChanged = true;
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
															controller: finParcelaPagarController.taxaMultaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Multa',
																labelText: 'Taxa Multa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaPagarController.finParcelaPagarModel.taxaMulta = finParcelaPagarController.taxaMultaController.numberValue;
																finParcelaPagarController.formWasChanged = true;
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
															controller: finParcelaPagarController.taxaDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Desconto',
																labelText: 'Taxa Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaPagarController.finParcelaPagarModel.taxaDesconto = finParcelaPagarController.taxaDescontoController.numberValue;
																finParcelaPagarController.formWasChanged = true;
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
															controller: finParcelaPagarController.valorJuroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Juro',
																labelText: 'Valor Juro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaPagarController.finParcelaPagarModel.valorJuro = finParcelaPagarController.valorJuroController.numberValue;
																finParcelaPagarController.formWasChanged = true;
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
															controller: finParcelaPagarController.valorMultaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Multa',
																labelText: 'Valor Multa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaPagarController.finParcelaPagarModel.valorMulta = finParcelaPagarController.valorMultaController.numberValue;
																finParcelaPagarController.formWasChanged = true;
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
															controller: finParcelaPagarController.valorDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto',
																labelText: 'Valor Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaPagarController.finParcelaPagarModel.valorDesconto = finParcelaPagarController.valorDescontoController.numberValue;
																finParcelaPagarController.formWasChanged = true;
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
															controller: finParcelaPagarController.valorPagoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Pago',
																labelText: 'Valor Pago',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaPagarController.finParcelaPagarModel.valorPago = finParcelaPagarController.valorPagoController.numberValue;
																finParcelaPagarController.formWasChanged = true;
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
															controller: finParcelaPagarController.historicoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Historico',
																labelText: 'Historico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaPagarController.finParcelaPagarModel.historico = text;
																finParcelaPagarController.formWasChanged = true;
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
