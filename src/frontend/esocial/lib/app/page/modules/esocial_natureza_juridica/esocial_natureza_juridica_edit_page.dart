import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:esocial/app/page/shared_widget/shared_widget_imports.dart';
import 'package:esocial/app/controller/esocial_natureza_juridica_controller.dart';
import 'package:esocial/app/infra/infra_imports.dart';
import 'package:esocial/app/page/shared_widget/input/input_imports.dart';

class EsocialNaturezaJuridicaEditPage extends StatelessWidget {
	EsocialNaturezaJuridicaEditPage({Key? key}) : super(key: key);
	final esocialNaturezaJuridicaController = Get.find<EsocialNaturezaJuridicaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					esocialNaturezaJuridicaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: esocialNaturezaJuridicaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Natureza Jurídica - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: esocialNaturezaJuridicaController.save),
						cancelAndExitButton(onPressed: esocialNaturezaJuridicaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: esocialNaturezaJuridicaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: esocialNaturezaJuridicaController.scrollController,
							child: SingleChildScrollView(
								controller: esocialNaturezaJuridicaController.scrollController,
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
															controller: esocialNaturezaJuridicaController.grupoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Grupo',
																labelText: 'Grupo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																esocialNaturezaJuridicaController.esocialNaturezaJuridicaModel.grupo = int.tryParse(text);
																esocialNaturezaJuridicaController.formWasChanged = true;
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
															maxLength: 5,
															controller: esocialNaturezaJuridicaController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																esocialNaturezaJuridicaController.esocialNaturezaJuridicaModel.codigo = text;
																esocialNaturezaJuridicaController.formWasChanged = true;
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
															controller: esocialNaturezaJuridicaController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																esocialNaturezaJuridicaController.esocialNaturezaJuridicaModel.descricao = text;
																esocialNaturezaJuridicaController.formWasChanged = true;
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
