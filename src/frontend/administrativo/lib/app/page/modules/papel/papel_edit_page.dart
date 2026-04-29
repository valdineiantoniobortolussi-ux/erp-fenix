import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:administrativo/app/controller/papel_controller.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/page/shared_widget/input/input_imports.dart';

class PapelEditPage extends StatelessWidget {
	PapelEditPage({Key? key}) : super(key: key);
	final papelController = Get.find<PapelController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: papelController.papelScaffoldKey,
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: papelController.papelFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: papelController.scrollController,
							child: SingleChildScrollView(
								controller: papelController.scrollController,
								child: BootstrapContainer(
									fluid: true,
									padding: const EdgeInsets.all(10),
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
															controller: papelController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																papelController.currentModel.nome = text;
																papelController.formWasChanged = true;
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
															controller: papelController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descrição',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																papelController.currentModel.descricao = text;
																papelController.formWasChanged = true;
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
			);
	}
}
