import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_det_especifico_armamento_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeDetEspecificoArmamentoEditPage extends StatelessWidget {
	NfeDetEspecificoArmamentoEditPage({Key? key}) : super(key: key);
	final nfeDetEspecificoArmamentoController = Get.find<NfeDetEspecificoArmamentoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeDetEspecificoArmamentoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Armamento - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeDetEspecificoArmamentoController.save),
						cancelAndExitButton(onPressed: nfeDetEspecificoArmamentoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeDetEspecificoArmamentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeDetEspecificoArmamentoController.scrollController,
							child: SingleChildScrollView(
								controller: nfeDetEspecificoArmamentoController.scrollController,
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
														child: CustomDropdownButtonFormField(
															value: nfeDetEspecificoArmamentoController.nfeDetEspecificoArmamentoModel.tipoArma ?? 'AAA',
															labelText: 'Tipo Arma',
															hintText: 'Informe os dados para o campo Tipo Arma',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetEspecificoArmamentoController.nfeDetEspecificoArmamentoModel.tipoArma = newValue;
																nfeDetEspecificoArmamentoController.formWasChanged = true;
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
															maxLength: 15,
															controller: nfeDetEspecificoArmamentoController.numeroSerieArmaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Serie Arma',
																labelText: 'Numero Serie Arma',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoArmamentoController.nfeDetEspecificoArmamentoModel.numeroSerieArma = text;
																nfeDetEspecificoArmamentoController.formWasChanged = true;
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
															maxLength: 15,
															controller: nfeDetEspecificoArmamentoController.numeroSerieCanoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Serie Cano',
																labelText: 'Numero Serie Cano',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoArmamentoController.nfeDetEspecificoArmamentoModel.numeroSerieCano = text;
																nfeDetEspecificoArmamentoController.formWasChanged = true;
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
															controller: nfeDetEspecificoArmamentoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoArmamentoController.nfeDetEspecificoArmamentoModel.descricao = text;
																nfeDetEspecificoArmamentoController.formWasChanged = true;
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
