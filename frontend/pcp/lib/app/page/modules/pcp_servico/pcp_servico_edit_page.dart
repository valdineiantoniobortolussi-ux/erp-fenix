import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:pcp/app/page/shared_widget/shared_widget_imports.dart';
import 'package:pcp/app/controller/pcp_servico_controller.dart';
import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/page/shared_widget/input/input_imports.dart';

class PcpServicoEditPage extends StatelessWidget {
	PcpServicoEditPage({Key? key}) : super(key: key);
	final pcpServicoController = Get.find<PcpServicoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: pcpServicoController.pcpServicoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pcpServicoController.pcpServicoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pcpServicoController.scrollController,
							child: SingleChildScrollView(
								controller: pcpServicoController.scrollController,
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
																		controller: pcpServicoController.pcpOpDetalheModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Item da OP',
																			labelText: 'Item da OP *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: pcpServicoController.callPcpOpDetalheLookup),
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
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Inicio Previsto',
																labelText: 'Inicio Previsto',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pcpServicoController.pcpServicoModel.inicioPrevisto,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pcpServicoController.pcpServicoModel.inicioPrevisto = value;
																	pcpServicoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Termino Previsto',
																labelText: 'Termino Previsto',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pcpServicoController.pcpServicoModel.terminoPrevisto,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pcpServicoController.pcpServicoModel.terminoPrevisto = value;
																	pcpServicoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pcpServicoController.horasPrevistoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Horas Previsto',
																labelText: 'Horas Previsto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpServicoController.pcpServicoModel.horasPrevisto = int.tryParse(text);
																pcpServicoController.formWasChanged = true;
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
															controller: pcpServicoController.minutosPrevistoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Minutos Previsto',
																labelText: 'Minutos Previsto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpServicoController.pcpServicoModel.minutosPrevisto = int.tryParse(text);
																pcpServicoController.formWasChanged = true;
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
															controller: pcpServicoController.segundosPrevistoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Segundos Previsto',
																labelText: 'Segundos Previsto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpServicoController.pcpServicoModel.segundosPrevisto = int.tryParse(text);
																pcpServicoController.formWasChanged = true;
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
															controller: pcpServicoController.custoPrevistoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Custo Previsto',
																labelText: 'Custo Previsto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpServicoController.pcpServicoModel.custoPrevisto = pcpServicoController.custoPrevistoController.numberValue;
																pcpServicoController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Inicio Realizado',
																labelText: 'Inicio Realizado',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pcpServicoController.pcpServicoModel.inicioRealizado,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pcpServicoController.pcpServicoModel.inicioRealizado = value;
																	pcpServicoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Termino Realizado',
																labelText: 'Termino Realizado',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pcpServicoController.pcpServicoModel.terminoRealizado,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pcpServicoController.pcpServicoModel.terminoRealizado = value;
																	pcpServicoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pcpServicoController.horasRealizadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Horas Realizado',
																labelText: 'Horas Realizado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpServicoController.pcpServicoModel.horasRealizado = int.tryParse(text);
																pcpServicoController.formWasChanged = true;
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
															controller: pcpServicoController.minutosRealizadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Minutos Realizado',
																labelText: 'Minutos Realizado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpServicoController.pcpServicoModel.minutosRealizado = int.tryParse(text);
																pcpServicoController.formWasChanged = true;
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
															controller: pcpServicoController.segundosRealizadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Segundos Realizado',
																labelText: 'Segundos Realizado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpServicoController.pcpServicoModel.segundosRealizado = int.tryParse(text);
																pcpServicoController.formWasChanged = true;
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
															controller: pcpServicoController.custoRealizadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Custo Realizado',
																labelText: 'Custo Realizado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpServicoController.pcpServicoModel.custoRealizado = pcpServicoController.custoRealizadoController.numberValue;
																pcpServicoController.formWasChanged = true;
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
