import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:agenda/app/page/shared_widget/shared_widget_imports.dart';
import 'package:agenda/app/controller/reuniao_sala_controller.dart';
import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/page/shared_widget/input/input_imports.dart';

class ReuniaoSalaEditPage extends StatelessWidget {
	ReuniaoSalaEditPage({Key? key}) : super(key: key);
	final reuniaoSalaController = Get.find<ReuniaoSalaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					reuniaoSalaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: reuniaoSalaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Sala de Reunião - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: reuniaoSalaController.save),
						cancelAndExitButton(onPressed: reuniaoSalaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: reuniaoSalaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: reuniaoSalaController.scrollController,
							child: SingleChildScrollView(
								controller: reuniaoSalaController.scrollController,
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
															controller: reuniaoSalaController.predioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Predio',
																labelText: 'Predio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																reuniaoSalaController.reuniaoSalaModel.predio = text;
																reuniaoSalaController.formWasChanged = true;
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
															controller: reuniaoSalaController.nomeController,
															decoration: inputDecoration(
																hintText: 'Fill with the Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																reuniaoSalaController.reuniaoSalaModel.nome = text;
																reuniaoSalaController.formWasChanged = true;
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
															maxLength: 10,
															controller: reuniaoSalaController.andarController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Andar',
																labelText: 'Andar',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																reuniaoSalaController.reuniaoSalaModel.andar = text;
																reuniaoSalaController.formWasChanged = true;
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
															controller: reuniaoSalaController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																reuniaoSalaController.reuniaoSalaModel.numero = text;
																reuniaoSalaController.formWasChanged = true;
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
