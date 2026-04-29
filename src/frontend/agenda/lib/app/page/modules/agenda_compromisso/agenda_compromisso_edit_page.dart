import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:agenda/app/page/shared_widget/shared_widget_imports.dart';
import 'package:agenda/app/controller/agenda_compromisso_controller.dart';
import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/page/shared_widget/input/input_imports.dart';

class AgendaCompromissoEditPage extends StatelessWidget {
	AgendaCompromissoEditPage({Key? key}) : super(key: key);
	final agendaCompromissoController = Get.find<AgendaCompromissoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: agendaCompromissoController.agendaCompromissoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: agendaCompromissoController.agendaCompromissoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: agendaCompromissoController.scrollController,
							child: SingleChildScrollView(
								controller: agendaCompromissoController.scrollController,
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: agendaCompromissoController.agendaCategoriaCompromissoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Categoria',
																			labelText: 'Categoria *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: agendaCompromissoController.callAgendaCategoriaCompromissoLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: agendaCompromissoController.viewPessoaColaboradorModelController,
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
																child: lookupButton(onPressed: agendaCompromissoController.callViewPessoaColaboradorLookup),
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
																hintText: 'Informe os dados para o campo Data Compromisso',
																labelText: 'Data Compromisso',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: agendaCompromissoController.agendaCompromissoModel.dataCompromisso,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	agendaCompromissoController.agendaCompromissoModel.dataCompromisso = value;
																	agendaCompromissoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 8,
															controller: agendaCompromissoController.horaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora',
																labelText: 'Hora',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																agendaCompromissoController.agendaCompromissoModel.hora = text;
																agendaCompromissoController.formWasChanged = true;
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
															controller: agendaCompromissoController.duracaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Duracao',
																labelText: 'Duracao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																agendaCompromissoController.agendaCompromissoModel.duracao = int.tryParse(text);
																agendaCompromissoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: agendaCompromissoController.agendaCompromissoModel.tipo ?? 'Pessoal',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Pessoal','Gerencial'],
															onChanged: (dynamic newValue) {
																agendaCompromissoController.agendaCompromissoModel.tipo = newValue;
																agendaCompromissoController.formWasChanged = true;
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
															maxLength: 100,
															controller: agendaCompromissoController.ondeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Onde',
																labelText: 'Onde',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																agendaCompromissoController.agendaCompromissoModel.onde = text;
																agendaCompromissoController.formWasChanged = true;
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
															maxLength: 100,
															controller: agendaCompromissoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																agendaCompromissoController.agendaCompromissoModel.descricao = text;
																agendaCompromissoController.formWasChanged = true;
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
			);
	}
}
