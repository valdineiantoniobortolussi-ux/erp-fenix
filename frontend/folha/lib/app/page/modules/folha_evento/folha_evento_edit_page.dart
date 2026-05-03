import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/folha_evento_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FolhaEventoEditPage extends StatelessWidget {
	FolhaEventoEditPage({Key? key}) : super(key: key);
	final folhaEventoController = Get.find<FolhaEventoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					folhaEventoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: folhaEventoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Eventos - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: folhaEventoController.save),
						cancelAndExitButton(onPressed: folhaEventoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: folhaEventoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: folhaEventoController.scrollController,
							child: SingleChildScrollView(
								controller: folhaEventoController.scrollController,
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
															controller: folhaEventoController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaEventoController.folhaEventoModel.codigo = text;
																folhaEventoController.formWasChanged = true;
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
															maxLength: 100,
															controller: folhaEventoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaEventoController.folhaEventoModel.nome = text;
																folhaEventoController.formWasChanged = true;
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
															controller: folhaEventoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaEventoController.folhaEventoModel.descricao = text;
																folhaEventoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: folhaEventoController.folhaEventoModel.baseCalculo ?? '1=Salário contratual: define que a base de cálculo deve ser calculada sobre o valor do salário contratual',
															labelText: 'Base Calculo',
															hintText: 'Informe os dados para o campo Base Calculo',
															items: const ['1=Salário contratual: define que a base de cálculo deve ser calculada sobre o valor do salário contratual','2=Salário mínimo: define que a base de cálculo deve ser calculada sobre o valor do salário mínimo','3=Piso Salarial: define que a base de cálculo deve ser calculada sobre o valor do piso salarial definido no cadastro de sindicatos','4=Líquido: define que a base de cálculo deve ser calculada sobre o líquido da folha'],
															onChanged: (dynamic newValue) {
																folhaEventoController.folhaEventoModel.baseCalculo = newValue;
																folhaEventoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaEventoController.folhaEventoModel.tipo ?? 'Provento',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Provento','Desconto'],
															onChanged: (dynamic newValue) {
																folhaEventoController.folhaEventoModel.tipo = newValue;
																folhaEventoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaEventoController.folhaEventoModel.unidade ?? 'Valor',
															labelText: 'Unidade',
															hintText: 'Informe os dados para o campo Unidade',
															items: const ['Valor','Percentual'],
															onChanged: (dynamic newValue) {
																folhaEventoController.folhaEventoModel.unidade = newValue;
																folhaEventoController.formWasChanged = true;
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
															controller: folhaEventoController.taxaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Taxa',
																labelText: 'Taxa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaEventoController.folhaEventoModel.taxa = folhaEventoController.taxaController.numberValue;
																folhaEventoController.formWasChanged = true;
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
