import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:mdfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:mdfe/app/controller/mdfe_percurso_controller.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/page/shared_widget/input/input_imports.dart';

class MdfePercursoEditPage extends StatelessWidget {
	MdfePercursoEditPage({Key? key}) : super(key: key);
	final mdfePercursoController = Get.find<MdfePercursoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: mdfePercursoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Percurso - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: mdfePercursoController.save),
						cancelAndExitButton(onPressed: mdfePercursoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: mdfePercursoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: mdfePercursoController.scrollController,
							child: SingleChildScrollView(
								controller: mdfePercursoController.scrollController,
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
														child: CustomDropdownButtonFormField(
															value: mdfePercursoController.mdfePercursoModel.ufPercurso ?? 'AC',
															labelText: 'Uf Percurso',
															hintText: 'Informe os dados para o campo Uf Percurso',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																mdfePercursoController.mdfePercursoModel.ufPercurso = newValue;
																mdfePercursoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Inicio Viagem',
																labelText: 'Data Inicio Viagem',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: mdfePercursoController.mdfePercursoModel.dataInicioViagem,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	mdfePercursoController.mdfePercursoModel.dataInicioViagem = value;
																	mdfePercursoController.formWasChanged = true;
																},
															),
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
