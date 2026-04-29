import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:agenda/app/page/shared_widget/shared_widget_imports.dart';
import 'package:agenda/app/controller/agenda_notificacao_controller.dart';
import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/page/shared_widget/input/input_imports.dart';

class AgendaNotificacaoEditPage extends StatelessWidget {
	AgendaNotificacaoEditPage({Key? key}) : super(key: key);
	final agendaNotificacaoController = Get.find<AgendaNotificacaoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: agendaNotificacaoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Notificações - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: agendaNotificacaoController.save),
						cancelAndExitButton(onPressed: agendaNotificacaoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: agendaNotificacaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: agendaNotificacaoController.scrollController,
							child: SingleChildScrollView(
								controller: agendaNotificacaoController.scrollController,
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Notificacao',
																labelText: 'Data Notificacao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: agendaNotificacaoController.agendaNotificacaoModel.dataNotificacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	agendaNotificacaoController.agendaNotificacaoModel.dataNotificacao = value;
																	agendaNotificacaoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: agendaNotificacaoController.horaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora',
																labelText: 'Hora',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																agendaNotificacaoController.agendaNotificacaoModel.hora = text;
																agendaNotificacaoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: agendaNotificacaoController.agendaNotificacaoModel.tipo ?? 'Email',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Email','Mensagem na tela do computador'],
															onChanged: (dynamic newValue) {
																agendaNotificacaoController.agendaNotificacaoModel.tipo = newValue;
																agendaNotificacaoController.formWasChanged = true;
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
