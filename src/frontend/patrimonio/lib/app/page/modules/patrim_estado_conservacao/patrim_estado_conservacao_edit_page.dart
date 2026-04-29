import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:patrimonio/app/page/shared_widget/shared_widget_imports.dart';
import 'package:patrimonio/app/controller/patrim_estado_conservacao_controller.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/page/shared_widget/input/input_imports.dart';

class PatrimEstadoConservacaoEditPage extends StatelessWidget {
	PatrimEstadoConservacaoEditPage({Key? key}) : super(key: key);
	final patrimEstadoConservacaoController = Get.find<PatrimEstadoConservacaoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					patrimEstadoConservacaoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: patrimEstadoConservacaoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Estado de Conservação - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: patrimEstadoConservacaoController.save),
						cancelAndExitButton(onPressed: patrimEstadoConservacaoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: patrimEstadoConservacaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: patrimEstadoConservacaoController.scrollController,
							child: SingleChildScrollView(
								controller: patrimEstadoConservacaoController.scrollController,
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: patrimEstadoConservacaoController.patrimEstadoConservacaoModel.codigo ?? '1=Novo',
															labelText: 'Codigo',
															hintText: 'Informe os dados para o campo Codigo',
															items: const ['1=Novo','2=Bom','3=Recuperável','4=Inservível'],
															onChanged: (dynamic newValue) {
																patrimEstadoConservacaoController.patrimEstadoConservacaoModel.codigo = newValue;
																patrimEstadoConservacaoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: patrimEstadoConservacaoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimEstadoConservacaoController.patrimEstadoConservacaoModel.nome = text;
																patrimEstadoConservacaoController.formWasChanged = true;
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
															maxLines: 3,
															controller: patrimEstadoConservacaoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimEstadoConservacaoController.patrimEstadoConservacaoModel.descricao = text;
																patrimEstadoConservacaoController.formWasChanged = true;
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
