import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_cupom_fiscal_referenciado_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeCupomFiscalReferenciadoEditPage extends StatelessWidget {
	NfeCupomFiscalReferenciadoEditPage({Key? key}) : super(key: key);
	final nfeCupomFiscalReferenciadoController = Get.find<NfeCupomFiscalReferenciadoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeCupomFiscalReferenciadoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('CF Referenciado - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeCupomFiscalReferenciadoController.save),
						cancelAndExitButton(onPressed: nfeCupomFiscalReferenciadoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeCupomFiscalReferenciadoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeCupomFiscalReferenciadoController.scrollController,
							child: SingleChildScrollView(
								controller: nfeCupomFiscalReferenciadoController.scrollController,
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
															value: nfeCupomFiscalReferenciadoController.nfeCupomFiscalReferenciadoModel.modeloDocumentoFiscal ?? 'AAA',
															labelText: 'Modelo Documento Fiscal',
															hintText: 'Informe os dados para o campo Modelo Documento Fiscal',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeCupomFiscalReferenciadoController.nfeCupomFiscalReferenciadoModel.modeloDocumentoFiscal = newValue;
																nfeCupomFiscalReferenciadoController.formWasChanged = true;
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
															controller: nfeCupomFiscalReferenciadoController.numeroOrdemEcfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Ordem Ecf',
																labelText: 'Numero Ordem Ecf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCupomFiscalReferenciadoController.nfeCupomFiscalReferenciadoModel.numeroOrdemEcf = int.tryParse(text);
																nfeCupomFiscalReferenciadoController.formWasChanged = true;
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
															controller: nfeCupomFiscalReferenciadoController.cooController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Coo',
																labelText: 'Coo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCupomFiscalReferenciadoController.nfeCupomFiscalReferenciadoModel.coo = int.tryParse(text);
																nfeCupomFiscalReferenciadoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Emissao Cupom',
																labelText: 'Data Emissao Cupom',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: nfeCupomFiscalReferenciadoController.nfeCupomFiscalReferenciadoModel.dataEmissaoCupom,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	nfeCupomFiscalReferenciadoController.nfeCupomFiscalReferenciadoModel.dataEmissaoCupom = value;
																	nfeCupomFiscalReferenciadoController.formWasChanged = true;
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
															controller: nfeCupomFiscalReferenciadoController.numeroCaixaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Caixa',
																labelText: 'Numero Caixa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCupomFiscalReferenciadoController.nfeCupomFiscalReferenciadoModel.numeroCaixa = int.tryParse(text);
																nfeCupomFiscalReferenciadoController.formWasChanged = true;
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
															maxLength: 21,
															controller: nfeCupomFiscalReferenciadoController.numeroSerieEcfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Serie Ecf',
																labelText: 'Numero Serie Ecf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCupomFiscalReferenciadoController.nfeCupomFiscalReferenciadoModel.numeroSerieEcf = text;
																nfeCupomFiscalReferenciadoController.formWasChanged = true;
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
