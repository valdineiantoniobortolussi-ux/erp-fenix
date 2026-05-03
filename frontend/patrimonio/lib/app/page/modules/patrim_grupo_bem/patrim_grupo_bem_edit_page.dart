import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:patrimonio/app/page/shared_widget/shared_widget_imports.dart';
import 'package:patrimonio/app/controller/patrim_grupo_bem_controller.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/page/shared_widget/input/input_imports.dart';

class PatrimGrupoBemEditPage extends StatelessWidget {
	PatrimGrupoBemEditPage({Key? key}) : super(key: key);
	final patrimGrupoBemController = Get.find<PatrimGrupoBemController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					patrimGrupoBemController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: patrimGrupoBemController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Grupo - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: patrimGrupoBemController.save),
						cancelAndExitButton(onPressed: patrimGrupoBemController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: patrimGrupoBemController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: patrimGrupoBemController.scrollController,
							child: SingleChildScrollView(
								controller: patrimGrupoBemController.scrollController,
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
															controller: patrimGrupoBemController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimGrupoBemController.patrimGrupoBemModel.codigo = text;
																patrimGrupoBemController.formWasChanged = true;
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
															controller: patrimGrupoBemController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimGrupoBemController.patrimGrupoBemModel.nome = text;
																patrimGrupoBemController.formWasChanged = true;
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
															controller: patrimGrupoBemController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimGrupoBemController.patrimGrupoBemModel.descricao = text;
																patrimGrupoBemController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 30,
															controller: patrimGrupoBemController.contaAtivoImobilizadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Ativo Imobilizado',
																labelText: 'Conta Ativo Imobilizado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimGrupoBemController.patrimGrupoBemModel.contaAtivoImobilizado = text;
																patrimGrupoBemController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 30,
															controller: patrimGrupoBemController.contaDepreciacaoAcumuladaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Depreciacao Acumulada',
																labelText: 'Conta Depreciacao Acumulada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimGrupoBemController.patrimGrupoBemModel.contaDepreciacaoAcumulada = text;
																patrimGrupoBemController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 30,
															controller: patrimGrupoBemController.contaDespesaDepreciacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Despesa Depreciacao',
																labelText: 'Conta Despesa Depreciacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimGrupoBemController.patrimGrupoBemModel.contaDespesaDepreciacao = text;
																patrimGrupoBemController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: patrimGrupoBemController.codigoHistoricoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Historico',
																labelText: 'Codigo Historico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimGrupoBemController.patrimGrupoBemModel.codigoHistorico = int.tryParse(text);
																patrimGrupoBemController.formWasChanged = true;
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
