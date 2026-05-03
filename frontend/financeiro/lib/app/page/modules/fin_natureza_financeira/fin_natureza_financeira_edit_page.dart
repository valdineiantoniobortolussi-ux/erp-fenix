import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro/app/controller/fin_natureza_financeira_controller.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/page/shared_widget/input/input_imports.dart';

class FinNaturezaFinanceiraEditPage extends StatelessWidget {
	FinNaturezaFinanceiraEditPage({Key? key}) : super(key: key);
	final finNaturezaFinanceiraController = Get.find<FinNaturezaFinanceiraController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					finNaturezaFinanceiraController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: finNaturezaFinanceiraController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Natureza Financeira - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: finNaturezaFinanceiraController.save),
						cancelAndExitButton(onPressed: finNaturezaFinanceiraController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: finNaturezaFinanceiraController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: finNaturezaFinanceiraController.scrollController,
							child: SingleChildScrollView(
								controller: finNaturezaFinanceiraController.scrollController,
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 4,
															controller: finNaturezaFinanceiraController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finNaturezaFinanceiraController.finNaturezaFinanceiraModel.codigo = text;
																finNaturezaFinanceiraController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: finNaturezaFinanceiraController.finNaturezaFinanceiraModel.tipo ?? 'Receita',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Receita','Despesa'],
															onChanged: (dynamic newValue) {
																finNaturezaFinanceiraController.finNaturezaFinanceiraModel.tipo = newValue;
																finNaturezaFinanceiraController.formWasChanged = true;
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
															controller: finNaturezaFinanceiraController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descrição',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finNaturezaFinanceiraController.finNaturezaFinanceiraModel.descricao = text;
																finNaturezaFinanceiraController.formWasChanged = true;
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
															maxLines: 3,
															controller: finNaturezaFinanceiraController.aplicacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aplicacao',
																labelText: 'Aplicação',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finNaturezaFinanceiraController.finNaturezaFinanceiraModel.aplicacao = text;
																finNaturezaFinanceiraController.formWasChanged = true;
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
