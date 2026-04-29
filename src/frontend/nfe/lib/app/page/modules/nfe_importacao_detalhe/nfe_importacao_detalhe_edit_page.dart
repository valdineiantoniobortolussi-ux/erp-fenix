import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_importacao_detalhe_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeImportacaoDetalheEditPage extends StatelessWidget {
	NfeImportacaoDetalheEditPage({Key? key}) : super(key: key);
	final nfeImportacaoDetalheController = Get.find<NfeImportacaoDetalheController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					nfeImportacaoDetalheController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: nfeImportacaoDetalheController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Importação Detalhe - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeImportacaoDetalheController.save),
						cancelAndExitButton(onPressed: nfeImportacaoDetalheController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeImportacaoDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeImportacaoDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: nfeImportacaoDetalheController.scrollController,
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
																		controller: nfeImportacaoDetalheController.nfeDeclaracaoImportacaoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Nfe Declaracao Importacao',
																			labelText: 'Id Nfe Declaracao Importacao *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: nfeImportacaoDetalheController.callNfeDeclaracaoImportacaoLookup),
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
															controller: nfeImportacaoDetalheController.numeroAdicaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Adicao',
																labelText: 'Numero Adicao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeImportacaoDetalheController.nfeImportacaoDetalheModel.numeroAdicao = int.tryParse(text);
																nfeImportacaoDetalheController.formWasChanged = true;
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
															controller: nfeImportacaoDetalheController.numeroSequencialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Sequencial',
																labelText: 'Numero Sequencial',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeImportacaoDetalheController.nfeImportacaoDetalheModel.numeroSequencial = int.tryParse(text);
																nfeImportacaoDetalheController.formWasChanged = true;
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
															controller: nfeImportacaoDetalheController.codigoFabricanteEstrangeiroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Fabricante Estrangeiro',
																labelText: 'Codigo Fabricante Estrangeiro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeImportacaoDetalheController.nfeImportacaoDetalheModel.codigoFabricanteEstrangeiro = text;
																nfeImportacaoDetalheController.formWasChanged = true;
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
															controller: nfeImportacaoDetalheController.valorDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto',
																labelText: 'Valor Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeImportacaoDetalheController.nfeImportacaoDetalheModel.valorDesconto = nfeImportacaoDetalheController.valorDescontoController.numberValue;
																nfeImportacaoDetalheController.formWasChanged = true;
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
															controller: nfeImportacaoDetalheController.drawbackController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Drawback',
																labelText: 'Drawback',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeImportacaoDetalheController.nfeImportacaoDetalheModel.drawback = int.tryParse(text);
																nfeImportacaoDetalheController.formWasChanged = true;
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
