import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:vendas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:vendas/app/controller/nota_fiscal_tipo_controller.dart';
import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/page/shared_widget/input/input_imports.dart';

class NotaFiscalTipoEditPage extends StatelessWidget {
	NotaFiscalTipoEditPage({Key? key}) : super(key: key);
	final notaFiscalTipoController = Get.find<NotaFiscalTipoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					notaFiscalTipoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: notaFiscalTipoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tipo de Nota Fiscal - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: notaFiscalTipoController.save),
						cancelAndExitButton(onPressed: notaFiscalTipoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: notaFiscalTipoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: notaFiscalTipoController.scrollController,
							child: SingleChildScrollView(
								controller: notaFiscalTipoController.scrollController,
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
																		controller: notaFiscalTipoController.notaFiscalModeloModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Nota Fiscal Modelo',
																			labelText: 'Nota Fiscal Modelo *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: notaFiscalTipoController.callNotaFiscalModeloLookup),
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
															maxLength: 50,
															controller: notaFiscalTipoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																notaFiscalTipoController.notaFiscalTipoModel.nome = text;
																notaFiscalTipoController.formWasChanged = true;
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
															controller: notaFiscalTipoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																notaFiscalTipoController.notaFiscalTipoModel.descricao = text;
																notaFiscalTipoController.formWasChanged = true;
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
															controller: notaFiscalTipoController.serieController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Serie',
																labelText: 'Serie',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																notaFiscalTipoController.notaFiscalTipoModel.serie = text;
																notaFiscalTipoController.formWasChanged = true;
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
															maxLength: 3,
															controller: notaFiscalTipoController.serieScanController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Serie Scan',
																labelText: 'Serie Scan',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																notaFiscalTipoController.notaFiscalTipoModel.serieScan = text;
																notaFiscalTipoController.formWasChanged = true;
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
															controller: notaFiscalTipoController.ultimoNumeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ultimo Numero',
																labelText: 'Ultimo Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																notaFiscalTipoController.notaFiscalTipoModel.ultimoNumero = int.tryParse(text);
																notaFiscalTipoController.formWasChanged = true;
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
