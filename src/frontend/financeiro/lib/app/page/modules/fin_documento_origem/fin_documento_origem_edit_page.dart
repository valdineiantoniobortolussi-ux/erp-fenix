import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro/app/controller/fin_documento_origem_controller.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/page/shared_widget/input/input_imports.dart';

class FinDocumentoOrigemEditPage extends StatelessWidget {
	FinDocumentoOrigemEditPage({Key? key}) : super(key: key);
	final finDocumentoOrigemController = Get.find<FinDocumentoOrigemController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					finDocumentoOrigemController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: finDocumentoOrigemController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Documento Origem - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: finDocumentoOrigemController.save),
						cancelAndExitButton(onPressed: finDocumentoOrigemController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: finDocumentoOrigemController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: finDocumentoOrigemController.scrollController,
							child: SingleChildScrollView(
								controller: finDocumentoOrigemController.scrollController,
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
															maxLength: 3,
															controller: finDocumentoOrigemController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finDocumentoOrigemController.finDocumentoOrigemModel.codigo = text;
																finDocumentoOrigemController.formWasChanged = true;
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
															maxLength: 10,
															controller: finDocumentoOrigemController.siglaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Sigla',
																labelText: 'Sigla',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finDocumentoOrigemController.finDocumentoOrigemModel.sigla = text;
																finDocumentoOrigemController.formWasChanged = true;
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
															controller: finDocumentoOrigemController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finDocumentoOrigemController.finDocumentoOrigemModel.descricao = text;
																finDocumentoOrigemController.formWasChanged = true;
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
