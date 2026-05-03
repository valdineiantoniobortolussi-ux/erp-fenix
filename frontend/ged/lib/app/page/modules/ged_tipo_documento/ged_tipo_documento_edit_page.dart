import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ged/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ged/app/controller/ged_tipo_documento_controller.dart';
import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/page/shared_widget/input/input_imports.dart';

class GedTipoDocumentoEditPage extends StatelessWidget {
	GedTipoDocumentoEditPage({Key? key}) : super(key: key);
	final gedTipoDocumentoController = Get.find<GedTipoDocumentoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					gedTipoDocumentoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: gedTipoDocumentoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tipo Documento - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: gedTipoDocumentoController.save),
						cancelAndExitButton(onPressed: gedTipoDocumentoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: gedTipoDocumentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: gedTipoDocumentoController.scrollController,
							child: SingleChildScrollView(
								controller: gedTipoDocumentoController.scrollController,
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
													sizes: 'col-12 col-md-10',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: gedTipoDocumentoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gedTipoDocumentoController.gedTipoDocumentoModel.nome = text;
																gedTipoDocumentoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: gedTipoDocumentoController.tamanhoMaximoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Tamanho Maximo',
																labelText: 'Tamanho Maximo (MB)',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gedTipoDocumentoController.gedTipoDocumentoModel.tamanhoMaximo = gedTipoDocumentoController.tamanhoMaximoController.numberValue;
																gedTipoDocumentoController.formWasChanged = true;
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
