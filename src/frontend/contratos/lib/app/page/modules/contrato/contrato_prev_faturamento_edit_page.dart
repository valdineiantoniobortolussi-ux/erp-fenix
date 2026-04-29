import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contratos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contratos/app/controller/contrato_prev_faturamento_controller.dart';
import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/page/shared_widget/input/input_imports.dart';

class ContratoPrevFaturamentoEditPage extends StatelessWidget {
	ContratoPrevFaturamentoEditPage({Key? key}) : super(key: key);
	final contratoPrevFaturamentoController = Get.find<ContratoPrevFaturamentoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: contratoPrevFaturamentoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Previsão de Faturamento - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: contratoPrevFaturamentoController.save),
						cancelAndExitButton(onPressed: contratoPrevFaturamentoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contratoPrevFaturamentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contratoPrevFaturamentoController.scrollController,
							child: SingleChildScrollView(
								controller: contratoPrevFaturamentoController.scrollController,
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
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Prevista',
																labelText: 'Data Prevista',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: contratoPrevFaturamentoController.contratoPrevFaturamentoModel.dataPrevista,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contratoPrevFaturamentoController.contratoPrevFaturamentoModel.dataPrevista = value;
																	contratoPrevFaturamentoController.formWasChanged = true;
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
															controller: contratoPrevFaturamentoController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contratoPrevFaturamentoController.contratoPrevFaturamentoModel.valor = contratoPrevFaturamentoController.valorController.numberValue;
																contratoPrevFaturamentoController.formWasChanged = true;
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
