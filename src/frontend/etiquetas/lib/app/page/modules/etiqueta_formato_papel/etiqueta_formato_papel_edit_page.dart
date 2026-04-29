import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:etiquetas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:etiquetas/app/controller/etiqueta_formato_papel_controller.dart';
import 'package:etiquetas/app/infra/infra_imports.dart';
import 'package:etiquetas/app/page/shared_widget/input/input_imports.dart';

class EtiquetaFormatoPapelEditPage extends StatelessWidget {
	EtiquetaFormatoPapelEditPage({Key? key}) : super(key: key);
	final etiquetaFormatoPapelController = Get.find<EtiquetaFormatoPapelController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					etiquetaFormatoPapelController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: etiquetaFormatoPapelController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Formato do Papel - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: etiquetaFormatoPapelController.save),
						cancelAndExitButton(onPressed: etiquetaFormatoPapelController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: etiquetaFormatoPapelController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: etiquetaFormatoPapelController.scrollController,
							child: SingleChildScrollView(
								controller: etiquetaFormatoPapelController.scrollController,
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
															maxLength: 50,
															controller: etiquetaFormatoPapelController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaFormatoPapelController.etiquetaFormatoPapelModel.nome = text;
																etiquetaFormatoPapelController.formWasChanged = true;
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
															controller: etiquetaFormatoPapelController.alturaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Altura',
																labelText: 'Altura',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaFormatoPapelController.etiquetaFormatoPapelModel.altura = int.tryParse(text);
																etiquetaFormatoPapelController.formWasChanged = true;
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
															controller: etiquetaFormatoPapelController.larguraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Largura',
																labelText: 'Largura',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaFormatoPapelController.etiquetaFormatoPapelModel.largura = int.tryParse(text);
																etiquetaFormatoPapelController.formWasChanged = true;
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
