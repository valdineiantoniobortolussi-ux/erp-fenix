import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/plano_conta_ref_sped_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class PlanoContaRefSpedEditPage extends StatelessWidget {
	PlanoContaRefSpedEditPage({Key? key}) : super(key: key);
	final planoContaRefSpedController = Get.find<PlanoContaRefSpedController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					planoContaRefSpedController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: planoContaRefSpedController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Planos de Contas Sped - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: planoContaRefSpedController.save),
						cancelAndExitButton(onPressed: planoContaRefSpedController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: planoContaRefSpedController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: planoContaRefSpedController.scrollController,
							child: SingleChildScrollView(
								controller: planoContaRefSpedController.scrollController,
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 30,
															controller: planoContaRefSpedController.codCtaRefController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cod Cta Ref',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																planoContaRefSpedController.planoContaRefSpedModel.codCtaRef = text;
																planoContaRefSpedController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Inicio Validade',
																labelText: 'Inicio Validade',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: planoContaRefSpedController.planoContaRefSpedModel.inicioValidade,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	planoContaRefSpedController.planoContaRefSpedModel.inicioValidade = value;
																	planoContaRefSpedController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fim Validade',
																labelText: 'Fim Validade',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: planoContaRefSpedController.planoContaRefSpedModel.fimValidade,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	planoContaRefSpedController.planoContaRefSpedModel.fimValidade = value;
																	planoContaRefSpedController.formWasChanged = true;
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
															value: planoContaRefSpedController.planoContaRefSpedModel.tipo ?? 'Sintética',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Sintética','Analítica'],
															onChanged: (dynamic newValue) {
																planoContaRefSpedController.planoContaRefSpedModel.tipo = newValue;
																planoContaRefSpedController.formWasChanged = true;
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
															controller: planoContaRefSpedController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																planoContaRefSpedController.planoContaRefSpedModel.descricao = text;
																planoContaRefSpedController.formWasChanged = true;
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
															controller: planoContaRefSpedController.orientacoesController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Orientacoes',
																labelText: 'Orientacoes',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																planoContaRefSpedController.planoContaRefSpedModel.orientacoes = text;
																planoContaRefSpedController.formWasChanged = true;
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
