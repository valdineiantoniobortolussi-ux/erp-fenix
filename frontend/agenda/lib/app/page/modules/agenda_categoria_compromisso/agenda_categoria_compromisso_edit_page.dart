import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:agenda/app/page/shared_widget/shared_widget_imports.dart';
import 'package:agenda/app/controller/agenda_categoria_compromisso_controller.dart';
import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/page/shared_widget/input/input_imports.dart';

class AgendaCategoriaCompromissoEditPage extends StatelessWidget {
	AgendaCategoriaCompromissoEditPage({Key? key}) : super(key: key);
	final agendaCategoriaCompromissoController = Get.find<AgendaCategoriaCompromissoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					agendaCategoriaCompromissoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: agendaCategoriaCompromissoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Categoria Compromisso - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: agendaCategoriaCompromissoController.save),
						cancelAndExitButton(onPressed: agendaCategoriaCompromissoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: agendaCategoriaCompromissoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: agendaCategoriaCompromissoController.scrollController,
							child: SingleChildScrollView(
								controller: agendaCategoriaCompromissoController.scrollController,
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
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: agendaCategoriaCompromissoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																agendaCategoriaCompromissoController.agendaCategoriaCompromissoModel.nome = text;
																agendaCategoriaCompromissoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: agendaCategoriaCompromissoController.corController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cor',
																labelText: 'Cor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																agendaCategoriaCompromissoController.agendaCategoriaCompromissoModel.cor = text;
																agendaCategoriaCompromissoController.formWasChanged = true;
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
