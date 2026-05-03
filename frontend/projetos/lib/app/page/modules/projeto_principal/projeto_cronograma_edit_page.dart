import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:projetos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:projetos/app/controller/projeto_cronograma_controller.dart';
import 'package:projetos/app/infra/infra_imports.dart';
import 'package:projetos/app/page/shared_widget/input/input_imports.dart';

class ProjetoCronogramaEditPage extends StatelessWidget {
	ProjetoCronogramaEditPage({Key? key}) : super(key: key);
	final projetoCronogramaController = Get.find<ProjetoCronogramaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: projetoCronogramaController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Cronograma - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: projetoCronogramaController.save),
						cancelAndExitButton(onPressed: projetoCronogramaController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: projetoCronogramaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: projetoCronogramaController.scrollController,
							child: SingleChildScrollView(
								controller: projetoCronogramaController.scrollController,
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
													sizes: 'col-12 col-md-9',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: projetoCronogramaController.tarefaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Tarefa',
																labelText: 'Tarefa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoCronogramaController.projetoCronogramaModel.tarefa = text;
																projetoCronogramaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Tarefa',
																labelText: 'Data Tarefa',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: projetoCronogramaController.projetoCronogramaModel.dataTarefa,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	projetoCronogramaController.projetoCronogramaModel.dataTarefa = value;
																	projetoCronogramaController.formWasChanged = true;
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
															maxLines: 3,
															controller: projetoCronogramaController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoCronogramaController.projetoCronogramaModel.descricao = text;
																projetoCronogramaController.formWasChanged = true;
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
