import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:agenda/app/page/shared_widget/shared_widget_imports.dart';
import 'package:agenda/app/controller/reuniao_sala_evento_controller.dart';
import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/page/shared_widget/input/input_imports.dart';

class ReuniaoSalaEventoEditPage extends StatelessWidget {
	ReuniaoSalaEventoEditPage({Key? key}) : super(key: key);
	final reuniaoSalaEventoController = Get.find<ReuniaoSalaEventoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: reuniaoSalaEventoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Eventos - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: reuniaoSalaEventoController.save),
						cancelAndExitButton(onPressed: reuniaoSalaEventoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: reuniaoSalaEventoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: reuniaoSalaEventoController.scrollController,
							child: SingleChildScrollView(
								controller: reuniaoSalaEventoController.scrollController,
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
													sizes: 'col-12 col-md-9',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: reuniaoSalaEventoController.reuniaoSalaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Sala',
																			labelText: 'Sala *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: reuniaoSalaEventoController.callReuniaoSalaLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Reserva',
																labelText: 'Data Reserva',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: reuniaoSalaEventoController.reuniaoSalaEventoModel.dataReserva,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	reuniaoSalaEventoController.reuniaoSalaEventoModel.dataReserva = value;
																	reuniaoSalaEventoController.formWasChanged = true;
																},
															),
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
