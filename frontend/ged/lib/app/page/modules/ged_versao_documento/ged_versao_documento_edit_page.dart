import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ged/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ged/app/controller/ged_versao_documento_controller.dart';
import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/page/shared_widget/input/input_imports.dart';

class GedVersaoDocumentoEditPage extends StatelessWidget {
	GedVersaoDocumentoEditPage({Key? key}) : super(key: key);
	final gedVersaoDocumentoController = Get.find<GedVersaoDocumentoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					gedVersaoDocumentoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: gedVersaoDocumentoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Versionamento - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: gedVersaoDocumentoController.save),
						cancelAndExitButton(onPressed: gedVersaoDocumentoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: gedVersaoDocumentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: gedVersaoDocumentoController.scrollController,
							child: SingleChildScrollView(
								controller: gedVersaoDocumentoController.scrollController,
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
																		controller: gedVersaoDocumentoController.gedDocumentoDetalheModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Documento',
																			labelText: 'Documento *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: gedVersaoDocumentoController.callGedDocumentoDetalheLookup),
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: gedVersaoDocumentoController.viewPessoaColaboradorModelController,
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
																child: lookupButton(onPressed: gedVersaoDocumentoController.callViewPessoaColaboradorLookup),
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
															value: gedVersaoDocumentoController.gedVersaoDocumentoModel.acao ?? 'Incluído',
															labelText: 'Acao',
															hintText: 'Informe os dados para o campo Acao',
															items: const ['Incluído','Alterado','Excluído'],
															onChanged: (dynamic newValue) {
																gedVersaoDocumentoController.gedVersaoDocumentoModel.acao = newValue;
																gedVersaoDocumentoController.formWasChanged = true;
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
															controller: gedVersaoDocumentoController.versaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Versao',
																labelText: 'Versao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gedVersaoDocumentoController.gedVersaoDocumentoModel.versao = int.tryParse(text);
																gedVersaoDocumentoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Versao',
																labelText: 'Data Versao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: gedVersaoDocumentoController.gedVersaoDocumentoModel.dataVersao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	gedVersaoDocumentoController.gedVersaoDocumentoModel.dataVersao = value;
																	gedVersaoDocumentoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: gedVersaoDocumentoController.horaVersaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Versao',
																labelText: 'Hora Versao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gedVersaoDocumentoController.gedVersaoDocumentoModel.horaVersao = text;
																gedVersaoDocumentoController.formWasChanged = true;
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
															maxLength: 250,
															controller: gedVersaoDocumentoController.hashArquivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hash Arquivo',
																labelText: 'Hash Arquivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gedVersaoDocumentoController.gedVersaoDocumentoModel.hashArquivo = text;
																gedVersaoDocumentoController.formWasChanged = true;
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
															maxLength: 250,
															controller: gedVersaoDocumentoController.caminhoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Caminho',
																labelText: 'Caminho',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gedVersaoDocumentoController.gedVersaoDocumentoModel.caminho = text;
																gedVersaoDocumentoController.formWasChanged = true;
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
