import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ged/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ged/app/controller/ged_documento_detalhe_controller.dart';
import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/page/shared_widget/input/input_imports.dart';

class GedDocumentoDetalheEditPage extends StatelessWidget {
	GedDocumentoDetalheEditPage({Key? key}) : super(key: key);
	final gedDocumentoDetalheController = Get.find<GedDocumentoDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: gedDocumentoDetalheController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Detalhes - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: gedDocumentoDetalheController.save),
						cancelAndExitButton(onPressed: gedDocumentoDetalheController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: gedDocumentoDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: gedDocumentoDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: gedDocumentoDetalheController.scrollController,
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
																		controller: gedDocumentoDetalheController.gedTipoDocumentoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Ged Tipo Documento',
																			labelText: 'Tipo Documento *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: gedDocumentoDetalheController.callGedTipoDocumentoLookup),
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
															maxLength: 100,
															controller: gedDocumentoDetalheController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gedDocumentoDetalheController.gedDocumentoDetalheModel.nome = text;
																gedDocumentoDetalheController.formWasChanged = true;
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
															controller: gedDocumentoDetalheController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gedDocumentoDetalheController.gedDocumentoDetalheModel.descricao = text;
																gedDocumentoDetalheController.formWasChanged = true;
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
															controller: gedDocumentoDetalheController.palavrasChaveController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Palavras Chave',
																labelText: 'Palavras Chave',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gedDocumentoDetalheController.gedDocumentoDetalheModel.palavrasChave = text;
																gedDocumentoDetalheController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: gedDocumentoDetalheController.gedDocumentoDetalheModel.podeExcluir ?? 'S',
															labelText: 'Pode Excluir',
															hintText: 'Informe os dados para o campo Pode Excluir',
															items: const ['S','N'],
															onChanged: (dynamic newValue) {
																gedDocumentoDetalheController.gedDocumentoDetalheModel.podeExcluir = newValue;
																gedDocumentoDetalheController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: gedDocumentoDetalheController.gedDocumentoDetalheModel.podeAlterar ?? 'S',
															labelText: 'Pode Alterar',
															hintText: 'Informe os dados para o campo Pode Alterar',
															items: const ['S','N'],
															onChanged: (dynamic newValue) {
																gedDocumentoDetalheController.gedDocumentoDetalheModel.podeAlterar = newValue;
																gedDocumentoDetalheController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: gedDocumentoDetalheController.gedDocumentoDetalheModel.assinado ?? 'S',
															labelText: 'Assinado',
															hintText: 'Informe os dados para o campo Assinado',
															items: const ['S','N'],
															onChanged: (dynamic newValue) {
																gedDocumentoDetalheController.gedDocumentoDetalheModel.assinado = newValue;
																gedDocumentoDetalheController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Fim Vigencia',
																labelText: 'Data Fim Vigencia',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: gedDocumentoDetalheController.gedDocumentoDetalheModel.dataFimVigencia,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	gedDocumentoDetalheController.gedDocumentoDetalheModel.dataFimVigencia = value;
																	gedDocumentoDetalheController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Exclusao',
																labelText: 'Data Exclusao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: gedDocumentoDetalheController.gedDocumentoDetalheModel.dataExclusao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	gedDocumentoDetalheController.gedDocumentoDetalheModel.dataExclusao = value;
																	gedDocumentoDetalheController.formWasChanged = true;
																},
															),
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
