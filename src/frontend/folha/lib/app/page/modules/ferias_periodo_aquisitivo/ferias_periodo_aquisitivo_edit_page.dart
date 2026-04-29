import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/ferias_periodo_aquisitivo_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FeriasPeriodoAquisitivoEditPage extends StatelessWidget {
	FeriasPeriodoAquisitivoEditPage({Key? key}) : super(key: key);
	final feriasPeriodoAquisitivoController = Get.find<FeriasPeriodoAquisitivoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					feriasPeriodoAquisitivoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: feriasPeriodoAquisitivoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Períodos Aquisitivos - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: feriasPeriodoAquisitivoController.save),
						cancelAndExitButton(onPressed: feriasPeriodoAquisitivoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: feriasPeriodoAquisitivoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: feriasPeriodoAquisitivoController.scrollController,
							child: SingleChildScrollView(
								controller: feriasPeriodoAquisitivoController.scrollController,
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
																		controller: feriasPeriodoAquisitivoController.viewPessoaColaboradorModelController,
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
																child: lookupButton(onPressed: feriasPeriodoAquisitivoController.callViewPessoaColaboradorLookup),
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Inicio',
																labelText: 'Data Inicio',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.dataInicio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.dataInicio = value;
																	feriasPeriodoAquisitivoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Fim',
																labelText: 'Data Fim',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.dataFim,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.dataFim = value;
																	feriasPeriodoAquisitivoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.situacao ?? '0=Em Aberto',
															labelText: 'Situacao',
															hintText: 'Informe os dados para o campo Situacao',
															items: const ['0=Em Aberto','1=Gozado','2=Parcialmente gozado','3=Perda por Afastamento','4=Perda por Falta','5=Cancelado'],
															onChanged: (dynamic newValue) {
																feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.situacao = newValue;
																feriasPeriodoAquisitivoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Limite Para Gozo',
																labelText: 'Limite Para Gozo',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.limiteParaGozo,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.limiteParaGozo = value;
																	feriasPeriodoAquisitivoController.formWasChanged = true;
																},
															),
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
															value: feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.descontarFaltas ?? 'Sim',
															labelText: 'Descontar Faltas',
															hintText: 'Informe os dados para o campo Descontar Faltas',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.descontarFaltas = newValue;
																feriasPeriodoAquisitivoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.desconsiderarAfastamento ?? 'Sim',
															labelText: 'Desconsiderar Afastamento',
															hintText: 'Informe os dados para o campo Desconsiderar Afastamento',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.desconsiderarAfastamento = newValue;
																feriasPeriodoAquisitivoController.formWasChanged = true;
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
															controller: feriasPeriodoAquisitivoController.afastamentoPrevidenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Afastamento Previdencia',
																labelText: 'Afastamento Previdencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.afastamentoPrevidencia = int.tryParse(text);
																feriasPeriodoAquisitivoController.formWasChanged = true;
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
															controller: feriasPeriodoAquisitivoController.afastamentoSemRemunController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Afastamento Sem Remun',
																labelText: 'Afastamento Sem Remun',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.afastamentoSemRemun = int.tryParse(text);
																feriasPeriodoAquisitivoController.formWasChanged = true;
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
															controller: feriasPeriodoAquisitivoController.afastamentoComRemunController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Afastamento Com Remun',
																labelText: 'Afastamento Com Remun',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.afastamentoComRemun = int.tryParse(text);
																feriasPeriodoAquisitivoController.formWasChanged = true;
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
															controller: feriasPeriodoAquisitivoController.diasDireitoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dias Direito',
																labelText: 'Dias Direito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.diasDireito = int.tryParse(text);
																feriasPeriodoAquisitivoController.formWasChanged = true;
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
															controller: feriasPeriodoAquisitivoController.diasGozadosController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dias Gozados',
																labelText: 'Dias Gozados',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.diasGozados = int.tryParse(text);
																feriasPeriodoAquisitivoController.formWasChanged = true;
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
															controller: feriasPeriodoAquisitivoController.diasFaltasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dias Faltas',
																labelText: 'Dias Faltas',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.diasFaltas = int.tryParse(text);
																feriasPeriodoAquisitivoController.formWasChanged = true;
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
															controller: feriasPeriodoAquisitivoController.diasRestantesController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dias Restantes',
																labelText: 'Dias Restantes',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																feriasPeriodoAquisitivoController.feriasPeriodoAquisitivoModel.diasRestantes = int.tryParse(text);
																feriasPeriodoAquisitivoController.formWasChanged = true;
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
