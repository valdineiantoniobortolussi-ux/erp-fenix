import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/folha_fechamento_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FolhaFechamentoEditPage extends StatelessWidget {
	FolhaFechamentoEditPage({Key? key}) : super(key: key);
	final folhaFechamentoController = Get.find<FolhaFechamentoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					folhaFechamentoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: folhaFechamentoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Fechamento da Folha - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: folhaFechamentoController.save),
						cancelAndExitButton(onPressed: folhaFechamentoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: folhaFechamentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: folhaFechamentoController.scrollController,
							child: SingleChildScrollView(
								controller: folhaFechamentoController.scrollController,
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: folhaFechamentoController.fechamentoAtualController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fechamento Atual',
																labelText: 'Fechamento Atual',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaFechamentoController.folhaFechamentoModel.fechamentoAtual = text;
																folhaFechamentoController.formWasChanged = true;
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
															controller: folhaFechamentoController.proximoFechamentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Proximo Fechamento',
																labelText: 'Proximo Fechamento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaFechamentoController.folhaFechamentoModel.proximoFechamento = text;
																folhaFechamentoController.formWasChanged = true;
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
