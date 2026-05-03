import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro/app/controller/fin_cheque_recebido_controller.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/page/shared_widget/input/input_imports.dart';

class FinChequeRecebidoEditPage extends StatelessWidget {
	FinChequeRecebidoEditPage({Key? key}) : super(key: key);
	final finChequeRecebidoController = Get.find<FinChequeRecebidoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					finChequeRecebidoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: finChequeRecebidoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Cheque Recebido - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: finChequeRecebidoController.save),
						cancelAndExitButton(onPressed: finChequeRecebidoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: finChequeRecebidoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: finChequeRecebidoController.scrollController,
							child: SingleChildScrollView(
								controller: finChequeRecebidoController.scrollController,
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
																		controller: finChequeRecebidoController.viewPessoaClienteModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados do Cliente',
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
																child: lookupButton(onPressed: finChequeRecebidoController.callViewPessoaClienteLookup),
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
															controller: finChequeRecebidoController.cpfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cpf',
																labelText: 'Cpf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finChequeRecebidoController.finChequeRecebidoModel.cpf = text;
																finChequeRecebidoController.formWasChanged = true;
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
															controller: finChequeRecebidoController.cnpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj',
																labelText: 'Cnpj',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finChequeRecebidoController.finChequeRecebidoModel.cnpj = text;
																finChequeRecebidoController.formWasChanged = true;
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
															maxLength: 100,
															controller: finChequeRecebidoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finChequeRecebidoController.finChequeRecebidoModel.nome = text;
																finChequeRecebidoController.formWasChanged = true;
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
															maxLength: 10,
															controller: finChequeRecebidoController.codigoBancoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Banco',
																labelText: 'Codigo Banco',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finChequeRecebidoController.finChequeRecebidoModel.codigoBanco = text;
																finChequeRecebidoController.formWasChanged = true;
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
															maxLength: 10,
															controller: finChequeRecebidoController.codigoAgenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Agencia',
																labelText: 'Codigo Agencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finChequeRecebidoController.finChequeRecebidoModel.codigoAgencia = text;
																finChequeRecebidoController.formWasChanged = true;
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
															maxLength: 20,
															controller: finChequeRecebidoController.contaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta',
																labelText: 'Conta',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finChequeRecebidoController.finChequeRecebidoModel.conta = text;
																finChequeRecebidoController.formWasChanged = true;
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
															controller: finChequeRecebidoController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finChequeRecebidoController.finChequeRecebidoModel.numero = int.tryParse(text);
																finChequeRecebidoController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Emissao',
																labelText: 'Data Emissao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: finChequeRecebidoController.finChequeRecebidoModel.dataEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finChequeRecebidoController.finChequeRecebidoModel.dataEmissao = value;
																	finChequeRecebidoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Bom Para',
																labelText: 'Bom Para',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: finChequeRecebidoController.finChequeRecebidoModel.bomPara,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finChequeRecebidoController.finChequeRecebidoModel.bomPara = value;
																	finChequeRecebidoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Compensacao',
																labelText: 'Data Compensacao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: finChequeRecebidoController.finChequeRecebidoModel.dataCompensacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finChequeRecebidoController.finChequeRecebidoModel.dataCompensacao = value;
																	finChequeRecebidoController.formWasChanged = true;
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
															controller: finChequeRecebidoController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finChequeRecebidoController.finChequeRecebidoModel.valor = finChequeRecebidoController.valorController.numberValue;
																finChequeRecebidoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Custodia Data',
																labelText: 'Custodia Data',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: finChequeRecebidoController.finChequeRecebidoModel.custodiaData,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finChequeRecebidoController.finChequeRecebidoModel.custodiaData = value;
																	finChequeRecebidoController.formWasChanged = true;
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
															controller: finChequeRecebidoController.custodiaTarifaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Custodia Tarifa',
																labelText: 'Custodia Tarifa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finChequeRecebidoController.finChequeRecebidoModel.custodiaTarifa = finChequeRecebidoController.custodiaTarifaController.numberValue;
																finChequeRecebidoController.formWasChanged = true;
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
															controller: finChequeRecebidoController.custodiaComissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Custodia Comissao',
																labelText: 'Custodia Comissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finChequeRecebidoController.finChequeRecebidoModel.custodiaComissao = finChequeRecebidoController.custodiaComissaoController.numberValue;
																finChequeRecebidoController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Desconto Data',
																labelText: 'Desconto Data',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: finChequeRecebidoController.finChequeRecebidoModel.descontoData,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	finChequeRecebidoController.finChequeRecebidoModel.descontoData = value;
																	finChequeRecebidoController.formWasChanged = true;
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
															controller: finChequeRecebidoController.descontoTarifaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Desconto Tarifa',
																labelText: 'Desconto Tarifa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finChequeRecebidoController.finChequeRecebidoModel.descontoTarifa = finChequeRecebidoController.descontoTarifaController.numberValue;
																finChequeRecebidoController.formWasChanged = true;
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
															controller: finChequeRecebidoController.descontoComissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Desconto Comissao',
																labelText: 'Desconto Comissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finChequeRecebidoController.finChequeRecebidoModel.descontoComissao = finChequeRecebidoController.descontoComissaoController.numberValue;
																finChequeRecebidoController.formWasChanged = true;
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
															controller: finChequeRecebidoController.valorRecebidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Recebido',
																labelText: 'Valor Recebido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finChequeRecebidoController.finChequeRecebidoModel.valorRecebido = finChequeRecebidoController.valorRecebidoController.numberValue;
																finChequeRecebidoController.formWasChanged = true;
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
			),
		);
	}
}
