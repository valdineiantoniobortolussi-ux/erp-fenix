import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ponto/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ponto/app/controller/ponto_horario_controller.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/page/shared_widget/input/input_imports.dart';

class PontoHorarioEditPage extends StatelessWidget {
	PontoHorarioEditPage({Key? key}) : super(key: key);
	final pontoHorarioController = Get.find<PontoHorarioController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					pontoHorarioController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: pontoHorarioController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Horários - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: pontoHorarioController.save),
						cancelAndExitButton(onPressed: pontoHorarioController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pontoHorarioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pontoHorarioController.scrollController,
							child: SingleChildScrollView(
								controller: pontoHorarioController.scrollController,
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
															value: pontoHorarioController.pontoHorarioModel.tipo ?? 'Fixo',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Fixo','Diário','Semanal','Mensal'],
															onChanged: (dynamic newValue) {
																pontoHorarioController.pontoHorarioModel.tipo = newValue;
																pontoHorarioController.formWasChanged = true;
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
															maxLength: 4,
															controller: pontoHorarioController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.codigo = text;
																pontoHorarioController.formWasChanged = true;
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
															controller: pontoHorarioController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.nome = text;
																pontoHorarioController.formWasChanged = true;
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
															value: pontoHorarioController.pontoHorarioModel.tipoTrabalho ?? 'Normal',
															labelText: 'Tipo Trabalho',
															hintText: 'Informe os dados para o campo Tipo Trabalho',
															items: const ['Normal','Compensação','Folga'],
															onChanged: (dynamic newValue) {
																pontoHorarioController.pontoHorarioModel.tipoTrabalho = newValue;
																pontoHorarioController.formWasChanged = true;
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
															controller: pontoHorarioController.cargaHorariaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Carga Horaria',
																labelText: 'Carga Horaria',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.cargaHoraria = text;
																pontoHorarioController.formWasChanged = true;
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
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pontoHorarioController.entrada01Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 01',
																labelText: 'Entrada 01',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.entrada01 = text;
																pontoHorarioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pontoHorarioController.saida01Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 01',
																labelText: 'Saida 01',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.saida01 = text;
																pontoHorarioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pontoHorarioController.entrada02Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 02',
																labelText: 'Entrada 02',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.entrada02 = text;
																pontoHorarioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pontoHorarioController.saida02Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 02',
																labelText: 'Saida 02',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.saida02 = text;
																pontoHorarioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pontoHorarioController.entrada03Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 03',
																labelText: 'Entrada 03',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.entrada03 = text;
																pontoHorarioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pontoHorarioController.saida03Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 03',
																labelText: 'Saida 03',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.saida03 = text;
																pontoHorarioController.formWasChanged = true;
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
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pontoHorarioController.entrada04Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 04',
																labelText: 'Entrada 04',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.entrada04 = text;
																pontoHorarioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pontoHorarioController.saida04Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 04',
																labelText: 'Saida 04',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.saida04 = text;
																pontoHorarioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pontoHorarioController.entrada05Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 05',
																labelText: 'Entrada 05',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.entrada05 = text;
																pontoHorarioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pontoHorarioController.saida05Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 05',
																labelText: 'Saida 05',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.saida05 = text;
																pontoHorarioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pontoHorarioController.horaInicioJornadaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Inicio Jornada',
																labelText: 'Hora Inicio Jornada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.horaInicioJornada = text;
																pontoHorarioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pontoHorarioController.horaFimJornadaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Fim Jornada',
																labelText: 'Hora Fim Jornada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioController.pontoHorarioModel.horaFimJornada = text;
																pontoHorarioController.formWasChanged = true;
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
