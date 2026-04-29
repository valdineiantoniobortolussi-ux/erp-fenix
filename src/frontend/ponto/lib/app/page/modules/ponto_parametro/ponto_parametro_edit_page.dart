import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ponto/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ponto/app/controller/ponto_parametro_controller.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/page/shared_widget/input/input_imports.dart';

class PontoParametroEditPage extends StatelessWidget {
	PontoParametroEditPage({Key? key}) : super(key: key);
	final pontoParametroController = Get.find<PontoParametroController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					pontoParametroController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: pontoParametroController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Parâmetros - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: pontoParametroController.save),
						cancelAndExitButton(onPressed: pontoParametroController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pontoParametroController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pontoParametroController.scrollController,
							child: SingleChildScrollView(
								controller: pontoParametroController.scrollController,
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
															controller: pontoParametroController.mesAnoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Mes Ano',
																labelText: 'Mes Ano',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoParametroController.pontoParametroModel.mesAno = text;
																pontoParametroController.formWasChanged = true;
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
															controller: pontoParametroController.diaInicialApuracaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dia Inicial Apuracao',
																labelText: 'Dia Inicial Apuracao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoParametroController.pontoParametroModel.diaInicialApuracao = int.tryParse(text);
																pontoParametroController.formWasChanged = true;
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
															controller: pontoParametroController.horaNoturnaInicioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Noturna Inicio',
																labelText: 'Hora Noturna Inicio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoParametroController.pontoParametroModel.horaNoturnaInicio = text;
																pontoParametroController.formWasChanged = true;
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
															controller: pontoParametroController.horaNoturnaFimController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Noturna Fim',
																labelText: 'Hora Noturna Fim',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoParametroController.pontoParametroModel.horaNoturnaFim = text;
																pontoParametroController.formWasChanged = true;
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
															controller: pontoParametroController.periodoMinimoInterjornadaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Periodo Minimo Interjornada',
																labelText: 'Periodo Minimo Interjornada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoParametroController.pontoParametroModel.periodoMinimoInterjornada = text;
																pontoParametroController.formWasChanged = true;
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
															controller: pontoParametroController.percentualHeDiurnaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual He Diurna',
																labelText: 'Percentual He Diurna',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoParametroController.pontoParametroModel.percentualHeDiurna = pontoParametroController.percentualHeDiurnaController.numberValue;
																pontoParametroController.formWasChanged = true;
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
															controller: pontoParametroController.percentualHeNoturnaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual He Noturna',
																labelText: 'Percentual He Noturna',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoParametroController.pontoParametroModel.percentualHeNoturna = pontoParametroController.percentualHeNoturnaController.numberValue;
																pontoParametroController.formWasChanged = true;
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
															controller: pontoParametroController.duracaoHoraNoturnaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Duracao Hora Noturna',
																labelText: 'Duracao Hora Noturna',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoParametroController.pontoParametroModel.duracaoHoraNoturna = text;
																pontoParametroController.formWasChanged = true;
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
															value: pontoParametroController.pontoParametroModel.tratamentoHoraMais ?? 'Extra',
															labelText: 'Tratamento Hora Mais',
															hintText: 'Informe os dados para o campo Tratamento Hora Mais',
															items: const ['Extra','Banco Horas'],
															onChanged: (dynamic newValue) {
																pontoParametroController.pontoParametroModel.tratamentoHoraMais = newValue;
																pontoParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pontoParametroController.pontoParametroModel.tratamentoHoraMenos ?? 'Falta',
															labelText: 'Tratamento Hora Menos',
															hintText: 'Informe os dados para o campo Tratamento Hora Menos',
															items: const ['Falta','Banco Horas'],
															onChanged: (dynamic newValue) {
																pontoParametroController.pontoParametroModel.tratamentoHoraMenos = newValue;
																pontoParametroController.formWasChanged = true;
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
