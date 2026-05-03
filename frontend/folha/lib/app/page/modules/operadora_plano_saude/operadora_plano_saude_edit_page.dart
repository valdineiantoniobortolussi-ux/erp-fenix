import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/operadora_plano_saude_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class OperadoraPlanoSaudeEditPage extends StatelessWidget {
	OperadoraPlanoSaudeEditPage({Key? key}) : super(key: key);
	final operadoraPlanoSaudeController = Get.find<OperadoraPlanoSaudeController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					operadoraPlanoSaudeController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: operadoraPlanoSaudeController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Operadora Plano de Saúde - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: operadoraPlanoSaudeController.save),
						cancelAndExitButton(onPressed: operadoraPlanoSaudeController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: operadoraPlanoSaudeController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: operadoraPlanoSaudeController.scrollController,
							child: SingleChildScrollView(
								controller: operadoraPlanoSaudeController.scrollController,
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
															controller: operadoraPlanoSaudeController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																operadoraPlanoSaudeController.operadoraPlanoSaudeModel.nome = text;
																operadoraPlanoSaudeController.formWasChanged = true;
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
															maxLength: 20,
															controller: operadoraPlanoSaudeController.registroAnsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Registro Ans',
																labelText: 'Registro Ans',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																operadoraPlanoSaudeController.operadoraPlanoSaudeModel.registroAns = text;
																operadoraPlanoSaudeController.formWasChanged = true;
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
															maxLength: 30,
															controller: operadoraPlanoSaudeController.classificacaoContabilContaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Classificacao Contabil Conta',
																labelText: 'Conta Contabil',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																operadoraPlanoSaudeController.operadoraPlanoSaudeModel.classificacaoContabilConta = text;
																operadoraPlanoSaudeController.formWasChanged = true;
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
