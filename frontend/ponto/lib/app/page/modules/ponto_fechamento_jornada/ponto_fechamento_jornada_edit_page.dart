import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ponto/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ponto/app/controller/ponto_fechamento_jornada_controller.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/page/shared_widget/input/input_imports.dart';

class PontoFechamentoJornadaEditPage extends StatelessWidget {
	PontoFechamentoJornadaEditPage({Key? key}) : super(key: key);
	final pontoFechamentoJornadaController = Get.find<PontoFechamentoJornadaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					pontoFechamentoJornadaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: pontoFechamentoJornadaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Fechamento da Jornada - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: pontoFechamentoJornadaController.save),
						cancelAndExitButton(onPressed: pontoFechamentoJornadaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pontoFechamentoJornadaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pontoFechamentoJornadaController.scrollController,
							child: SingleChildScrollView(
								controller: pontoFechamentoJornadaController.scrollController,
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: pontoFechamentoJornadaController.pontoClassificacaoJornadaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Classificação Jornada',
																			labelText: 'Classificação Jornada *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: pontoFechamentoJornadaController.callPontoClassificacaoJornadaLookup),
															),
														],
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: pontoFechamentoJornadaController.viewPessoaColaboradorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Colaborador',
																			labelText: 'Colaborador *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: pontoFechamentoJornadaController.callViewPessoaColaboradorLookup),
															),
														],
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Fechamento',
																labelText: 'Data Fechamento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pontoFechamentoJornadaController.pontoFechamentoJornadaModel.dataFechamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pontoFechamentoJornadaController.pontoFechamentoJornadaModel.dataFechamento = value;
																	pontoFechamentoJornadaController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pontoFechamentoJornadaController.pontoFechamentoJornadaModel.diaSemana ?? 'DOMINGO',
															labelText: 'Dia Semana',
															hintText: 'Informe os dados para o campo Dia Semana',
															items: const ['DOMINGO','SEGUNDA','TERCA','QUARTA','QUINTA','SEXTA','SABADO'],
															onChanged: (dynamic newValue) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.diaSemana = newValue;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.codigoHorarioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Horario',
																labelText: 'Codigo Horario',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.codigoHorario = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.cargaHorariaEsperadaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Carga Horaria Esperada',
																labelText: 'Carga Horaria Esperada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.cargaHorariaEsperada = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.cargaHorariaDiurnaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Carga Horaria Diurna',
																labelText: 'Carga Horaria Diurna',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.cargaHorariaDiurna = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.cargaHorariaNoturnaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Carga Horaria Noturna',
																labelText: 'Carga Horaria Noturna',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.cargaHorariaNoturna = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.cargaHorariaTotalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Carga Horaria Total',
																labelText: 'Carga Horaria Total',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.cargaHorariaTotal = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.entrada01Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 01',
																labelText: 'Entrada 01',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.entrada01 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.saida01Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 01',
																labelText: 'Saida 01',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.saida01 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.entrada02Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 02',
																labelText: 'Entrada 02',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.entrada02 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.saida02Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 02',
																labelText: 'Saida 02',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.saida02 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.entrada03Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 03',
																labelText: 'Entrada 03',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.entrada03 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.saida03Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 03',
																labelText: 'Saida 03',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.saida03 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.entrada04Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 04',
																labelText: 'Entrada 04',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.entrada04 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.saida04Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 04',
																labelText: 'Saida 04',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.saida04 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.entrada05Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 05',
																labelText: 'Entrada 05',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.entrada05 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.saida05Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 05',
																labelText: 'Saida 05',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.saida05 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.horaInicioJornadaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Inicio Jornada',
																labelText: 'Hora Inicio Jornada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.horaInicioJornada = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.horaFimJornadaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Fim Jornada',
																labelText: 'Hora Fim Jornada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.horaFimJornada = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: pontoFechamentoJornadaController.horaExtra01Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Extra 01',
																labelText: 'Hora Extra 01',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.horaExtra01 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.percentualHoraExtra01Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Hora Extra 01',
																labelText: 'Percentual Hora Extra 01',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.percentualHoraExtra01 = pontoFechamentoJornadaController.percentualHoraExtra01Controller.numberValue;
																pontoFechamentoJornadaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pontoFechamentoJornadaController.pontoFechamentoJornadaModel.modalidadeHoraExtra01 ?? 'Diurna',
															labelText: 'Modalidade Hora Extra 01',
															hintText: 'Informe os dados para o campo Modalidade Hora Extra 01',
															items: const ['Diurna','Noturna'],
															onChanged: (dynamic newValue) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.modalidadeHoraExtra01 = newValue;
																pontoFechamentoJornadaController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: pontoFechamentoJornadaController.horaExtra02Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Extra 02',
																labelText: 'Hora Extra 02',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.horaExtra02 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.percentualHoraExtra02Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Hora Extra 02',
																labelText: 'Percentual Hora Extra 02',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.percentualHoraExtra02 = pontoFechamentoJornadaController.percentualHoraExtra02Controller.numberValue;
																pontoFechamentoJornadaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pontoFechamentoJornadaController.pontoFechamentoJornadaModel.modalidadeHoraExtra02 ?? 'Diurna',
															labelText: 'Modalidade Hora Extra 02',
															hintText: 'Informe os dados para o campo Modalidade Hora Extra 02',
															items: const ['Diurna','Noturna'],
															onChanged: (dynamic newValue) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.modalidadeHoraExtra02 = newValue;
																pontoFechamentoJornadaController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: pontoFechamentoJornadaController.horaExtra03Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Extra 03',
																labelText: 'Hora Extra 03',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.horaExtra03 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.percentualHoraExtra03Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Hora Extra 03',
																labelText: 'Percentual Hora Extra 03',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.percentualHoraExtra03 = pontoFechamentoJornadaController.percentualHoraExtra03Controller.numberValue;
																pontoFechamentoJornadaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pontoFechamentoJornadaController.pontoFechamentoJornadaModel.modalidadeHoraExtra03 ?? 'Diurna',
															labelText: 'Modalidade Hora Extra 03',
															hintText: 'Informe os dados para o campo Modalidade Hora Extra 03',
															items: const ['Diurna','Noturna'],
															onChanged: (dynamic newValue) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.modalidadeHoraExtra03 = newValue;
																pontoFechamentoJornadaController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: pontoFechamentoJornadaController.horaExtra04Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Extra 04',
																labelText: 'Hora Extra 04',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.horaExtra04 = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.percentualHoraExtra04Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Hora Extra 04',
																labelText: 'Percentual Hora Extra 04',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.percentualHoraExtra04 = pontoFechamentoJornadaController.percentualHoraExtra04Controller.numberValue;
																pontoFechamentoJornadaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pontoFechamentoJornadaController.pontoFechamentoJornadaModel.modalidadeHoraExtra04 ?? 'Diurna',
															labelText: 'Modalidade Hora Extra 04',
															hintText: 'Informe os dados para o campo Modalidade Hora Extra 04',
															items: const ['Diurna','Noturna'],
															onChanged: (dynamic newValue) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.modalidadeHoraExtra04 = newValue;
																pontoFechamentoJornadaController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: pontoFechamentoJornadaController.faltaAtrasoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Falta Atraso',
																labelText: 'Falta Atraso',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.faltaAtraso = text;
																pontoFechamentoJornadaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pontoFechamentoJornadaController.pontoFechamentoJornadaModel.compensar ?? 'Horas a mais',
															labelText: 'Compensar',
															hintText: 'Informe os dados para o campo Compensar',
															items: const ['Horas a mais','Horas a menos'],
															onChanged: (dynamic newValue) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.compensar = newValue;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															controller: pontoFechamentoJornadaController.bancoHorasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Banco Horas',
																labelText: 'Banco Horas',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.bancoHoras = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
															maxLines: 3,
															controller: pontoFechamentoJornadaController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoFechamentoJornadaController.pontoFechamentoJornadaModel.observacao = text;
																pontoFechamentoJornadaController.formWasChanged = true;
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
