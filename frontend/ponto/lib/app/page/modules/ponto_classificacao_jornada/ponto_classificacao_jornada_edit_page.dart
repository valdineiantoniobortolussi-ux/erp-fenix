import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ponto/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ponto/app/controller/ponto_classificacao_jornada_controller.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/page/shared_widget/input/input_imports.dart';

class PontoClassificacaoJornadaEditPage extends StatelessWidget {
	PontoClassificacaoJornadaEditPage({Key? key}) : super(key: key);
	final pontoClassificacaoJornadaController = Get.find<PontoClassificacaoJornadaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					pontoClassificacaoJornadaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: pontoClassificacaoJornadaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Classificação da Jornada - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: pontoClassificacaoJornadaController.save),
						cancelAndExitButton(onPressed: pontoClassificacaoJornadaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pontoClassificacaoJornadaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pontoClassificacaoJornadaController.scrollController,
							child: SingleChildScrollView(
								controller: pontoClassificacaoJornadaController.scrollController,
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
															maxLength: 3,
															controller: pontoClassificacaoJornadaController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoClassificacaoJornadaController.pontoClassificacaoJornadaModel.codigo = text;
																pontoClassificacaoJornadaController.formWasChanged = true;
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
															controller: pontoClassificacaoJornadaController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoClassificacaoJornadaController.pontoClassificacaoJornadaModel.nome = text;
																pontoClassificacaoJornadaController.formWasChanged = true;
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
															controller: pontoClassificacaoJornadaController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoClassificacaoJornadaController.pontoClassificacaoJornadaModel.descricao = text;
																pontoClassificacaoJornadaController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: pontoClassificacaoJornadaController.pontoClassificacaoJornadaModel.padrao ?? 'Sim',
															labelText: 'Padrao',
															hintText: 'Informe os dados para o campo Padrao',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																pontoClassificacaoJornadaController.pontoClassificacaoJornadaModel.padrao = newValue;
																pontoClassificacaoJornadaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pontoClassificacaoJornadaController.pontoClassificacaoJornadaModel.descontarHoras ?? 'Sim',
															labelText: 'Descontar Horas',
															hintText: 'Informe os dados para o campo Descontar Horas',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																pontoClassificacaoJornadaController.pontoClassificacaoJornadaModel.descontarHoras = newValue;
																pontoClassificacaoJornadaController.formWasChanged = true;
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
