import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:agenda/app/page/shared_widget/shared_widget_imports.dart';
import 'package:agenda/app/controller/agenda_compromisso_convidado_controller.dart';
import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/page/shared_widget/input/input_imports.dart';

class AgendaCompromissoConvidadoEditPage extends StatelessWidget {
	AgendaCompromissoConvidadoEditPage({Key? key}) : super(key: key);
	final agendaCompromissoConvidadoController = Get.find<AgendaCompromissoConvidadoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: agendaCompromissoConvidadoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Convidados - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: agendaCompromissoConvidadoController.save),
						cancelAndExitButton(onPressed: agendaCompromissoConvidadoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: agendaCompromissoConvidadoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: agendaCompromissoConvidadoController.scrollController,
							child: SingleChildScrollView(
								controller: agendaCompromissoConvidadoController.scrollController,
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
																		controller: agendaCompromissoConvidadoController.viewPessoaColaboradorModelController,
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
																child: lookupButton(onPressed: agendaCompromissoConvidadoController.callViewPessoaColaboradorLookup),
															),
														],
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
