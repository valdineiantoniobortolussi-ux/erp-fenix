import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:mdfe/app/controller/mdfe_cabecalho_controller.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/page/shared_widget/input/input_imports.dart';

class MdfeCabecalhoEditPage extends StatelessWidget {
	MdfeCabecalhoEditPage({Key? key}) : super(key: key);
	final mdfeCabecalhoController = Get.find<MdfeCabecalhoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: mdfeCabecalhoController.mdfeCabecalhoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: mdfeCabecalhoController.mdfeCabecalhoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: mdfeCabecalhoController.scrollController,
							child: SingleChildScrollView(
								controller: mdfeCabecalhoController.scrollController,
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
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: mdfeCabecalhoController.mdfeCabecalhoModel.uf ?? 'AC',
															labelText: 'UF',
															hintText: 'Informe os dados para o campo Uf',
															items: const ['AC','AL','AM','AP','BA','CE','DF','ES','GO','MA','MG','MS','MT','PA','PB','PE','PI','PR','RJ','RN','RO','RR','RS','SC','SE','SP','TO'],
															onChanged: (dynamic newValue) {
																mdfeCabecalhoController.mdfeCabecalhoModel.uf = newValue;
																mdfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: mdfeCabecalhoController.mdfeCabecalhoModel.tipoAmbiente ?? '1-Produção',
															labelText: 'Tipo Ambiente',
															hintText: 'Informe os dados para o campo Tipo Ambiente',
															items: const ['1-Produção','2-Homologação'],
															onChanged: (dynamic newValue) {
																mdfeCabecalhoController.mdfeCabecalhoModel.tipoAmbiente = newValue;
																mdfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: mdfeCabecalhoController.mdfeCabecalhoModel.tipoEmitente ?? '1-Prestador de serviço de transporte',
															labelText: 'Tipo Emitente',
															hintText: 'Informe os dados para o campo Tipo Emitente',
															items: const ['1-Prestador de serviço de transporte','2-Transportador de Carga Própria'],
															onChanged: (dynamic newValue) {
																mdfeCabecalhoController.mdfeCabecalhoModel.tipoEmitente = newValue;
																mdfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: mdfeCabecalhoController.mdfeCabecalhoModel.tipoTransportadora ?? 'ETC',
															labelText: 'Tipo Transportadora',
															hintText: 'Informe os dados para o campo Tipo Transportadora',
															items: const ['ETC','TAC','CTC'],
															onChanged: (dynamic newValue) {
																mdfeCabecalhoController.mdfeCabecalhoModel.tipoTransportadora = newValue;
																mdfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: mdfeCabecalhoController.mdfeCabecalhoModel.modelo ?? '58',
															labelText: 'Modelo',
															hintText: 'Informe os dados para o campo Modelo',
															items: const ['58'],
															onChanged: (dynamic newValue) {
																mdfeCabecalhoController.mdfeCabecalhoModel.modelo = newValue;
																mdfeCabecalhoController.formWasChanged = true;
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
															controller: mdfeCabecalhoController.serieController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Serie',
																labelText: 'Serie',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeCabecalhoController.mdfeCabecalhoModel.serie = text;
																mdfeCabecalhoController.formWasChanged = true;
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
															maxLength: 9,
															controller: mdfeCabecalhoController.numeroMdfeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Mdfe',
																labelText: 'Numero MDFe',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeCabecalhoController.mdfeCabecalhoModel.numeroMdfe = text;
																mdfeCabecalhoController.formWasChanged = true;
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
															controller: mdfeCabecalhoController.codigoNumericoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Numerico',
																labelText: 'Codigo Numerico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeCabecalhoController.mdfeCabecalhoModel.codigoNumerico = text;
																mdfeCabecalhoController.formWasChanged = true;
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
															maxLength: 44,
															controller: mdfeCabecalhoController.chaveAcessoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Chave Acesso',
																labelText: 'Chave Acesso',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeCabecalhoController.mdfeCabecalhoModel.chaveAcesso = text;
																mdfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-1',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: mdfeCabecalhoController.digitoVerificadorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Digito Verificador',
																labelText: 'Digito Verificador',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeCabecalhoController.mdfeCabecalhoModel.digitoVerificador = int.tryParse(text);
																mdfeCabecalhoController.formWasChanged = true;
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
															value: mdfeCabecalhoController.mdfeCabecalhoModel.modal ?? '1-Rodoviário',
															labelText: 'Modal',
															hintText: 'Informe os dados para o campo Modal',
															items: const ['1-Rodoviário','2-Aéreo','3-Aquaviário','4-Ferroviário'],
															onChanged: (dynamic newValue) {
																mdfeCabecalhoController.mdfeCabecalhoModel.modal = newValue;
																mdfeCabecalhoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Hora Emissao',
																labelText: 'Data Hora Emissao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: mdfeCabecalhoController.mdfeCabecalhoModel.dataHoraEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	mdfeCabecalhoController.mdfeCabecalhoModel.dataHoraEmissao = value;
																	mdfeCabecalhoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: mdfeCabecalhoController.mdfeCabecalhoModel.tipoEmissao ?? '1-Normal',
															labelText: 'Tipo Emissao',
															hintText: 'Informe os dados para o campo Tipo Emissao',
															items: const ['1-Normal','2-Contingência'],
															onChanged: (dynamic newValue) {
																mdfeCabecalhoController.mdfeCabecalhoModel.tipoEmissao = newValue;
																mdfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: mdfeCabecalhoController.mdfeCabecalhoModel.processoEmissao ?? '0-Emissão de MDF-e com aplicativo do  contribuinte',
															labelText: 'Processo Emissao',
															hintText: 'Informe os dados para o campo Processo Emissao',
															items: const ['0-Emissão de MDF-e com aplicativo do  contribuinte','3-emissão MDF-e pelo contribuinte com  aplicativo fornecido pelo Fisco'],
															onChanged: (dynamic newValue) {
																mdfeCabecalhoController.mdfeCabecalhoModel.processoEmissao = newValue;
																mdfeCabecalhoController.formWasChanged = true;
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
															controller: mdfeCabecalhoController.versaoProcessoEmissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Versao Processo Emissao',
																labelText: 'Versao Processo Emissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeCabecalhoController.mdfeCabecalhoModel.versaoProcessoEmissao = text;
																mdfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: mdfeCabecalhoController.mdfeCabecalhoModel.ufInicio ?? 'AC',
															labelText: 'Uf Inicio',
															hintText: 'Informe os dados para o campo Uf Inicio',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																mdfeCabecalhoController.mdfeCabecalhoModel.ufInicio = newValue;
																mdfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: mdfeCabecalhoController.mdfeCabecalhoModel.ufFim ?? 'AC',
															labelText: 'Uf Fim',
															hintText: 'Informe os dados para o campo Uf Fim',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																mdfeCabecalhoController.mdfeCabecalhoModel.ufFim = newValue;
																mdfeCabecalhoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Hora Previsao Viagem',
																labelText: 'Data Hora Previsao Viagem',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: mdfeCabecalhoController.mdfeCabecalhoModel.dataHoraPrevisaoViagem,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	mdfeCabecalhoController.mdfeCabecalhoModel.dataHoraPrevisaoViagem = value;
																	mdfeCabecalhoController.formWasChanged = true;
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
															controller: mdfeCabecalhoController.quantidadeTotalCteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Total Cte',
																labelText: 'Quantidade Total Cte',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeCabecalhoController.mdfeCabecalhoModel.quantidadeTotalCte = int.tryParse(text);
																mdfeCabecalhoController.formWasChanged = true;
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
															controller: mdfeCabecalhoController.quantidadeTotalNfeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Total Nfe',
																labelText: 'Quantidade Total Nfe',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeCabecalhoController.mdfeCabecalhoModel.quantidadeTotalNfe = int.tryParse(text);
																mdfeCabecalhoController.formWasChanged = true;
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
															controller: mdfeCabecalhoController.quantidadeTotalMdfeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Total Mdfe',
																labelText: 'Quantidade Total Mdfe',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeCabecalhoController.mdfeCabecalhoModel.quantidadeTotalMdfe = int.tryParse(text);
																mdfeCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: mdfeCabecalhoController.mdfeCabecalhoModel.codigoUnidadeMedida ?? '01-KG',
															labelText: 'Codigo Unidade Medida',
															hintText: 'Informe os dados para o campo Codigo Unidade Medida',
															items: const ['01-KG','02-TON'],
															onChanged: (dynamic newValue) {
																mdfeCabecalhoController.mdfeCabecalhoModel.codigoUnidadeMedida = newValue;
																mdfeCabecalhoController.formWasChanged = true;
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
															controller: mdfeCabecalhoController.pesoBrutoCargaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Peso Bruto Carga',
																labelText: 'Peso Bruto Carga',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeCabecalhoController.mdfeCabecalhoModel.pesoBrutoCarga = mdfeCabecalhoController.pesoBrutoCargaController.numberValue;
																mdfeCabecalhoController.formWasChanged = true;
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
															controller: mdfeCabecalhoController.valorCargaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Carga',
																labelText: 'Valor Carga',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeCabecalhoController.mdfeCabecalhoModel.valorCarga = mdfeCabecalhoController.valorCargaController.numberValue;
																mdfeCabecalhoController.formWasChanged = true;
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
															maxLength: 15,
															controller: mdfeCabecalhoController.numeroProtocoloController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Protocolo',
																labelText: 'Numero Protocolo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeCabecalhoController.mdfeCabecalhoModel.numeroProtocolo = text;
																mdfeCabecalhoController.formWasChanged = true;
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
