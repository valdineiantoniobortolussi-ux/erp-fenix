import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_encerramento_exe_cab_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class ContabilEncerramentoExeCabEditPage extends StatelessWidget {
	ContabilEncerramentoExeCabEditPage({Key? key}) : super(key: key);
	final contabilEncerramentoExeCabController = Get.find<ContabilEncerramentoExeCabController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: contabilEncerramentoExeCabController.contabilEncerramentoExeCabEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contabilEncerramentoExeCabController.contabilEncerramentoExeCabEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contabilEncerramentoExeCabController.scrollController,
							child: SingleChildScrollView(
								controller: contabilEncerramentoExeCabController.scrollController,
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
																hintText: 'Informe os dados para o campo Data Inicio',
																labelText: 'Data Inicio',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: contabilEncerramentoExeCabController.contabilEncerramentoExeCabModel.dataInicio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contabilEncerramentoExeCabController.contabilEncerramentoExeCabModel.dataInicio = value;
																	contabilEncerramentoExeCabController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
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
																dateTime: contabilEncerramentoExeCabController.contabilEncerramentoExeCabModel.dataFim,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contabilEncerramentoExeCabController.contabilEncerramentoExeCabModel.dataFim = value;
																	contabilEncerramentoExeCabController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Inclusao',
																labelText: 'Data Inclusao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: contabilEncerramentoExeCabController.contabilEncerramentoExeCabModel.dataInclusao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contabilEncerramentoExeCabController.contabilEncerramentoExeCabModel.dataInclusao = value;
																	contabilEncerramentoExeCabController.formWasChanged = true;
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: contabilEncerramentoExeCabController.motivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Motivo',
																labelText: 'Motivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilEncerramentoExeCabController.contabilEncerramentoExeCabModel.motivo = text;
																contabilEncerramentoExeCabController.formWasChanged = true;
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
