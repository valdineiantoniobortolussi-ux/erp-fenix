import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:agenda/app/page/shared_widget/shared_widget_imports.dart';
import 'package:agenda/app/controller/recado_remetente_controller.dart';
import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/page/shared_widget/input/input_imports.dart';

class RecadoRemetenteEditPage extends StatelessWidget {
	RecadoRemetenteEditPage({Key? key}) : super(key: key);
	final recadoRemetenteController = Get.find<RecadoRemetenteController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: recadoRemetenteController.recadoRemetenteEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: recadoRemetenteController.recadoRemetenteEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: recadoRemetenteController.scrollController,
							child: SingleChildScrollView(
								controller: recadoRemetenteController.scrollController,
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
																		controller: recadoRemetenteController.viewPessoaColaboradorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Remetente',
																			labelText: 'Remetente *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: recadoRemetenteController.callViewPessoaColaboradorLookup),
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Envio',
																labelText: 'Data Envio',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: recadoRemetenteController.recadoRemetenteModel.dataEnvio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	recadoRemetenteController.recadoRemetenteModel.dataEnvio = value;
																	recadoRemetenteController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: recadoRemetenteController.horaEnvioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Envio',
																labelText: 'Hora Envio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																recadoRemetenteController.recadoRemetenteModel.horaEnvio = text;
																recadoRemetenteController.formWasChanged = true;
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
															controller: recadoRemetenteController.assuntoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Assunto',
																labelText: 'Assunto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																recadoRemetenteController.recadoRemetenteModel.assunto = text;
																recadoRemetenteController.formWasChanged = true;
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
															controller: recadoRemetenteController.textoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Texto',
																labelText: 'Texto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																recadoRemetenteController.recadoRemetenteModel.texto = text;
																recadoRemetenteController.formWasChanged = true;
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
