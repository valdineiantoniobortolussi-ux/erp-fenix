import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/plano_conta_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class PlanoContaEditPage extends StatelessWidget {
	PlanoContaEditPage({Key? key}) : super(key: key);
	final planoContaController = Get.find<PlanoContaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					planoContaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: planoContaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Plano de Contas - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: planoContaController.save),
						cancelAndExitButton(onPressed: planoContaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: planoContaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: planoContaController.scrollController,
							child: SingleChildScrollView(
								controller: planoContaController.scrollController,
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
															controller: planoContaController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																planoContaController.planoContaModel.nome = text;
																planoContaController.formWasChanged = true;
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
													sizes: 'col-12 col-md-5',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Inclusao',
																labelText: 'Data Inclusao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: planoContaController.planoContaModel.dataInclusao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	planoContaController.planoContaModel.dataInclusao = value;
																	planoContaController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-5',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: planoContaController.mascaraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Mascara',
																labelText: 'Mascara',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																planoContaController.planoContaModel.mascara = text;
																planoContaController.formWasChanged = true;
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
															controller: planoContaController.niveisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Niveis',
																labelText: 'Niveis',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																planoContaController.planoContaModel.niveis = int.tryParse(text);
																planoContaController.formWasChanged = true;
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
