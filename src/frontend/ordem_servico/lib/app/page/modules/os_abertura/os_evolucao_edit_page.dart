import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ordem_servico/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ordem_servico/app/controller/os_evolucao_controller.dart';
import 'package:ordem_servico/app/infra/infra_imports.dart';
import 'package:ordem_servico/app/page/shared_widget/input/input_imports.dart';

class OsEvolucaoEditPage extends StatelessWidget {
	OsEvolucaoEditPage({Key? key}) : super(key: key);
	final osEvolucaoController = Get.find<OsEvolucaoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: osEvolucaoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Evolução - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: osEvolucaoController.save),
						cancelAndExitButton(onPressed: osEvolucaoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: osEvolucaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: osEvolucaoController.scrollController,
							child: SingleChildScrollView(
								controller: osEvolucaoController.scrollController,
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
																hintText: 'Informe os dados para o campo Data Registro',
																labelText: 'Data Registro',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: osEvolucaoController.osEvolucaoModel.dataRegistro,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	osEvolucaoController.osEvolucaoModel.dataRegistro = value;
																	osEvolucaoController.formWasChanged = true;
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
															controller: osEvolucaoController.horaRegistroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Registro',
																labelText: 'Hora Registro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																osEvolucaoController.osEvolucaoModel.horaRegistro = text;
																osEvolucaoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: osEvolucaoController.osEvolucaoModel.enviarEmail ?? 'S',
															labelText: 'Enviar Email',
															hintText: 'Informe os dados para o campo Enviar Email',
															items: const ['S','N'],
															onChanged: (dynamic newValue) {
																osEvolucaoController.osEvolucaoModel.enviarEmail = newValue;
																osEvolucaoController.formWasChanged = true;
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
															controller: osEvolucaoController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																osEvolucaoController.osEvolucaoModel.observacao = text;
																osEvolucaoController.formWasChanged = true;
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
