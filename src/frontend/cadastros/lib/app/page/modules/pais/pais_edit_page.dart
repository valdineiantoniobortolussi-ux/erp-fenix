import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/pais_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class PaisEditPage extends StatelessWidget {
	PaisEditPage({Key? key}) : super(key: key);
	final paisController = Get.find<PaisController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					paisController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: paisController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('País - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: paisController.save),
						cancelAndExitButton(onPressed: paisController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: paisController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: paisController.scrollController,
							child: SingleChildScrollView(
								controller: paisController.scrollController,
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
															maxLength: 100,
															controller: paisController.nomePtbrController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Português',
																labelText: 'Nome Português',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																paisController.paisModel.nomePtbr = text;
																paisController.formWasChanged = true;
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
															controller: paisController.nomeEnController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Inglês',
																labelText: 'Nome Inglês',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																paisController.paisModel.nomeEn = text;
																paisController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: paisController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																paisController.paisModel.codigo = int.tryParse(text);
																paisController.formWasChanged = true;
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
															maxLength: 2,
															controller: paisController.sigla2Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Sigla 2 Caracteres',
																labelText: 'Sigla 2 Caracteres',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																paisController.paisModel.sigla2 = text;
																paisController.formWasChanged = true;
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
															maxLength: 3,
															controller: paisController.sigla3Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Sigla 3 Caracteres',
																labelText: 'Sigla 3 Caracteres',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																paisController.paisModel.sigla3 = text;
																paisController.formWasChanged = true;
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
															controller: paisController.codigoBacenController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Bacen',
																labelText: 'Codigo Bacen',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																paisController.paisModel.codigoBacen = int.tryParse(text);
																paisController.formWasChanged = true;
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
