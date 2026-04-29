import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ordem_servico/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ordem_servico/app/controller/os_abertura_equipamento_controller.dart';
import 'package:ordem_servico/app/infra/infra_imports.dart';
import 'package:ordem_servico/app/page/shared_widget/input/input_imports.dart';

class OsAberturaEquipamentoEditPage extends StatelessWidget {
	OsAberturaEquipamentoEditPage({Key? key}) : super(key: key);
	final osAberturaEquipamentoController = Get.find<OsAberturaEquipamentoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: osAberturaEquipamentoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Equipamentos - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: osAberturaEquipamentoController.save),
						cancelAndExitButton(onPressed: osAberturaEquipamentoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: osAberturaEquipamentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: osAberturaEquipamentoController.scrollController,
							child: SingleChildScrollView(
								controller: osAberturaEquipamentoController.scrollController,
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
																		controller: osAberturaEquipamentoController.osEquipamentoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Equipamento',
																			labelText: 'Equipamento *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: osAberturaEquipamentoController.callOsEquipamentoLookup),
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
														child: CustomDropdownButtonFormField(
															value: osAberturaEquipamentoController.osAberturaEquipamentoModel.tipoCobertura ?? 'Nenhum',
															labelText: 'Tipo Cobertura',
															hintText: 'Informe os dados para o campo Tipo Cobertura',
															items: const ['Nenhum','Garantia','Seguro','Contrato'],
															onChanged: (dynamic newValue) {
																osAberturaEquipamentoController.osAberturaEquipamentoModel.tipoCobertura = newValue;
																osAberturaEquipamentoController.formWasChanged = true;
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
															maxLength: 50,
															controller: osAberturaEquipamentoController.numeroSerieController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Serie',
																labelText: 'Numero Serie',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																osAberturaEquipamentoController.osAberturaEquipamentoModel.numeroSerie = text;
																osAberturaEquipamentoController.formWasChanged = true;
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
