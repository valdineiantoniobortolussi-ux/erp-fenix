import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:estoque/app/page/shared_widget/shared_widget_imports.dart';
import 'package:estoque/app/controller/estoque_marca_controller.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/page/shared_widget/input/input_imports.dart';

class EstoqueMarcaEditPage extends StatelessWidget {
	EstoqueMarcaEditPage({Key? key}) : super(key: key);
	final estoqueMarcaController = Get.find<EstoqueMarcaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					estoqueMarcaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: estoqueMarcaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Marcas - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: estoqueMarcaController.save),
						cancelAndExitButton(onPressed: estoqueMarcaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: estoqueMarcaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: estoqueMarcaController.scrollController,
							child: SingleChildScrollView(
								controller: estoqueMarcaController.scrollController,
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
															controller: estoqueMarcaController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																estoqueMarcaController.estoqueMarcaModel.codigo = text;
																estoqueMarcaController.formWasChanged = true;
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
															controller: estoqueMarcaController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																estoqueMarcaController.estoqueMarcaModel.nome = text;
																estoqueMarcaController.formWasChanged = true;
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
