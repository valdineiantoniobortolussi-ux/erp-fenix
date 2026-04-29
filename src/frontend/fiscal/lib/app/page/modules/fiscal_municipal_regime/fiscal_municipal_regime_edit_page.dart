import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:fiscal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:fiscal/app/controller/fiscal_municipal_regime_controller.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/page/shared_widget/input/input_imports.dart';

class FiscalMunicipalRegimeEditPage extends StatelessWidget {
	FiscalMunicipalRegimeEditPage({Key? key}) : super(key: key);
	final fiscalMunicipalRegimeController = Get.find<FiscalMunicipalRegimeController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					fiscalMunicipalRegimeController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: fiscalMunicipalRegimeController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Regime Municipal - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: fiscalMunicipalRegimeController.save),
						cancelAndExitButton(onPressed: fiscalMunicipalRegimeController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: fiscalMunicipalRegimeController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: fiscalMunicipalRegimeController.scrollController,
							child: SingleChildScrollView(
								controller: fiscalMunicipalRegimeController.scrollController,
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
														child: CustomDropdownButtonFormField(
															value: fiscalMunicipalRegimeController.fiscalMunicipalRegimeModel.uf ?? 'AC',
															labelText: 'Uf',
															hintText: 'Informe os dados para o campo Uf',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																fiscalMunicipalRegimeController.fiscalMunicipalRegimeModel.uf = newValue;
																fiscalMunicipalRegimeController.formWasChanged = true;
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
															maxLength: 20,
															controller: fiscalMunicipalRegimeController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalMunicipalRegimeController.fiscalMunicipalRegimeModel.codigo = text;
																fiscalMunicipalRegimeController.formWasChanged = true;
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
															maxLength: 50,
															controller: fiscalMunicipalRegimeController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalMunicipalRegimeController.fiscalMunicipalRegimeModel.nome = text;
																fiscalMunicipalRegimeController.formWasChanged = true;
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
