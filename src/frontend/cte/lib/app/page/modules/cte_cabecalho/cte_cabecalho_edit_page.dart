import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/controller/cte_cabecalho_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteCabecalhoEditPage extends StatelessWidget {
	CteCabecalhoEditPage({Key? key}) : super(key: key);
	final cteCabecalhoController = Get.find<CteCabecalhoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: cteCabecalhoController.cteCabecalhoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteCabecalhoController.cteCabecalhoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteCabecalhoController.scrollController,
							child: SingleChildScrollView(
								controller: cteCabecalhoController.scrollController,
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
														child: TextFormField(
															autofocus: true,
															maxLength: 60,
															controller: cteCabecalhoController.naturezaOperacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Natureza Operacao',
																labelText: 'Natureza Operacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.naturezaOperacao = text;
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 44,
															controller: cteCabecalhoController.chaveAcessoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Chave Acesso',
																labelText: 'Chave Acesso',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.chaveAcesso = text;
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 1,
															controller: cteCabecalhoController.digitoChaveAcessoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Digito Chave Acesso',
																labelText: 'Digito Chave Acesso',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.digitoChaveAcesso = text;
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 8,
															controller: cteCabecalhoController.codigoNumericoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Numerico',
																labelText: 'Codigo Numerico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.codigoNumerico = text;
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 3,
															controller: cteCabecalhoController.serieController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Serie',
																labelText: 'Serie',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.serie = text;
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 9,
															controller: cteCabecalhoController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.numero = text;
																cteCabecalhoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Hora Emissao',
																labelText: 'Data Hora Emissao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: cteCabecalhoController.cteCabecalhoModel.dataHoraEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	cteCabecalhoController.cteCabecalhoModel.dataHoraEmissao = value;
																	cteCabecalhoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: cteCabecalhoController.cteCabecalhoModel.ufEmitente ?? 'AC',
															labelText: 'UF Emitente',
															hintText: 'Informe os dados para o campo Uf Emitente',
															items: const ['AC','AL','AM','AP','BA','CE','DF','ES','GO','MA','MG','MS','MT','PA','PB','PE','PI','PR','RJ','RN','RO','RR','RS','SC','SE','SP','TO'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.ufEmitente = newValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.cfopController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cfop',
																labelText: 'Cfop',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.cfop = int.tryParse(text);
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: cteCabecalhoController.cteCabecalhoModel.formaPagamento ?? '0-Pago',
															labelText: 'Forma Pagamento',
															hintText: 'Informe os dados para o campo Forma Pagamento',
															items: const ['0-Pago','1-A pagar','2-Outros'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.formaPagamento = newValue;
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: cteCabecalhoController.cteCabecalhoModel.modelo ?? '57',
															labelText: 'Modelo',
															hintText: 'Informe os dados para o campo Modelo',
															items: const ['57'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.modelo = newValue;
																cteCabecalhoController.formWasChanged = true;
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
															value: cteCabecalhoController.cteCabecalhoModel.formatoImpressaoDacte ?? '1-Retrato',
															labelText: 'Formato Impressao Dacte',
															hintText: 'Informe os dados para o campo Formato Impressao Dacte',
															items: const ['1-Retrato','2-Paisagem'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.formatoImpressaoDacte = newValue;
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: cteCabecalhoController.cteCabecalhoModel.tipoEmissao ?? '1 - Normal',
															labelText: 'Tipo Emissao',
															hintText: 'Informe os dados para o campo Tipo Emissao',
															items: const ['1 - Normal','4-EPEC pela SVC','5 - Contingência FSDA','7 - Autorização pela SVC-RS','8 - Autorização pela SVC-SP'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.tipoEmissao = newValue;
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: cteCabecalhoController.cteCabecalhoModel.ambiente ?? '1-Produção',
															labelText: 'Ambiente',
															hintText: 'Informe os dados para o campo Ambiente',
															items: const ['1-Produção','2-Homologação'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.ambiente = newValue;
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: cteCabecalhoController.cteCabecalhoModel.tipoCte ?? '0 - CT-e Normal',
															labelText: 'Tipo Cte',
															hintText: 'Informe os dados para o campo Tipo Cte',
															items: const ['0 - CT-e Normal','1 - CT-e de Complemento de Valores','2 - CT-e de Anulação','3 - CT-e Substituto'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.tipoCte = newValue;
																cteCabecalhoController.formWasChanged = true;
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
															value: cteCabecalhoController.cteCabecalhoModel.processoEmissao ?? '0 - emissão de CT-e com aplicativo do contribuinte; 1 - emissão de CT-e avulsa pelo Fisco; 2 - emissão de CT-e avulsa',
															labelText: 'Processo Emissao',
															hintText: 'Informe os dados para o campo Processo Emissao',
															items: const ['0 - emissão de CT-e com aplicativo do contribuinte; 1 - emissão de CT-e avulsa pelo Fisco; 2 - emissão de CT-e avulsa','pelo contribuinte com seu certificado digital','através do site do Fisco; 3 - emissão CT-e pelo contribuinte com aplicativo fornecido pelo Fisco'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.processoEmissao = newValue;
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 20,
															controller: cteCabecalhoController.versaoProcessoEmissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Versao Processo Emissao',
																labelText: 'Versao Processo Emissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.versaoProcessoEmissao = text;
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 44,
															controller: cteCabecalhoController.chaveReferenciadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Chave Referenciado',
																labelText: 'Chave Referenciado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.chaveReferenciado = text;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.codigoMunicipioEnvioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Municipio Envio',
																labelText: 'Codigo Municipio Envio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.codigoMunicipioEnvio = int.tryParse(text);
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 60,
															controller: cteCabecalhoController.nomeMunicipioEnvioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Municipio Envio',
																labelText: 'Nome Municipio Envio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.nomeMunicipioEnvio = text;
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: cteCabecalhoController.cteCabecalhoModel.ufEnvio ?? 'AC',
															labelText: 'Uf Envio',
															hintText: 'Informe os dados para o campo Uf Envio',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.ufEnvio = newValue;
																cteCabecalhoController.formWasChanged = true;
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
															value: cteCabecalhoController.cteCabecalhoModel.modal ?? '01-Rodoviário',
															labelText: 'Modal',
															hintText: 'Informe os dados para o campo Modal',
															items: const ['01-Rodoviário','02-Aéreo','03-Aquaviário','04-Ferroviário','05-Dutoviário','06-Multimodal'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.modal = newValue;
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: cteCabecalhoController.cteCabecalhoModel.tipoServico ?? '0 - Normal',
															labelText: 'Tipo Servico',
															hintText: 'Informe os dados para o campo Tipo Servico',
															items: const ['0 - Normal','1 - Subcontratação','2 - Redespacho','3 - Redespacho Intermediário','4 - Serviço Vinculado a Multimodal'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.tipoServico = newValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.codigoMunicipioIniPrestacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Municipio Ini Prestacao',
																labelText: 'Codigo Municipio Ini Prestacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.codigoMunicipioIniPrestacao = int.tryParse(text);
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 60,
															controller: cteCabecalhoController.nomeMunicipioIniPrestacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Municipio Ini Prestacao',
																labelText: 'Nome Municipio Ini Prestacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.nomeMunicipioIniPrestacao = text;
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: cteCabecalhoController.cteCabecalhoModel.ufIniPrestacao ?? 'AC',
															labelText: 'Uf Ini Prestacao',
															hintText: 'Informe os dados para o campo Uf Ini Prestacao',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.ufIniPrestacao = newValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.codigoMunicipioFimPrestacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Municipio Fim Prestacao',
																labelText: 'Codigo Municipio Fim Prestacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.codigoMunicipioFimPrestacao = int.tryParse(text);
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 60,
															controller: cteCabecalhoController.nomeMunicipioFimPrestacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Municipio Fim Prestacao',
																labelText: 'Nome Municipio Fim Prestacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.nomeMunicipioFimPrestacao = text;
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: cteCabecalhoController.cteCabecalhoModel.ufFimPrestacao ?? 'AC',
															labelText: 'Uf Fim Prestacao',
															hintText: 'Informe os dados para o campo Uf Fim Prestacao',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.ufFimPrestacao = newValue;
																cteCabecalhoController.formWasChanged = true;
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
															value: cteCabecalhoController.cteCabecalhoModel.retira ?? 'Sim',
															labelText: 'Retira',
															hintText: 'Informe os dados para o campo Retira',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.retira = newValue;
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-10',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 160,
															controller: cteCabecalhoController.retiraDetalheController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Retira Detalhe',
																labelText: 'Retira Detalhe',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.retiraDetalhe = text;
																cteCabecalhoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: cteCabecalhoController.cteCabecalhoModel.tomador ?? '0-Remetente',
															labelText: 'Tomador',
															hintText: 'Informe os dados para o campo Tomador',
															items: const ['0-Remetente','1-Expedidor','2-Recebedor','3-Destinatário','4-Outros'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.tomador = newValue;
																cteCabecalhoController.formWasChanged = true;
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
																dateTime: cteCabecalhoController.cteCabecalhoModel.dataEntradaContingencia,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	cteCabecalhoController.cteCabecalhoModel.dataEntradaContingencia = value;
																	cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.justificativaContingenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Justificativa Contingencia',
																labelText: 'Justificativa Contingencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.justificativaContingencia = text;
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 15,
															controller: cteCabecalhoController.caracAdicionalTransporteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Carac Adicional Transporte',
																labelText: 'Carac Adicional Transporte',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.caracAdicionalTransporte = text;
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 30,
															controller: cteCabecalhoController.caracAdicionalServicoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Carac Adicional Servico',
																labelText: 'Carac Adicional Servico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.caracAdicionalServico = text;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.funcionarioEmissorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Funcionario Emissor',
																labelText: 'Funcionario Emissor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.funcionarioEmissor = text;
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 15,
															controller: cteCabecalhoController.fluxoOrigemController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fluxo Origem',
																labelText: 'Fluxo Origem',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.fluxoOrigem = text;
																cteCabecalhoController.formWasChanged = true;
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
															value: cteCabecalhoController.cteCabecalhoModel.entregaTipoPeriodo ?? '0-Sem data definida',
															labelText: 'Entrega Tipo Periodo',
															hintText: 'Informe os dados para o campo Entrega Tipo Periodo',
															items: const ['0-Sem data definida','1-Na data','2-Até a data','3-A partir da data','4-No período'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.entregaTipoPeriodo = newValue;
																cteCabecalhoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Entrega Data Programada',
																labelText: 'Entrega Data Programada',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: cteCabecalhoController.cteCabecalhoModel.entregaDataProgramada,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	cteCabecalhoController.cteCabecalhoModel.entregaDataProgramada = value;
																	cteCabecalhoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Entrega Data Inicial',
																labelText: 'Entrega Data Inicial',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: cteCabecalhoController.cteCabecalhoModel.entregaDataInicial,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	cteCabecalhoController.cteCabecalhoModel.entregaDataInicial = value;
																	cteCabecalhoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Entrega Data Final',
																labelText: 'Entrega Data Final',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: cteCabecalhoController.cteCabecalhoModel.entregaDataFinal,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	cteCabecalhoController.cteCabecalhoModel.entregaDataFinal = value;
																	cteCabecalhoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: cteCabecalhoController.cteCabecalhoModel.entregaTipoHora ?? '0-Sem hora definida',
															labelText: 'Entrega Tipo Hora',
															hintText: 'Informe os dados para o campo Entrega Tipo Hora',
															items: const ['0-Sem hora definida','1-No horário','2-Até o horário','3-A partir do horário','4-No intervalo de tempo'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.entregaTipoHora = newValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.entregaHoraProgramadaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrega Hora Programada',
																labelText: 'Entrega Hora Programada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.entregaHoraProgramada = text;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.entregaHoraInicialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrega Hora Inicial',
																labelText: 'Entrega Hora Inicial',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.entregaHoraInicial = text;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.entregaHoraFinalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrega Hora Final',
																labelText: 'Entrega Hora Final',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.entregaHoraFinal = text;
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 40,
															controller: cteCabecalhoController.municipioOrigemCalculoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Municipio Origem Calculo',
																labelText: 'Municipio Origem Calculo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.municipioOrigemCalculo = text;
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 40,
															controller: cteCabecalhoController.municipioDestinoCalculoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Municipio Destino Calculo',
																labelText: 'Municipio Destino Calculo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.municipioDestinoCalculo = text;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.observacoesGeraisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacoes Gerais',
																labelText: 'Observacoes Gerais',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.observacoesGerais = text;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.valorTotalServicoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Servico',
																labelText: 'Valor Total Servico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.valorTotalServico = cteCabecalhoController.valorTotalServicoController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.valorReceberController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Receber',
																labelText: 'Valor Receber',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.valorReceber = cteCabecalhoController.valorReceberController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 2,
															controller: cteCabecalhoController.cstController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cst',
																labelText: 'Cst',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.cst = text;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.baseCalculoIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Icms',
																labelText: 'Base Calculo Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.baseCalculoIcms = cteCabecalhoController.baseCalculoIcmsController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.aliquotaIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Icms',
																labelText: 'Aliquota Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.aliquotaIcms = cteCabecalhoController.aliquotaIcmsController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.valorIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms',
																labelText: 'Valor Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.valorIcms = cteCabecalhoController.valorIcmsController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.percentualReducaoBcIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Reducao Bc Icms',
																labelText: 'Percentual Reducao Bc Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.percentualReducaoBcIcms = cteCabecalhoController.percentualReducaoBcIcmsController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.valorBcIcmsStRetidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Icms St Retido',
																labelText: 'Valor Bc Icms St Retido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.valorBcIcmsStRetido = cteCabecalhoController.valorBcIcmsStRetidoController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.valorIcmsStRetidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms St Retido',
																labelText: 'Valor Icms St Retido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.valorIcmsStRetido = cteCabecalhoController.valorIcmsStRetidoController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.aliquotaIcmsStRetidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Icms St Retido',
																labelText: 'Aliquota Icms St Retido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.aliquotaIcmsStRetido = cteCabecalhoController.aliquotaIcmsStRetidoController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.valorCreditoPresumidoIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Credito Presumido Icms',
																labelText: 'Valor Credito Presumido Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.valorCreditoPresumidoIcms = cteCabecalhoController.valorCreditoPresumidoIcmsController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.percentualBcIcmsOutraUfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Bc Icms Outra Uf',
																labelText: 'Percentual Bc Icms Outra Uf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.percentualBcIcmsOutraUf = cteCabecalhoController.percentualBcIcmsOutraUfController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.valorBcIcmsOutraUfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Icms Outra Uf',
																labelText: 'Valor Bc Icms Outra Uf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.valorBcIcmsOutraUf = cteCabecalhoController.valorBcIcmsOutraUfController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.aliquotaIcmsOutraUfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Icms Outra Uf',
																labelText: 'Aliquota Icms Outra Uf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.aliquotaIcmsOutraUf = cteCabecalhoController.aliquotaIcmsOutraUfController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.valorIcmsOutraUfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms Outra Uf',
																labelText: 'Valor Icms Outra Uf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.valorIcmsOutraUf = cteCabecalhoController.valorIcmsOutraUfController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: cteCabecalhoController.cteCabecalhoModel.simplesNacionalIndicador ?? 'Sim',
															labelText: 'Simples Nacional Indicador',
															hintText: 'Informe os dados para o campo Simples Nacional Indicador',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																cteCabecalhoController.cteCabecalhoModel.simplesNacionalIndicador = newValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.simplesNacionalTotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Simples Nacional Total',
																labelText: 'Simples Nacional Total',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.simplesNacionalTotal = cteCabecalhoController.simplesNacionalTotalController.numberValue;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.informacoesAddFiscoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Informacoes Add Fisco',
																labelText: 'Informacoes Add Fisco',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.informacoesAddFisco = text;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.valorTotalCargaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Carga',
																labelText: 'Valor Total Carga',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.valorTotalCarga = cteCabecalhoController.valorTotalCargaController.numberValue;
																cteCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-9',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 60,
															controller: cteCabecalhoController.produtoPredominanteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Produto Predominante',
																labelText: 'Produto Predominante',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.produtoPredominante = text;
																cteCabecalhoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 30,
															controller: cteCabecalhoController.cargaOutrasCaracteristicasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Carga Outras Caracteristicas',
																labelText: 'Carga Outras Caracteristicas',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.cargaOutrasCaracteristicas = text;
																cteCabecalhoController.formWasChanged = true;
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
															controller: cteCabecalhoController.modalVersaoLayoutController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Modal Versao Layout',
																labelText: 'Modal Versao Layout',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.modalVersaoLayout = int.tryParse(text);
																cteCabecalhoController.formWasChanged = true;
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
															maxLength: 44,
															controller: cteCabecalhoController.chaveCteSubstituidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Chave Cte Substituido',
																labelText: 'Chave Cte Substituido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteCabecalhoController.cteCabecalhoModel.chaveCteSubstituido = text;
																cteCabecalhoController.formWasChanged = true;
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
