import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:patrimonio/app/page/shared_widget/shared_widget_imports.dart';
import 'package:patrimonio/app/controller/patrim_taxa_depreciacao_controller.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/page/shared_widget/input/input_imports.dart';

class PatrimTaxaDepreciacaoEditPage extends StatelessWidget {
	PatrimTaxaDepreciacaoEditPage({Key? key}) : super(key: key);
	final patrimTaxaDepreciacaoController = Get.find<PatrimTaxaDepreciacaoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					patrimTaxaDepreciacaoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: patrimTaxaDepreciacaoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Taxas de Depreciação - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: patrimTaxaDepreciacaoController.save),
						cancelAndExitButton(onPressed: patrimTaxaDepreciacaoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: patrimTaxaDepreciacaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: patrimTaxaDepreciacaoController.scrollController,
							child: SingleChildScrollView(
								controller: patrimTaxaDepreciacaoController.scrollController,
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
														child: TextFormField(
															autofocus: true,
															maxLength: 8,
															controller: patrimTaxaDepreciacaoController.ncmController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ncm',
																labelText: 'NCM',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimTaxaDepreciacaoController.patrimTaxaDepreciacaoModel.ncm = text;
																patrimTaxaDepreciacaoController.formWasChanged = true;
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
															controller: patrimTaxaDepreciacaoController.bemController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Bem',
																labelText: 'Bem',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimTaxaDepreciacaoController.patrimTaxaDepreciacaoModel.bem = text;
																patrimTaxaDepreciacaoController.formWasChanged = true;
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
															controller: patrimTaxaDepreciacaoController.vidaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Vida',
																labelText: 'Vida',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimTaxaDepreciacaoController.patrimTaxaDepreciacaoModel.vida = patrimTaxaDepreciacaoController.vidaController.numberValue;
																patrimTaxaDepreciacaoController.formWasChanged = true;
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
															controller: patrimTaxaDepreciacaoController.taxaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa',
																labelText: 'Taxa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimTaxaDepreciacaoController.patrimTaxaDepreciacaoModel.taxa = patrimTaxaDepreciacaoController.taxaController.numberValue;
																patrimTaxaDepreciacaoController.formWasChanged = true;
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
