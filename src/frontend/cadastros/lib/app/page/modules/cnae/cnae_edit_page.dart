import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/cnae_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class CnaeEditPage extends StatelessWidget {
	CnaeEditPage({Key? key}) : super(key: key);
	final cnaeController = Get.find<CnaeController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					cnaeController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: cnaeController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('CNAE - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cnaeController.save),
						cancelAndExitButton(onPressed: cnaeController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cnaeController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cnaeController.scrollController,
							child: SingleChildScrollView(
								controller: cnaeController.scrollController,
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
															maxLength: 7,
															controller: cnaeController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cnaeController.cnaeModel.codigo = text;
																cnaeController.formWasChanged = true;
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
															controller: cnaeController.denominacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Denominacao',
																labelText: 'Denominacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cnaeController.cnaeModel.denominacao = text;
																cnaeController.formWasChanged = true;
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
