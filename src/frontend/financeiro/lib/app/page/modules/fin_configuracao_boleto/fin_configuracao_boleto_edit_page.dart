import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro/app/controller/fin_configuracao_boleto_controller.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/page/shared_widget/input/input_imports.dart';

class FinConfiguracaoBoletoEditPage extends StatelessWidget {
	FinConfiguracaoBoletoEditPage({Key? key}) : super(key: key);
	final finConfiguracaoBoletoController = Get.find<FinConfiguracaoBoletoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					finConfiguracaoBoletoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: finConfiguracaoBoletoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Configuracões Boleto - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: finConfiguracaoBoletoController.save),
						cancelAndExitButton(onPressed: finConfiguracaoBoletoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: finConfiguracaoBoletoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: finConfiguracaoBoletoController.scrollController,
							child: SingleChildScrollView(
								controller: finConfiguracaoBoletoController.scrollController,
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
																		controller: finConfiguracaoBoletoController.bancoContaCaixaModelController,
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
																child: lookupButton(onPressed: finConfiguracaoBoletoController.callBancoContaCaixaLookup),
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
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: finConfiguracaoBoletoController.instrucao01Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Instrucao 01',
																labelText: 'Instrução 01',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.instrucao01 = text;
																finConfiguracaoBoletoController.formWasChanged = true;
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
															controller: finConfiguracaoBoletoController.instrucao02Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Instrucao 02',
																labelText: 'Instrução 02',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.instrucao02 = text;
																finConfiguracaoBoletoController.formWasChanged = true;
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
															maxLength: 250,
															controller: finConfiguracaoBoletoController.caminhoArquivoRemessaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Caminho Arquivo Remessa',
																labelText: 'Caminho Arquivo Remessa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.caminhoArquivoRemessa = text;
																finConfiguracaoBoletoController.formWasChanged = true;
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
															maxLength: 250,
															controller: finConfiguracaoBoletoController.caminhoArquivoRetornoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Caminho Arquivo Retorno',
																labelText: 'Caminho Arquivo Retorno',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.caminhoArquivoRetorno = text;
																finConfiguracaoBoletoController.formWasChanged = true;
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
															maxLength: 250,
															controller: finConfiguracaoBoletoController.caminhoArquivoLogotipoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Caminho Arquivo Logotipo',
																labelText: 'Caminho Arquivo Logotipo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.caminhoArquivoLogotipo = text;
																finConfiguracaoBoletoController.formWasChanged = true;
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
															maxLength: 250,
															controller: finConfiguracaoBoletoController.caminhoArquivoPdfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Caminho Arquivo Pdf',
																labelText: 'Caminho Arquivo PDF',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.caminhoArquivoPdf = text;
																finConfiguracaoBoletoController.formWasChanged = true;
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
															maxLength: 250,
															controller: finConfiguracaoBoletoController.mensagemController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Mensagem',
																labelText: 'Mensagem',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.mensagem = text;
																finConfiguracaoBoletoController.formWasChanged = true;
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
															controller: finConfiguracaoBoletoController.localPagamentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Local Pagamento',
																labelText: 'Local Pagamento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.localPagamento = text;
																finConfiguracaoBoletoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: finConfiguracaoBoletoController.finConfiguracaoBoletoModel.layoutRemessa ?? 'CNAB 240',
															labelText: 'Layout Remessa',
															hintText: 'Informe os dados para o campo Layout Remessa',
															items: const ['CNAB 240','CNAB 400'],
															onChanged: (dynamic newValue) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.layoutRemessa = newValue;
																finConfiguracaoBoletoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: finConfiguracaoBoletoController.finConfiguracaoBoletoModel.aceite ?? 'S',
															labelText: 'Aceite',
															hintText: 'Informe os dados para o campo Aceite',
															items: const ['S','N'],
															onChanged: (dynamic newValue) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.aceite = newValue;
																finConfiguracaoBoletoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: finConfiguracaoBoletoController.finConfiguracaoBoletoModel.especie ?? 'DM-Duplicata Mercantil',
															labelText: 'Especie',
															hintText: 'Informe os dados para o campo Especie',
															items: const ['DM-Duplicata Mercantil','DS-Duplicata de Serviços','RC-Recibo','NP-Nota Promissória'],
															onChanged: (dynamic newValue) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.especie = newValue;
																finConfiguracaoBoletoController.formWasChanged = true;
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
															maxLength: 3,
															controller: finConfiguracaoBoletoController.carteiraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Carteira',
																labelText: 'Carteira',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.carteira = text;
																finConfiguracaoBoletoController.formWasChanged = true;
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
															maxLength: 20,
															controller: finConfiguracaoBoletoController.codigoConvenioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Convenio',
																labelText: 'Codigo Convenio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.codigoConvenio = text;
																finConfiguracaoBoletoController.formWasChanged = true;
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
															controller: finConfiguracaoBoletoController.codigoCedenteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Cedente',
																labelText: 'Codigo Cedente',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.codigoCedente = text;
																finConfiguracaoBoletoController.formWasChanged = true;
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
															controller: finConfiguracaoBoletoController.taxaMultaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Multa',
																labelText: 'Taxa Multa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.taxaMulta = finConfiguracaoBoletoController.taxaMultaController.numberValue;
																finConfiguracaoBoletoController.formWasChanged = true;
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
															controller: finConfiguracaoBoletoController.taxaJuroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa Juro',
																labelText: 'Taxa Juro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.taxaJuro = finConfiguracaoBoletoController.taxaJuroController.numberValue;
																finConfiguracaoBoletoController.formWasChanged = true;
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
															controller: finConfiguracaoBoletoController.diasProtestoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dias Protesto',
																labelText: 'Dias Protesto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.diasProtesto = int.tryParse(text);
																finConfiguracaoBoletoController.formWasChanged = true;
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
															controller: finConfiguracaoBoletoController.nossoNumeroAnteriorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nosso Numero Anterior',
																labelText: 'Nosso Numero Anterior',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finConfiguracaoBoletoController.finConfiguracaoBoletoModel.nossoNumeroAnterior = text;
																finConfiguracaoBoletoController.formWasChanged = true;
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
