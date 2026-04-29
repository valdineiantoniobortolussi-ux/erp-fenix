import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfse/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfse/app/controller/nfse_detalhe_controller.dart';
import 'package:nfse/app/infra/infra_imports.dart';
import 'package:nfse/app/page/shared_widget/input/input_imports.dart';

class NfseDetalheEditPage extends StatelessWidget {
	NfseDetalheEditPage({Key? key}) : super(key: key);
	final nfseDetalheController = Get.find<NfseDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfseDetalheController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Itens da NFS-e - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfseDetalheController.save),
						cancelAndExitButton(onPressed: nfseDetalheController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfseDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfseDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: nfseDetalheController.scrollController,
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
																		controller: nfseDetalheController.nfseListaServicoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Lista Serviço',
																			labelText: 'Lista Serviço *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: nfseDetalheController.callNfseListaServicoLookup),
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
															maxLength: 7,
															controller: nfseDetalheController.codigoCnaeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Cnae',
																labelText: 'Codigo Cnae',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.codigoCnae = text;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.codigoTributacaoMunicipioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Tributacao Municipio',
																labelText: 'Codigo Tributacao Municipio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.codigoTributacaoMunicipio = text;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorServicosController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Servicos',
																labelText: 'Valor Servicos',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorServicos = nfseDetalheController.valorServicosController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorDeducoesController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Deducoes',
																labelText: 'Valor Deducoes',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorDeducoes = nfseDetalheController.valorDeducoesController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorPisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Pis',
																labelText: 'Valor Pis',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorPis = nfseDetalheController.valorPisController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorCofinsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Cofins',
																labelText: 'Valor Cofins',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorCofins = nfseDetalheController.valorCofinsController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorInssController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Inss',
																labelText: 'Valor Inss',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorInss = nfseDetalheController.valorInssController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorIrController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Ir',
																labelText: 'Valor Ir',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorIr = nfseDetalheController.valorIrController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorCsllController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Csll',
																labelText: 'Valor Csll',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorCsll = nfseDetalheController.valorCsllController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorBaseCalculoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Base Calculo',
																labelText: 'Valor Base Calculo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorBaseCalculo = nfseDetalheController.valorBaseCalculoController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.aliquotaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota',
																labelText: 'Aliquota',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.aliquota = nfseDetalheController.aliquotaController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorIssController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Iss',
																labelText: 'Valor Iss',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorIss = nfseDetalheController.valorIssController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorLiquidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Liquido',
																labelText: 'Valor Liquido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorLiquido = nfseDetalheController.valorLiquidoController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.outrasRetencoesController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Outras Retencoes',
																labelText: 'Outras Retencoes',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.outrasRetencoes = nfseDetalheController.outrasRetencoesController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorCreditoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Credito',
																labelText: 'Valor Credito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorCredito = nfseDetalheController.valorCreditoController.numberValue;
																nfseDetalheController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: nfseDetalheController.nfseDetalheModel.issRetido ?? 'S',
															labelText: 'Iss Retido',
															hintText: 'Informe os dados para o campo Iss Retido',
															items: const ['S','N'],
															onChanged: (dynamic newValue) {
																nfseDetalheController.nfseDetalheModel.issRetido = newValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorIssRetidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Iss Retido',
																labelText: 'Valor Iss Retido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorIssRetido = nfseDetalheController.valorIssRetidoController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorDescontoCondicionadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto Condicionado',
																labelText: 'Valor Desconto Condicionado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorDescontoCondicionado = nfseDetalheController.valorDescontoCondicionadoController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.valorDescontoIncondicionadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto Incondicionado',
																labelText: 'Valor Desconto Incondicionado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.valorDescontoIncondicionado = nfseDetalheController.valorDescontoIncondicionadoController.numberValue;
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.municipioPrestacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Municipio Prestacao',
																labelText: 'Municipio Prestacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.municipioPrestacao = int.tryParse(text);
																nfseDetalheController.formWasChanged = true;
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
															controller: nfseDetalheController.discriminacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Discriminacao',
																labelText: 'Discriminacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseDetalheController.nfseDetalheModel.discriminacao = text;
																nfseDetalheController.formWasChanged = true;
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
