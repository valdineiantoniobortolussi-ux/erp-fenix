import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:wms/app/page/shared_widget/shared_widget_imports.dart';
import 'package:wms/app/controller/wms_agendamento_controller.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/page/shared_widget/input/input_imports.dart';

class WmsAgendamentoEditPage extends StatelessWidget {
	WmsAgendamentoEditPage({Key? key}) : super(key: key);
	final wmsAgendamentoController = Get.find<WmsAgendamentoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					wmsAgendamentoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: wmsAgendamentoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Agendamento - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: wmsAgendamentoController.save),
						cancelAndExitButton(onPressed: wmsAgendamentoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: wmsAgendamentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: wmsAgendamentoController.scrollController,
							child: SingleChildScrollView(
								controller: wmsAgendamentoController.scrollController,
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Operacao',
																labelText: 'Data Operacao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: wmsAgendamentoController.wmsAgendamentoModel.dataOperacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	wmsAgendamentoController.wmsAgendamentoModel.dataOperacao = value;
																	wmsAgendamentoController.formWasChanged = true;
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
															controller: wmsAgendamentoController.horaOperacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Operacao',
																labelText: 'Hora Operacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsAgendamentoController.wmsAgendamentoModel.horaOperacao = text;
																wmsAgendamentoController.formWasChanged = true;
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
															maxLength: 100,
															controller: wmsAgendamentoController.localOperacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Local Operacao',
																labelText: 'Local Operacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsAgendamentoController.wmsAgendamentoModel.localOperacao = text;
																wmsAgendamentoController.formWasChanged = true;
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
															controller: wmsAgendamentoController.quantidadeVolumeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Volume',
																labelText: 'Quantidade Volume',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsAgendamentoController.wmsAgendamentoModel.quantidadeVolume = int.tryParse(text);
																wmsAgendamentoController.formWasChanged = true;
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
															controller: wmsAgendamentoController.pesoTotalVolumeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Peso Total Volume',
																labelText: 'Peso Total Volume',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsAgendamentoController.wmsAgendamentoModel.pesoTotalVolume = wmsAgendamentoController.pesoTotalVolumeController.numberValue;
																wmsAgendamentoController.formWasChanged = true;
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
															controller: wmsAgendamentoController.quantidadePessoaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Pessoa',
																labelText: 'Quantidade Pessoa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsAgendamentoController.wmsAgendamentoModel.quantidadePessoa = int.tryParse(text);
																wmsAgendamentoController.formWasChanged = true;
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
															controller: wmsAgendamentoController.quantidadeHoraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Hora',
																labelText: 'Quantidade Hora',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsAgendamentoController.wmsAgendamentoModel.quantidadeHora = int.tryParse(text);
																wmsAgendamentoController.formWasChanged = true;
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
