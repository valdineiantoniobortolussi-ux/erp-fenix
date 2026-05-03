import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/folha_ppp_exame_medico_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FolhaPppExameMedicoEditPage extends StatelessWidget {
	FolhaPppExameMedicoEditPage({Key? key}) : super(key: key);
	final folhaPppExameMedicoController = Get.find<FolhaPppExameMedicoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: folhaPppExameMedicoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Exame Médico - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: folhaPppExameMedicoController.save),
						cancelAndExitButton(onPressed: folhaPppExameMedicoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: folhaPppExameMedicoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: folhaPppExameMedicoController.scrollController,
							child: SingleChildScrollView(
								controller: folhaPppExameMedicoController.scrollController,
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
																hintText: 'Informe os dados para o campo Data Ultimo',
																labelText: 'Data Ultimo',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: folhaPppExameMedicoController.folhaPppExameMedicoModel.dataUltimo,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaPppExameMedicoController.folhaPppExameMedicoModel.dataUltimo = value;
																	folhaPppExameMedicoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaPppExameMedicoController.folhaPppExameMedicoModel.tipo ?? 'Admissional',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Admissional','Periódico','Retorno ao Trabalho','Mudança de Função','Demissional'],
															onChanged: (dynamic newValue) {
																folhaPppExameMedicoController.folhaPppExameMedicoModel.tipo = newValue;
																folhaPppExameMedicoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaPppExameMedicoController.folhaPppExameMedicoModel.exame ?? 'Referencial',
															labelText: 'Exame',
															hintText: 'Informe os dados para o campo Exame',
															items: const ['Referencial','Sequencial'],
															onChanged: (dynamic newValue) {
																folhaPppExameMedicoController.folhaPppExameMedicoModel.exame = newValue;
																folhaPppExameMedicoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: folhaPppExameMedicoController.naturezaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Natureza',
																labelText: 'Natureza',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaPppExameMedicoController.folhaPppExameMedicoModel.natureza = text;
																folhaPppExameMedicoController.formWasChanged = true;
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
															controller: folhaPppExameMedicoController.indicacaoResultadosController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Indicacao Resultados',
																labelText: 'Indicacao Resultados',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaPppExameMedicoController.folhaPppExameMedicoModel.indicacaoResultados = text;
																folhaPppExameMedicoController.formWasChanged = true;
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
