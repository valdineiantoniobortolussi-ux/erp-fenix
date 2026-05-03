import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/uf_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class UfEditPage extends StatelessWidget {
	UfEditPage({Key? key}) : super(key: key);
	final ufController = Get.find<UfController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					ufController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: ufController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('UF - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: ufController.save),
						cancelAndExitButton(onPressed: ufController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: ufController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: ufController.scrollController,
							child: SingleChildScrollView(
								controller: ufController.scrollController,
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
															controller: ufController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ufController.ufModel.nome = text;
																ufController.formWasChanged = true;
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
															maxLength: 2,
															controller: ufController.siglaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Sigla',
																labelText: 'Sigla',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ufController.ufModel.sigla = text;
																ufController.formWasChanged = true;
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
															controller: ufController.codigoIbgeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo IBGE',
																labelText: 'Codigo IBGE',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ufController.ufModel.codigoIbge = int.tryParse(text);
																ufController.formWasChanged = true;
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
