import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_informacao_nf_outros_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteInformacaoNfOutrosEditPage extends StatelessWidget {
	CteInformacaoNfOutrosEditPage({Key? key}) : super(key: key);
	final cteInformacaoNfOutrosController = Get.find<CteInformacaoNfOutrosController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: cteInformacaoNfOutrosController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('NF Outros - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteInformacaoNfOutrosController.save),
						cancelAndExitButton(onPressed: cteInformacaoNfOutrosController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteInformacaoNfOutrosController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteInformacaoNfOutrosController.scrollController,
							child: SingleChildScrollView(
								controller: cteInformacaoNfOutrosController.scrollController,
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
															maxLength: 20,
															controller: cteInformacaoNfOutrosController.numeroRomaneioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Romaneio',
																labelText: 'Numero Romaneio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.numeroRomaneio = text;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.numeroPedidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Pedido',
																labelText: 'Numero Pedido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.numeroPedido = text;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.chaveAcessoNfeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Chave Acesso Nfe',
																labelText: 'Chave Acesso Nfe',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.chaveAcessoNfe = text;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															value: cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.codigoModelo ?? 'AAA',
															labelText: 'Codigo Modelo',
															hintText: 'Informe os dados para o campo Codigo Modelo',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.codigoModelo = newValue;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															value: cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.serie ?? 'AAA',
															labelText: 'Serie',
															hintText: 'Informe os dados para o campo Serie',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.serie = newValue;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.numero = text;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Emissao',
																labelText: 'Data Emissao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.dataEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.dataEmissao = value;
																	cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.ufEmitenteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Uf Emitente',
																labelText: 'Uf Emitente',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.ufEmitente = int.tryParse(text);
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.baseCalculoIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Icms',
																labelText: 'Base Calculo Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.baseCalculoIcms = cteInformacaoNfOutrosController.baseCalculoIcmsController.numberValue;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.valorIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms',
																labelText: 'Valor Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.valorIcms = cteInformacaoNfOutrosController.valorIcmsController.numberValue;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.baseCalculoIcmsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Icms St',
																labelText: 'Base Calculo Icms St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.baseCalculoIcmsSt = cteInformacaoNfOutrosController.baseCalculoIcmsStController.numberValue;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.valorIcmsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms St',
																labelText: 'Valor Icms St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.valorIcmsSt = cteInformacaoNfOutrosController.valorIcmsStController.numberValue;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.valorTotalProdutosController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total Produtos',
																labelText: 'Valor Total Produtos',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.valorTotalProdutos = cteInformacaoNfOutrosController.valorTotalProdutosController.numberValue;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.valorTotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Total',
																labelText: 'Valor Total',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.valorTotal = cteInformacaoNfOutrosController.valorTotalController.numberValue;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.cfopPredominanteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cfop Predominante',
																labelText: 'Cfop Predominante',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.cfopPredominante = int.tryParse(text);
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.pesoTotalKgController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Peso Total Kg',
																labelText: 'Peso Total Kg',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.pesoTotalKg = cteInformacaoNfOutrosController.pesoTotalKgController.numberValue;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.pinSuframaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Pin Suframa',
																labelText: 'Pin Suframa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.pinSuframa = int.tryParse(text);
																cteInformacaoNfOutrosController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Prevista Entrega',
																labelText: 'Data Prevista Entrega',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.dataPrevistaEntrega,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.dataPrevistaEntrega = value;
																	cteInformacaoNfOutrosController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.outroTipoDocOrig ?? 'AAA',
															labelText: 'Outro Tipo Doc Orig',
															hintText: 'Informe os dados para o campo Outro Tipo Doc Orig',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.outroTipoDocOrig = newValue;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.outroDescricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Outro Descricao',
																labelText: 'Outro Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.outroDescricao = text;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
															controller: cteInformacaoNfOutrosController.outroValorDocumentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Outro Valor Documento',
																labelText: 'Outro Valor Documento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteInformacaoNfOutrosController.cteInformacaoNfOutrosModel.outroValorDocumento = cteInformacaoNfOutrosController.outroValorDocumentoController.numberValue;
																cteInformacaoNfOutrosController.formWasChanged = true;
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
