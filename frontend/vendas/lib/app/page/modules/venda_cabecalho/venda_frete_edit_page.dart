import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:vendas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:vendas/app/controller/venda_frete_controller.dart';
import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/page/shared_widget/input/input_imports.dart';

class VendaFreteEditPage extends StatelessWidget {
	VendaFreteEditPage({Key? key}) : super(key: key);
	final vendaFreteController = Get.find<VendaFreteController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: vendaFreteController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Frete - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: vendaFreteController.save),
						cancelAndExitButton(onPressed: vendaFreteController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: vendaFreteController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: vendaFreteController.scrollController,
							child: SingleChildScrollView(
								controller: vendaFreteController.scrollController,
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
																		controller: vendaFreteController.viewPessoaTransportadoraModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Transportadora',
																			labelText: 'Transportadora *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: vendaFreteController.callViewPessoaTransportadoraLookup),
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
															value: vendaFreteController.vendaFreteModel.responsavel ?? '1-Emitente',
															labelText: 'Responsavel',
															hintText: 'Informe os dados para o campo Responsavel',
															items: const ['1-Emitente','2-Destinatário'],
															onChanged: (dynamic newValue) {
																vendaFreteController.vendaFreteModel.responsavel = newValue;
																vendaFreteController.formWasChanged = true;
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
															controller: vendaFreteController.conhecimentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conhecimento',
																labelText: 'Conhecimento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaFreteController.vendaFreteModel.conhecimento = int.tryParse(text);
																vendaFreteController.formWasChanged = true;
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
															maxLength: 7,
															controller: vendaFreteController.placaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Placa',
																labelText: 'Placa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaFreteController.vendaFreteModel.placa = text;
																vendaFreteController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: vendaFreteController.vendaFreteModel.ufPlaca ?? 'AC',
															labelText: 'Uf Placa',
															hintText: 'Informe os dados para o campo Uf Placa',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																vendaFreteController.vendaFreteModel.ufPlaca = newValue;
																vendaFreteController.formWasChanged = true;
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
															controller: vendaFreteController.seloFiscalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Selo Fiscal',
																labelText: 'Selo Fiscal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaFreteController.vendaFreteModel.seloFiscal = int.tryParse(text);
																vendaFreteController.formWasChanged = true;
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
															controller: vendaFreteController.quantidadeVolumeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Volume',
																labelText: 'Quantidade Volume',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaFreteController.vendaFreteModel.quantidadeVolume = vendaFreteController.quantidadeVolumeController.numberValue;
																vendaFreteController.formWasChanged = true;
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
															controller: vendaFreteController.marcaVolumeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Marca Volume',
																labelText: 'Marca Volume',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaFreteController.vendaFreteModel.marcaVolume = text;
																vendaFreteController.formWasChanged = true;
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
															maxLength: 20,
															controller: vendaFreteController.especieVolumeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Especie Volume',
																labelText: 'Especie Volume',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaFreteController.vendaFreteModel.especieVolume = text;
																vendaFreteController.formWasChanged = true;
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
															controller: vendaFreteController.pesoBrutoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Peso Bruto',
																labelText: 'Peso Bruto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaFreteController.vendaFreteModel.pesoBruto = vendaFreteController.pesoBrutoController.numberValue;
																vendaFreteController.formWasChanged = true;
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
															controller: vendaFreteController.pesoLiquidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Peso Liquido',
																labelText: 'Peso Liquido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaFreteController.vendaFreteModel.pesoLiquido = vendaFreteController.pesoLiquidoController.numberValue;
																vendaFreteController.formWasChanged = true;
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
