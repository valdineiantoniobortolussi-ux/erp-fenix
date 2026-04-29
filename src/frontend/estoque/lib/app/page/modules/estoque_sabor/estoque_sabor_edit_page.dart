import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:estoque/app/page/shared_widget/shared_widget_imports.dart';
import 'package:estoque/app/controller/estoque_sabor_controller.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/page/shared_widget/input/input_imports.dart';

class EstoqueSaborEditPage extends StatelessWidget {
	EstoqueSaborEditPage({Key? key}) : super(key: key);
	final estoqueSaborController = Get.find<EstoqueSaborController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					estoqueSaborController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: estoqueSaborController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Sabores - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: estoqueSaborController.save),
						cancelAndExitButton(onPressed: estoqueSaborController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: estoqueSaborController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: estoqueSaborController.scrollController,
							child: SingleChildScrollView(
								controller: estoqueSaborController.scrollController,
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
															maxLength: 4,
															controller: estoqueSaborController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																estoqueSaborController.estoqueSaborModel.codigo = text;
																estoqueSaborController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-9',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: estoqueSaborController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																estoqueSaborController.estoqueSaborModel.nome = text;
																estoqueSaborController.formWasChanged = true;
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
