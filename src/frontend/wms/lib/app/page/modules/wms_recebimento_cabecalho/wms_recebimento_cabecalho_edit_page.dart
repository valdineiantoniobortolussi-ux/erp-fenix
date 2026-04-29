import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:wms/app/page/shared_widget/shared_widget_imports.dart';
import 'package:wms/app/controller/wms_recebimento_cabecalho_controller.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/page/shared_widget/input/input_imports.dart';

class WmsRecebimentoCabecalhoEditPage extends StatelessWidget {
	WmsRecebimentoCabecalhoEditPage({Key? key}) : super(key: key);
	final wmsRecebimentoCabecalhoController = Get.find<WmsRecebimentoCabecalhoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: wmsRecebimentoCabecalhoController.wmsRecebimentoCabecalhoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: wmsRecebimentoCabecalhoController.wmsRecebimentoCabecalhoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: wmsRecebimentoCabecalhoController.scrollController,
							child: SingleChildScrollView(
								controller: wmsRecebimentoCabecalhoController.scrollController,
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
																		controller: wmsRecebimentoCabecalhoController.wmsAgendamentoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Agendamento',
																			labelText: 'Agendamento *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: wmsRecebimentoCabecalhoController.callWmsAgendamentoLookup),
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
																hintText: 'Informe os dados para o campo Data Recebimento',
																labelText: 'Data Recebimento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: wmsRecebimentoCabecalhoController.wmsRecebimentoCabecalhoModel.dataRecebimento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	wmsRecebimentoCabecalhoController.wmsRecebimentoCabecalhoModel.dataRecebimento = value;
																	wmsRecebimentoCabecalhoController.formWasChanged = true;
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
															controller: wmsRecebimentoCabecalhoController.horaInicioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Inicio',
																labelText: 'Hora Inicio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsRecebimentoCabecalhoController.wmsRecebimentoCabecalhoModel.horaInicio = text;
																wmsRecebimentoCabecalhoController.formWasChanged = true;
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
															controller: wmsRecebimentoCabecalhoController.horaFimController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Fim',
																labelText: 'Hora Fim',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsRecebimentoCabecalhoController.wmsRecebimentoCabecalhoModel.horaFim = text;
																wmsRecebimentoCabecalhoController.formWasChanged = true;
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
															controller: wmsRecebimentoCabecalhoController.volumeRecebidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Volume Recebido',
																labelText: 'Volume Recebido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsRecebimentoCabecalhoController.wmsRecebimentoCabecalhoModel.volumeRecebido = int.tryParse(text);
																wmsRecebimentoCabecalhoController.formWasChanged = true;
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
															controller: wmsRecebimentoCabecalhoController.pesoRecebidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Peso Recebido',
																labelText: 'Peso Recebido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsRecebimentoCabecalhoController.wmsRecebimentoCabecalhoModel.pesoRecebido = wmsRecebimentoCabecalhoController.pesoRecebidoController.numberValue;
																wmsRecebimentoCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: wmsRecebimentoCabecalhoController.wmsRecebimentoCabecalhoModel.inconsistencia ?? 'S',
															labelText: 'Inconsistencia',
															hintText: 'Informe os dados para o campo Inconsistencia',
															items: const ['S','N'],
															onChanged: (dynamic newValue) {
																wmsRecebimentoCabecalhoController.wmsRecebimentoCabecalhoModel.inconsistencia = newValue;
																wmsRecebimentoCabecalhoController.formWasChanged = true;
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
															controller: wmsRecebimentoCabecalhoController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsRecebimentoCabecalhoController.wmsRecebimentoCabecalhoModel.observacao = text;
																wmsRecebimentoCabecalhoController.formWasChanged = true;
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
