import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_cabecalho_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeCabecalhoEditPage extends StatelessWidget {
	NfeCabecalhoEditPage({Key? key}) : super(key: key);
	final nfeCabecalhoController = Get.find<NfeCabecalhoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeCabecalhoController.nfeCabecalhoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeCabecalhoController.nfeCabecalhoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeCabecalhoController.scrollController,
							child: SingleChildScrollView(
								controller: nfeCabecalhoController.scrollController,
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
																		controller: nfeCabecalhoController.vendaCabecalhoModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Venda',
																			labelText: 'Venda',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: nfeCabecalhoController.callVendaCabecalhoLookup),
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
																		controller: nfeCabecalhoController.tributOperacaoFiscalModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Operação Fiscal',
																			labelText: 'Operação Fiscal',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: nfeCabecalhoController.callTributOperacaoFiscalLookup),
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
																		controller: nfeCabecalhoController.viewPessoaClienteModelController,
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
																child: lookupButton(onPressed: nfeCabecalhoController.callViewPessoaClienteLookup),
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
																		controller: nfeCabecalhoController.viewPessoaColaboradorModelController,
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
																child: lookupButton(onPressed: nfeCabecalhoController.callViewPessoaColaboradorLookup),
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
																		controller: nfeCabecalhoController.viewPessoaFornecedorModelController,
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
																child: lookupButton(onPressed: nfeCabecalhoController.callViewPessoaFornecedorLookup),
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfeCabecalhoController.nfeCabecalhoModel.ufEmitente ?? 'AC',
															labelText: 'UF Emitente',
															hintText: 'Informe os dados para o campo Uf Emitente',
															items: const ['AC','AL','AM','AP','BA','CE','DF','ES','GO','MA','MG','MS','MT','PA','PB','PE','PI','PR','RJ','RN','RO','RR','RS','SC','SE','SP','TO'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.ufEmitente = newValue;
																nfeCabecalhoController.formWasChanged = true;
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
															maxLength: 8,
															controller: nfeCabecalhoController.codigoNumericoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Numerico',
																labelText: 'Codigo Numerico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.codigoNumerico = text;
																nfeCabecalhoController.formWasChanged = true;
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
															maxLength: 60,
															controller: nfeCabecalhoController.naturezaOperacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Natureza Operacao',
																labelText: 'Natureza Operacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.naturezaOperacao = text;
																nfeCabecalhoController.formWasChanged = true;
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
															value: nfeCabecalhoController.nfeCabecalhoModel.codigoModelo ?? '55',
															labelText: 'Codigo Modelo',
															hintText: 'Informe os dados para o campo Codigo Modelo',
															items: const ['55'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.codigoModelo = newValue;
																nfeCabecalhoController.formWasChanged = true;
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
															maxLength: 3,
															controller: nfeCabecalhoController.serieController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Serie',
																labelText: 'Serie',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.serie = text;
																nfeCabecalhoController.formWasChanged = true;
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
															maxLength: 9,
															controller: nfeCabecalhoController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.numero = text;
																nfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Hora Emissao',
																labelText: 'Data Hora Emissao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: nfeCabecalhoController.nfeCabecalhoModel.dataHoraEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	nfeCabecalhoController.nfeCabecalhoModel.dataHoraEmissao = value;
																	nfeCabecalhoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Hora Entrada Saida',
																labelText: 'Data Hora Entrada Saida',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: nfeCabecalhoController.nfeCabecalhoModel.dataHoraEntradaSaida,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	nfeCabecalhoController.nfeCabecalhoModel.dataHoraEntradaSaida = value;
																	nfeCabecalhoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfeCabecalhoController.nfeCabecalhoModel.tipoOperacao ?? '0=Entrada',
															labelText: 'Tipo Operacao',
															hintText: 'Informe os dados para o campo Tipo Operacao',
															items: const ['0=Entrada','1=Saída'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.tipoOperacao = newValue;
																nfeCabecalhoController.formWasChanged = true;
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
															value: nfeCabecalhoController.nfeCabecalhoModel.localDestino ?? '1=Operação interna',
															labelText: 'Local Destino',
															hintText: 'Informe os dados para o campo Local Destino',
															items: const ['1=Operação interna','2=Operação interestadual','3=Operação com exterior'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.localDestino = newValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.codigoMunicipioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Municipio',
																labelText: 'Codigo Municipio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.codigoMunicipio = int.tryParse(text);
																nfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfeCabecalhoController.nfeCabecalhoModel.formatoImpressaoDanfe ?? '0=Sem geração de DANFE',
															labelText: 'Formato Impressao Danfe',
															hintText: 'Informe os dados para o campo Formato Impressao Danfe',
															items: const ['0=Sem geração de DANFE','1=DANFE normal','Retrato','2=DANFE normal','Paisagem','3=DANFE Simplificado'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.formatoImpressaoDanfe = newValue;
																nfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfeCabecalhoController.nfeCabecalhoModel.tipoEmissao ?? '1=Emissão normal',
															labelText: 'Tipo Emissao',
															hintText: 'Informe os dados para o campo Tipo Emissao',
															items: const ['1=Emissão normal','2=Contingência FS-IA','4=Contingência EPEC','5=Contingência FS-DA','6=Contingência SVC-AN','7=Contingência SVC-RS'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.tipoEmissao = newValue;
																nfeCabecalhoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-9',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 44,
															controller: nfeCabecalhoController.chaveAcessoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Chave Acesso',
																labelText: 'Chave Acesso',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.chaveAcesso = text;
																nfeCabecalhoController.formWasChanged = true;
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
															maxLength: 1,
															controller: nfeCabecalhoController.digitoChaveAcessoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Digito Chave Acesso',
																labelText: 'Digito Chave Acesso',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.digitoChaveAcesso = text;
																nfeCabecalhoController.formWasChanged = true;
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
															value: nfeCabecalhoController.nfeCabecalhoModel.ambiente ?? '1=Produção',
															labelText: 'Ambiente',
															hintText: 'Informe os dados para o campo Ambiente',
															items: const ['1=Produção','2=Homologação'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.ambiente = newValue;
																nfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfeCabecalhoController.nfeCabecalhoModel.finalidadeEmissao ?? '1=NF-e normal',
															labelText: 'Finalidade Emissao',
															hintText: 'Informe os dados para o campo Finalidade Emissao',
															items: const ['1=NF-e normal','2=NF-e complementar','3=NF-e de ajuste','4=Devolução de mercadoria'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.finalidadeEmissao = newValue;
																nfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfeCabecalhoController.nfeCabecalhoModel.consumidorOperacao ?? '0=Normal',
															labelText: 'Consumidor Operacao',
															hintText: 'Informe os dados para o campo Consumidor Operacao',
															items: const ['0=Normal','1=Consumidor final'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.consumidorOperacao = newValue;
																nfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfeCabecalhoController.nfeCabecalhoModel.consumidorPresenca ?? '0=Não se aplica',
															labelText: 'Consumidor Presenca',
															hintText: 'Informe os dados para o campo Consumidor Presenca',
															items: const ['0=Não se aplica','1=Operação presencial','2=Operação não presencial','pela Internet','3=Operação não presencial','Teleatendimento','4=NFC-e em operação com entrega a domicílio','5=Operação presencial','fora do estabelecimento','9=Operação não presencial','outros'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.consumidorPresenca = newValue;
																nfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfeCabecalhoController.nfeCabecalhoModel.processoEmissao ?? '0=Emissão de NF-e com aplicativo do contribuinte',
															labelText: 'Processo Emissao',
															hintText: 'Informe os dados para o campo Processo Emissao',
															items: const ['0=Emissão de NF-e com aplicativo do contribuinte','1=Emissão de NF-e avulsa pelo Fisco','2=Emissão de NF-e avulsa','pelo contribuinte com seu certificado digital','através do site do Fisco','3=Emissão NF-e pelo contribuinte com aplicativo fornecido pelo Fisco'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.processoEmissao = newValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.versaoProcessoEmissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Versao Processo Emissao',
																labelText: 'Versao Processo Emissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.versaoProcessoEmissao = text;
																nfeCabecalhoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Entrada Contingencia',
																labelText: 'Data Entrada Contingencia',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: nfeCabecalhoController.nfeCabecalhoModel.dataEntradaContingencia,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	nfeCabecalhoController.nfeCabecalhoModel.dataEntradaContingencia = value;
																	nfeCabecalhoController.formWasChanged = true;
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 255,
															controller: nfeCabecalhoController.justificativaContingenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Justificativa Contingencia',
																labelText: 'Justificativa Contingencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.justificativaContingencia = text;
																nfeCabecalhoController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: nfeCabecalhoController.baseCalculoIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Icms',
																labelText: 'Base Calculo Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.baseCalculoIcms = nfeCabecalhoController.baseCalculoIcmsController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms',
																labelText: 'Valor Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorIcms = nfeCabecalhoController.valorIcmsController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorIcmsDesoneradoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms Desonerado',
																labelText: 'Valor Icms Desonerado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorIcmsDesonerado = nfeCabecalhoController.valorIcmsDesoneradoController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.totalIcmsFcpUfDestinoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Total Icms Fcp Uf Destino',
																labelText: 'Total Icms Fcp Uf Destino',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.totalIcmsFcpUfDestino = nfeCabecalhoController.totalIcmsFcpUfDestinoController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.totalIcmsInterestadualUfDestinoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Total Icms Interestadual Uf Destino',
																labelText: 'Total Icms Interestadual Uf Destino',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.totalIcmsInterestadualUfDestino = nfeCabecalhoController.totalIcmsInterestadualUfDestinoController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.totalIcmsInterestadualUfRemetenteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Total Icms Interestadual Uf Remetente',
																labelText: 'Total Icms Interestadual Uf Remetente',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.totalIcmsInterestadualUfRemetente = nfeCabecalhoController.totalIcmsInterestadualUfRemetenteController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: nfeCabecalhoController.valorTotalFcpController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Fcp',
																labelText: 'Valor Total Fcp',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorTotalFcp = nfeCabecalhoController.valorTotalFcpController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.baseCalculoIcmsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Icms St',
																labelText: 'Base Calculo Icms St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.baseCalculoIcmsSt = nfeCabecalhoController.baseCalculoIcmsStController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorIcmsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms St',
																labelText: 'Valor Icms St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorIcmsSt = nfeCabecalhoController.valorIcmsStController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorTotalFcpStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Fcp St',
																labelText: 'Valor Total Fcp St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorTotalFcpSt = nfeCabecalhoController.valorTotalFcpStController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorTotalFcpStRetidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Fcp St Retido',
																labelText: 'Valor Total Fcp St Retido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorTotalFcpStRetido = nfeCabecalhoController.valorTotalFcpStRetidoController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorTotalProdutosController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Produtos',
																labelText: 'Valor Total Produtos',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorTotalProdutos = nfeCabecalhoController.valorTotalProdutosController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: nfeCabecalhoController.valorFreteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Frete',
																labelText: 'Valor Frete',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorFrete = nfeCabecalhoController.valorFreteController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorSeguroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Seguro',
																labelText: 'Valor Seguro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorSeguro = nfeCabecalhoController.valorSeguroController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto',
																labelText: 'Valor Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorDesconto = nfeCabecalhoController.valorDescontoController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorImpostoImportacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Imposto Importacao',
																labelText: 'Valor Imposto Importacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorImpostoImportacao = nfeCabecalhoController.valorImpostoImportacaoController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorIpiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Ipi',
																labelText: 'Valor Ipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorIpi = nfeCabecalhoController.valorIpiController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorIpiDevolvidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Ipi Devolvido',
																labelText: 'Valor Ipi Devolvido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorIpiDevolvido = nfeCabecalhoController.valorIpiDevolvidoController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: nfeCabecalhoController.valorPisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Pis',
																labelText: 'Valor Pis',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorPis = nfeCabecalhoController.valorPisController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorCofinsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Cofins',
																labelText: 'Valor Cofins',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorCofins = nfeCabecalhoController.valorCofinsController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorDespesasAcessoriasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Despesas Acessorias',
																labelText: 'Valor Despesas Acessorias',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorDespesasAcessorias = nfeCabecalhoController.valorDespesasAcessoriasController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorTotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total',
																labelText: 'Valor Total',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorTotal = nfeCabecalhoController.valorTotalController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorTotalTributosController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Tributos',
																labelText: 'Valor Total Tributos',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorTotalTributos = nfeCabecalhoController.valorTotalTributosController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorServicosController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Servicos',
																labelText: 'Valor Servicos',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorServicos = nfeCabecalhoController.valorServicosController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: nfeCabecalhoController.baseCalculoIssqnController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Issqn',
																labelText: 'Base Calculo Issqn',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.baseCalculoIssqn = nfeCabecalhoController.baseCalculoIssqnController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorIssqnController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Issqn',
																labelText: 'Valor Issqn',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorIssqn = nfeCabecalhoController.valorIssqnController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorPisIssqnController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Pis Issqn',
																labelText: 'Valor Pis Issqn',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorPisIssqn = nfeCabecalhoController.valorPisIssqnController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorCofinsIssqnController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Cofins Issqn',
																labelText: 'Valor Cofins Issqn',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorCofinsIssqn = nfeCabecalhoController.valorCofinsIssqnController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Prestacao Servico',
																labelText: 'Data Prestacao Servico',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: nfeCabecalhoController.nfeCabecalhoModel.dataPrestacaoServico,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	nfeCabecalhoController.nfeCabecalhoModel.dataPrestacaoServico = value;
																	nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorDeducaoIssqnController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Deducao Issqn',
																labelText: 'Valor Deducao Issqn',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorDeducaoIssqn = nfeCabecalhoController.valorDeducaoIssqnController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: nfeCabecalhoController.outrasRetencoesIssqnController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Outras Retencoes Issqn',
																labelText: 'Outras Retencoes Issqn',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.outrasRetencoesIssqn = nfeCabecalhoController.outrasRetencoesIssqnController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.descontoIncondicionadoIssqnController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Desconto Incondicionado Issqn',
																labelText: 'Desconto Incondicionado Issqn',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.descontoIncondicionadoIssqn = nfeCabecalhoController.descontoIncondicionadoIssqnController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.descontoCondicionadoIssqnController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Desconto Condicionado Issqn',
																labelText: 'Desconto Condicionado Issqn',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.descontoCondicionadoIssqn = nfeCabecalhoController.descontoCondicionadoIssqnController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.totalRetencaoIssqnController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Total Retencao Issqn',
																labelText: 'Total Retencao Issqn',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.totalRetencaoIssqn = nfeCabecalhoController.totalRetencaoIssqnController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfeCabecalhoController.nfeCabecalhoModel.regimeEspecialTributacao ?? '0=Emissão de NF-e com aplicativo do contribuinte',
															labelText: 'Regime Especial Tributacao',
															hintText: 'Informe os dados para o campo Regime Especial Tributacao',
															items: const ['0=Emissão de NF-e com aplicativo do contribuinte','1=Microempresa Municipal','2=Estimativa','3=Sociedade de Profissionais','4=Cooperativa','5=Microempresário Individual (MEI)','6=Microempresário e Empresa de Pequeno Porte'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.regimeEspecialTributacao = newValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorRetidoPisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Retido Pis',
																labelText: 'Valor Retido Pis',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorRetidoPis = nfeCabecalhoController.valorRetidoPisController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: nfeCabecalhoController.valorRetidoCofinsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Retido Cofins',
																labelText: 'Valor Retido Cofins',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorRetidoCofins = nfeCabecalhoController.valorRetidoCofinsController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorRetidoCsllController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Retido Csll',
																labelText: 'Valor Retido Csll',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorRetidoCsll = nfeCabecalhoController.valorRetidoCsllController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.baseCalculoIrrfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Irrf',
																labelText: 'Base Calculo Irrf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.baseCalculoIrrf = nfeCabecalhoController.baseCalculoIrrfController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorRetidoIrrfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Retido Irrf',
																labelText: 'Valor Retido Irrf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorRetidoIrrf = nfeCabecalhoController.valorRetidoIrrfController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.baseCalculoPrevidenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Previdencia',
																labelText: 'Base Calculo Previdencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.baseCalculoPrevidencia = nfeCabecalhoController.baseCalculoPrevidenciaController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.valorRetidoPrevidenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Retido Previdencia',
																labelText: 'Valor Retido Previdencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.valorRetidoPrevidencia = nfeCabecalhoController.valorRetidoPrevidenciaController.numberValue;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.informacoesAddFiscoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Informacoes Add Fisco',
																labelText: 'Informacoes Add Fisco',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.informacoesAddFisco = text;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.informacoesAddContribuinteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Informacoes Add Contribuinte',
																labelText: 'Informacoes Add Contribuinte',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.informacoesAddContribuinte = text;
																nfeCabecalhoController.formWasChanged = true;
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
															value: nfeCabecalhoController.nfeCabecalhoModel.comexUfEmbarque ?? 'AC',
															labelText: 'Comex Uf Embarque',
															hintText: 'Informe os dados para o campo Comex Uf Embarque',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.comexUfEmbarque = newValue;
																nfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-5',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 60,
															controller: nfeCabecalhoController.comexLocalEmbarqueController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Comex Local Embarque',
																labelText: 'Comex Local Embarque',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.comexLocalEmbarque = text;
																nfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-5',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 60,
															controller: nfeCabecalhoController.comexLocalDespachoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Comex Local Despacho',
																labelText: 'Comex Local Despacho',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.comexLocalDespacho = text;
																nfeCabecalhoController.formWasChanged = true;
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
															maxLength: 22,
															controller: nfeCabecalhoController.compraNotaEmpenhoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Compra Nota Empenho',
																labelText: 'Compra Nota Empenho',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.compraNotaEmpenho = text;
																nfeCabecalhoController.formWasChanged = true;
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
															maxLength: 60,
															controller: nfeCabecalhoController.compraPedidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Compra Pedido',
																labelText: 'Compra Pedido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.compraPedido = text;
																nfeCabecalhoController.formWasChanged = true;
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
															maxLength: 60,
															controller: nfeCabecalhoController.compraContratoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Compra Contrato',
																labelText: 'Compra Contrato',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.compraContrato = text;
																nfeCabecalhoController.formWasChanged = true;
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
															controller: nfeCabecalhoController.qrcodeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Qrcode',
																labelText: 'Qrcode',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.qrcode = text;
																nfeCabecalhoController.formWasChanged = true;
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
															maxLength: 85,
															controller: nfeCabecalhoController.urlChaveController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Url Chave',
																labelText: 'Url Chave',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCabecalhoController.nfeCabecalhoModel.urlChave = text;
																nfeCabecalhoController.formWasChanged = true;
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
															value: nfeCabecalhoController.nfeCabecalhoModel.statusNota ?? '1-Salva',
															labelText: 'Status Nota',
															hintText: 'Informe os dados para o campo Status Nota',
															items: const ['1-Salva','2-Validada','3-Assinada','4-Autorizada','5-Inutilizada','6-Cancelada'],
															onChanged: (dynamic newValue) {
																nfeCabecalhoController.nfeCabecalhoModel.statusNota = newValue;
																nfeCabecalhoController.formWasChanged = true;
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
