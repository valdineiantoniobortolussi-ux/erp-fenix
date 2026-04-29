import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro/app/controller/fin_parcela_receber_controller.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/page/shared_widget/input/input_imports.dart';

class FinParcelaReceberEditPage extends StatelessWidget {
	FinParcelaReceberEditPage({Key? key}) : super(key: key);
	final finParcelaReceberController = Get.find<FinParcelaReceberController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: finParcelaReceberController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Parcelas - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: finParcelaReceberController.save),
						cancelAndExitButton(onPressed: finParcelaReceberController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: finParcelaReceberController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: finParcelaReceberController.scrollController,
							child: SingleChildScrollView(
								controller: finParcelaReceberController.scrollController,
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
																		controller: finParcelaReceberController.finStatusParcelaModelController,
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
																child: lookupButton(onPressed: finParcelaReceberController.callFinStatusParcelaLookup),
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
																		controller: finParcelaReceberController.finTipoRecebimentoModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Tipo Recebimento',
																			labelText: 'Tipo Recebimento',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: finParcelaReceberController.callFinTipoRecebimentoLookup),
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
															controller: finParcelaReceberController.numeroParcelaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Parcela',
																labelText: 'Numero Parcela',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaReceberController.finParcelaReceberModel.numeroParcela = int.tryParse(text);
																finParcelaReceberController.formWasChanged = true;
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
																dateTime: finParcelaReceberController.finParcelaReceberModel.dataEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finParcelaReceberController.finParcelaReceberModel.dataEmissao = value;
																	finParcelaReceberController.formWasChanged = true;
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
																dateTime: finParcelaReceberController.finParcelaReceberModel.dataVencimento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finParcelaReceberController.finParcelaReceberModel.dataVencimento = value;
																	finParcelaReceberController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Recebimento',
																labelText: 'Data Recebimento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: finParcelaReceberController.finParcelaReceberModel.dataRecebimento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finParcelaReceberController.finParcelaReceberModel.dataRecebimento = value;
																	finParcelaReceberController.formWasChanged = true;
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
																dateTime: finParcelaReceberController.finParcelaReceberModel.descontoAte,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finParcelaReceberController.finParcelaReceberModel.descontoAte = value;
																	finParcelaReceberController.formWasChanged = true;
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
															controller: finParcelaReceberController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaReceberController.finParcelaReceberModel.valor = finParcelaReceberController.valorController.numberValue;
																finParcelaReceberController.formWasChanged = true;
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
															controller: finParcelaReceberController.taxaJuroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Juro',
																labelText: 'Taxa Juro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaReceberController.finParcelaReceberModel.taxaJuro = finParcelaReceberController.taxaJuroController.numberValue;
																finParcelaReceberController.formWasChanged = true;
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
															controller: finParcelaReceberController.taxaMultaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Multa',
																labelText: 'Taxa Multa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaReceberController.finParcelaReceberModel.taxaMulta = finParcelaReceberController.taxaMultaController.numberValue;
																finParcelaReceberController.formWasChanged = true;
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
															controller: finParcelaReceberController.taxaDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Desconto',
																labelText: 'Taxa Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaReceberController.finParcelaReceberModel.taxaDesconto = finParcelaReceberController.taxaDescontoController.numberValue;
																finParcelaReceberController.formWasChanged = true;
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
															controller: finParcelaReceberController.valorJuroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Juro',
																labelText: 'Valor Juro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaReceberController.finParcelaReceberModel.valorJuro = finParcelaReceberController.valorJuroController.numberValue;
																finParcelaReceberController.formWasChanged = true;
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
															controller: finParcelaReceberController.valorMultaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Multa',
																labelText: 'Valor Multa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaReceberController.finParcelaReceberModel.valorMulta = finParcelaReceberController.valorMultaController.numberValue;
																finParcelaReceberController.formWasChanged = true;
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
															controller: finParcelaReceberController.valorDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto',
																labelText: 'Valor Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaReceberController.finParcelaReceberModel.valorDesconto = finParcelaReceberController.valorDescontoController.numberValue;
																finParcelaReceberController.formWasChanged = true;
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
															value: finParcelaReceberController.finParcelaReceberModel.emitiuBoleto ?? 'S',
															labelText: 'Emitiu Boleto',
															hintText: 'Informe os dados para o campo Emitiu Boleto',
															items: const ['S','N'],
															onChanged: (dynamic newValue) {
																finParcelaReceberController.finParcelaReceberModel.emitiuBoleto = newValue;
																finParcelaReceberController.formWasChanged = true;
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
															controller: finParcelaReceberController.boletoNossoNumeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Boleto Nosso Numero',
																labelText: 'Boleto Nosso Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaReceberController.finParcelaReceberModel.boletoNossoNumero = text;
																finParcelaReceberController.formWasChanged = true;
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
															controller: finParcelaReceberController.valorRecebidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Recebido',
																labelText: 'Valor Recebido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaReceberController.finParcelaReceberModel.valorRecebido = finParcelaReceberController.valorRecebidoController.numberValue;
																finParcelaReceberController.formWasChanged = true;
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
															controller: finParcelaReceberController.historicoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Historico',
																labelText: 'Historico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finParcelaReceberController.finParcelaReceberModel.historico = text;
																finParcelaReceberController.formWasChanged = true;
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
