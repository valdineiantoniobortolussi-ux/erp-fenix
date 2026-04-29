import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ponto/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ponto/app/controller/ponto_horario_autorizado_controller.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/page/shared_widget/input/input_imports.dart';

class PontoHorarioAutorizadoEditPage extends StatelessWidget {
	PontoHorarioAutorizadoEditPage({Key? key}) : super(key: key);
	final pontoHorarioAutorizadoController = Get.find<PontoHorarioAutorizadoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					pontoHorarioAutorizadoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: pontoHorarioAutorizadoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Horário Autorizado - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: pontoHorarioAutorizadoController.save),
						cancelAndExitButton(onPressed: pontoHorarioAutorizadoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pontoHorarioAutorizadoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pontoHorarioAutorizadoController.scrollController,
							child: SingleChildScrollView(
								controller: pontoHorarioAutorizadoController.scrollController,
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
																		controller: pontoHorarioAutorizadoController.viewPessoaColaboradorModelController,
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
																child: lookupButton(onPressed: pontoHorarioAutorizadoController.callViewPessoaColaboradorLookup),
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
																hintText: 'Informe os dados para o campo Data Horario',
																labelText: 'Data Horario',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.dataHorario,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.dataHorario = value;
																	pontoHorarioAutorizadoController.formWasChanged = true;
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
															value: pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.tipo ?? 'Fixo',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Fixo','Diário','Semanal','Mensal'],
															onChanged: (dynamic newValue) {
																pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.tipo = newValue;
																pontoHorarioAutorizadoController.formWasChanged = true;
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
															controller: pontoHorarioAutorizadoController.cargaHorariaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Carga Horaria',
																labelText: 'Carga Horaria',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.cargaHoraria = text;
																pontoHorarioAutorizadoController.formWasChanged = true;
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
															controller: pontoHorarioAutorizadoController.entrada01Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 01',
																labelText: 'Entrada 01',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.entrada01 = text;
																pontoHorarioAutorizadoController.formWasChanged = true;
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
															controller: pontoHorarioAutorizadoController.saida01Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 01',
																labelText: 'Saida 01',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.saida01 = text;
																pontoHorarioAutorizadoController.formWasChanged = true;
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
															controller: pontoHorarioAutorizadoController.entrada02Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 02',
																labelText: 'Entrada 02',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.entrada02 = text;
																pontoHorarioAutorizadoController.formWasChanged = true;
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
															controller: pontoHorarioAutorizadoController.saida02Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 02',
																labelText: 'Saida 02',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.saida02 = text;
																pontoHorarioAutorizadoController.formWasChanged = true;
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
															controller: pontoHorarioAutorizadoController.entrada03Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 03',
																labelText: 'Entrada 03',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.entrada03 = text;
																pontoHorarioAutorizadoController.formWasChanged = true;
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
															controller: pontoHorarioAutorizadoController.saida03Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 03',
																labelText: 'Saida 03',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.saida03 = text;
																pontoHorarioAutorizadoController.formWasChanged = true;
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
															controller: pontoHorarioAutorizadoController.entrada04Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 04',
																labelText: 'Entrada 04',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.entrada04 = text;
																pontoHorarioAutorizadoController.formWasChanged = true;
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
															controller: pontoHorarioAutorizadoController.saida04Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 04',
																labelText: 'Saida 04',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.saida04 = text;
																pontoHorarioAutorizadoController.formWasChanged = true;
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
															controller: pontoHorarioAutorizadoController.entrada05Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Entrada 05',
																labelText: 'Entrada 05',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.entrada05 = text;
																pontoHorarioAutorizadoController.formWasChanged = true;
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
															controller: pontoHorarioAutorizadoController.saida05Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Saida 05',
																labelText: 'Saida 05',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.saida05 = text;
																pontoHorarioAutorizadoController.formWasChanged = true;
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
															controller: pontoHorarioAutorizadoController.horaFechamentoDiaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Fechamento Dia',
																labelText: 'Hora Fechamento Dia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoHorarioAutorizadoController.pontoHorarioAutorizadoModel.horaFechamentoDia = text;
																pontoHorarioAutorizadoController.formWasChanged = true;
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
