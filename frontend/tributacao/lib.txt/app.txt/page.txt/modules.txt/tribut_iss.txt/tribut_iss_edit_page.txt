import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:tributacao/app/page/shared_widget/shared_widget_imports.dart';
import 'package:tributacao/app/controller/tribut_iss_controller.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/page/shared_widget/input/input_imports.dart';

class TributIssEditPage extends StatelessWidget {
	TributIssEditPage({Key? key}) : super(key: key);
	final tributIssController = Get.find<TributIssController>();

	@override
	Widget build(BuildContext context) {
return KeyboardListener(
      autofocus: false,
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event.logicalKey == LogicalKeyboardKey.escape) {
					tributIssController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: tributIssController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tribut Iss - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: tributIssController.save),
						cancelAndExitButton(onPressed: tributIssController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: tributIssController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: tributIssController.scrollController,
							child: SingleChildScrollView(
								controller: tributIssController.scrollController,
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
																		controller: tributIssController.tributOperacaoFiscalModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Tribut Operacao Fiscal',
																			labelText: 'Operação Fiscal *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: tributIssController.callTributOperacaoFiscalLookup),
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
														child: CustomDropdownButtonFormField(
															value: tributIssController.tributIssModel.modalidadeBaseCalculo ?? '0-Valor Operação',
															labelText: 'Modalidade Base Cálculo',
															hintText: 'Informe os dados para o campo Modalidade Base Calculo',
															items: const ['0-Valor Operação','9-Outros'],
															onChanged: (dynamic newValue) {
																tributIssController.tributIssModel.modalidadeBaseCalculo = newValue;
																tributIssController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributIssController.tributIssModel.codigoTributacao ?? 'Normal',
															labelText: 'Código Tributação',
															hintText: 'Informe os dados para o campo Codigo Tributacao',
															items: const ['Normal','Retida','Substituta','Isenta'],
															onChanged: (dynamic newValue) {
																tributIssController.tributIssModel.codigoTributacao = newValue;
																tributIssController.formWasChanged = true;
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
															controller: tributIssController.itemListaServicoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Item Lista Servico',
																labelText: 'Item Lista Servico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIssController.tributIssModel.itemListaServico = int.tryParse(text);
																tributIssController.formWasChanged = true;
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
															controller: tributIssController.porcentoBaseCalculoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porcento Base Calculo',
																labelText: 'Porcento Base Cálculo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIssController.tributIssModel.porcentoBaseCalculo = tributIssController.porcentoBaseCalculoController.numberValue;
																tributIssController.formWasChanged = true;
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
															controller: tributIssController.aliquotaPorcentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Porcento',
																labelText: 'Alíquota Porcento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIssController.tributIssModel.aliquotaPorcento = tributIssController.aliquotaPorcentoController.numberValue;
																tributIssController.formWasChanged = true;
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
															controller: tributIssController.aliquotaUnidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Unidade',
																labelText: 'Alíquota Unidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIssController.tributIssModel.aliquotaUnidade = tributIssController.aliquotaUnidadeController.numberValue;
																tributIssController.formWasChanged = true;
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
															controller: tributIssController.valorPrecoMaximoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Preco Maximo',
																labelText: 'Valor Preço Máximo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIssController.tributIssModel.valorPrecoMaximo = tributIssController.valorPrecoMaximoController.numberValue;
																tributIssController.formWasChanged = true;
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
															controller: tributIssController.valorPautaFiscalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Pauta Fiscal',
																labelText: 'Valor Pauta Fiscal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributIssController.tributIssModel.valorPautaFiscal = tributIssController.valorPautaFiscalController.numberValue;
																tributIssController.formWasChanged = true;
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
