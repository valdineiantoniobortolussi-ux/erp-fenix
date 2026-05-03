import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_det_especifico_medicamento_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeDetEspecificoMedicamentoEditPage extends StatelessWidget {
	NfeDetEspecificoMedicamentoEditPage({Key? key}) : super(key: key);
	final nfeDetEspecificoMedicamentoController = Get.find<NfeDetEspecificoMedicamentoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeDetEspecificoMedicamentoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Medicamento - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeDetEspecificoMedicamentoController.save),
						cancelAndExitButton(onPressed: nfeDetEspecificoMedicamentoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeDetEspecificoMedicamentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeDetEspecificoMedicamentoController.scrollController,
							child: SingleChildScrollView(
								controller: nfeDetEspecificoMedicamentoController.scrollController,
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
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 13,
															controller: nfeDetEspecificoMedicamentoController.codigoAnvisaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Anvisa',
																labelText: 'Codigo Anvisa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoMedicamentoController.nfeDetEspecificoMedicamentoModel.codigoAnvisa = text;
																nfeDetEspecificoMedicamentoController.formWasChanged = true;
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
															maxLength: 250,
															controller: nfeDetEspecificoMedicamentoController.motivoIsencaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Motivo Isencao',
																labelText: 'Motivo Isencao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoMedicamentoController.nfeDetEspecificoMedicamentoModel.motivoIsencao = text;
																nfeDetEspecificoMedicamentoController.formWasChanged = true;
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
															controller: nfeDetEspecificoMedicamentoController.precoMaximoConsumidorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Preco Maximo Consumidor',
																labelText: 'Preco Maximo Consumidor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoMedicamentoController.nfeDetEspecificoMedicamentoModel.precoMaximoConsumidor = nfeDetEspecificoMedicamentoController.precoMaximoConsumidorController.numberValue;
																nfeDetEspecificoMedicamentoController.formWasChanged = true;
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
