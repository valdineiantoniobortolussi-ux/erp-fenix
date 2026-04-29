import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/plano_centro_resultado_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class PlanoCentroResultadoEditPage extends StatelessWidget {
	PlanoCentroResultadoEditPage({Key? key}) : super(key: key);
	final planoCentroResultadoController = Get.find<PlanoCentroResultadoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					planoCentroResultadoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: planoCentroResultadoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Plano Centro Resultado - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: planoCentroResultadoController.save),
						cancelAndExitButton(onPressed: planoCentroResultadoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: planoCentroResultadoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: planoCentroResultadoController.scrollController,
							child: SingleChildScrollView(
								controller: planoCentroResultadoController.scrollController,
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
															controller: planoCentroResultadoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Fill with the Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																planoCentroResultadoController.planoCentroResultadoModel.nome = text;
																planoCentroResultadoController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: planoCentroResultadoController.mascaraController,
															decoration: inputDecoration(
																hintText: 'Fill with the Mascara',
																labelText: 'Mascara',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																planoCentroResultadoController.planoCentroResultadoModel.mascara = text;
																planoCentroResultadoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-5',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: planoCentroResultadoController.niveisController,
															decoration: inputDecoration(
																hintText: 'Fill with the Niveis',
																labelText: 'Niveis',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																planoCentroResultadoController.planoCentroResultadoModel.niveis = int.tryParse(text);
																planoCentroResultadoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Fill with the Data Inclusao',
																labelText: 'Data Inclusao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: planoCentroResultadoController.planoCentroResultadoModel.dataInclusao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	planoCentroResultadoController.planoCentroResultadoModel.dataInclusao = value;
																	planoCentroResultadoController.formWasChanged = true;
																},
															),
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
