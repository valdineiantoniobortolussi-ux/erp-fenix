import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_informacao_pagamento_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeInformacaoPagamentoEditPage extends StatelessWidget {
	NfeInformacaoPagamentoEditPage({Key? key}) : super(key: key);
	final nfeInformacaoPagamentoController = Get.find<NfeInformacaoPagamentoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeInformacaoPagamentoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Informação Pagamento - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeInformacaoPagamentoController.save),
						cancelAndExitButton(onPressed: nfeInformacaoPagamentoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeInformacaoPagamentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeInformacaoPagamentoController.scrollController,
							child: SingleChildScrollView(
								controller: nfeInformacaoPagamentoController.scrollController,
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
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfeInformacaoPagamentoController.nfeInformacaoPagamentoModel.indicadorPagamento ?? 'AAA',
															labelText: 'Indicador Pagamento',
															hintText: 'Informe os dados para o campo Indicador Pagamento',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeInformacaoPagamentoController.nfeInformacaoPagamentoModel.indicadorPagamento = newValue;
																nfeInformacaoPagamentoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: nfeInformacaoPagamentoController.nfeInformacaoPagamentoModel.meioPagamento ?? 'AAA',
															labelText: 'Meio Pagamento',
															hintText: 'Informe os dados para o campo Meio Pagamento',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeInformacaoPagamentoController.nfeInformacaoPagamentoModel.meioPagamento = newValue;
																nfeInformacaoPagamentoController.formWasChanged = true;
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
															controller: nfeInformacaoPagamentoController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeInformacaoPagamentoController.nfeInformacaoPagamentoModel.valor = nfeInformacaoPagamentoController.valorController.numberValue;
																nfeInformacaoPagamentoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: nfeInformacaoPagamentoController.nfeInformacaoPagamentoModel.tipoIntegracao ?? 'AAA',
															labelText: 'Tipo Integracao',
															hintText: 'Informe os dados para o campo Tipo Integracao',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeInformacaoPagamentoController.nfeInformacaoPagamentoModel.tipoIntegracao = newValue;
																nfeInformacaoPagamentoController.formWasChanged = true;
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
															controller: nfeInformacaoPagamentoController.cnpjOperadoraCartaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj Operadora Cartao',
																labelText: 'Cnpj Operadora Cartao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeInformacaoPagamentoController.nfeInformacaoPagamentoModel.cnpjOperadoraCartao = text;
																nfeInformacaoPagamentoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: nfeInformacaoPagamentoController.nfeInformacaoPagamentoModel.bandeira ?? 'AAA',
															labelText: 'Bandeira',
															hintText: 'Informe os dados para o campo Bandeira',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeInformacaoPagamentoController.nfeInformacaoPagamentoModel.bandeira = newValue;
																nfeInformacaoPagamentoController.formWasChanged = true;
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
															maxLength: 20,
															controller: nfeInformacaoPagamentoController.numeroAutorizacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Autorizacao',
																labelText: 'Numero Autorizacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeInformacaoPagamentoController.nfeInformacaoPagamentoModel.numeroAutorizacao = text;
																nfeInformacaoPagamentoController.formWasChanged = true;
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
															controller: nfeInformacaoPagamentoController.trocoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Troco',
																labelText: 'Troco',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeInformacaoPagamentoController.nfeInformacaoPagamentoModel.troco = nfeInformacaoPagamentoController.trocoController.numberValue;
																nfeInformacaoPagamentoController.formWasChanged = true;
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
