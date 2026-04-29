import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/folha_ppp_fator_risco_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FolhaPppFatorRiscoEditPage extends StatelessWidget {
	FolhaPppFatorRiscoEditPage({Key? key}) : super(key: key);
	final folhaPppFatorRiscoController = Get.find<FolhaPppFatorRiscoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: folhaPppFatorRiscoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Fator de Risco - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: folhaPppFatorRiscoController.save),
						cancelAndExitButton(onPressed: folhaPppFatorRiscoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: folhaPppFatorRiscoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: folhaPppFatorRiscoController.scrollController,
							child: SingleChildScrollView(
								controller: folhaPppFatorRiscoController.scrollController,
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
																dateTime: folhaPppFatorRiscoController.folhaPppFatorRiscoModel.dataInicio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaPppFatorRiscoController.folhaPppFatorRiscoModel.dataInicio = value;
																	folhaPppFatorRiscoController.formWasChanged = true;
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
																dateTime: folhaPppFatorRiscoController.folhaPppFatorRiscoModel.dataFim,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaPppFatorRiscoController.folhaPppFatorRiscoModel.dataFim = value;
																	folhaPppFatorRiscoController.formWasChanged = true;
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
															value: folhaPppFatorRiscoController.folhaPppFatorRiscoModel.tipo ?? 'F=Físico',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['F=Físico','Q=Químico','B=Biológico','E=Ergonômico/Psicossocial','M=Mecânico/de Acidente'],
															onChanged: (dynamic newValue) {
																folhaPppFatorRiscoController.folhaPppFatorRiscoModel.tipo = newValue;
																folhaPppFatorRiscoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 40,
															controller: folhaPppFatorRiscoController.fatorRiscoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fator Risco',
																labelText: 'Fator Risco',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaPppFatorRiscoController.folhaPppFatorRiscoModel.fatorRisco = text;
																folhaPppFatorRiscoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 15,
															controller: folhaPppFatorRiscoController.intensidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Intensidade',
																labelText: 'Intensidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaPppFatorRiscoController.folhaPppFatorRiscoModel.intensidade = text;
																folhaPppFatorRiscoController.formWasChanged = true;
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
															maxLength: 40,
															controller: folhaPppFatorRiscoController.tecnicaUtilizadaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Tecnica Utilizada',
																labelText: 'Tecnica Utilizada',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaPppFatorRiscoController.folhaPppFatorRiscoModel.tecnicaUtilizada = text;
																folhaPppFatorRiscoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaPppFatorRiscoController.folhaPppFatorRiscoModel.epcEficaz ?? 'Sim',
															labelText: 'EPC Eficaz',
															hintText: 'Informe os dados para o campo EPC Eficaz',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaPppFatorRiscoController.folhaPppFatorRiscoModel.epcEficaz = newValue;
																folhaPppFatorRiscoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaPppFatorRiscoController.folhaPppFatorRiscoModel.epiEficaz ?? 'Sim',
															labelText: 'EPI Eficaz',
															hintText: 'Informe os dados para o campo EPI Eficaz',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaPppFatorRiscoController.folhaPppFatorRiscoModel.epiEficaz = newValue;
																folhaPppFatorRiscoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: folhaPppFatorRiscoController.caEpiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo CA EPI',
																labelText: 'CA EPI',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaPppFatorRiscoController.folhaPppFatorRiscoModel.caEpi = int.tryParse(text);
																folhaPppFatorRiscoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: folhaPppFatorRiscoController.folhaPppFatorRiscoModel.atendimentoNr061 ?? 'Sim',
															labelText: 'Atendimento Nr 06 1',
															hintText: 'Informe os dados para o campo Atendimento Nr 06 1',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaPppFatorRiscoController.folhaPppFatorRiscoModel.atendimentoNr061 = newValue;
																folhaPppFatorRiscoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaPppFatorRiscoController.folhaPppFatorRiscoModel.atendimentoNr062 ?? 'Sim',
															labelText: 'Atendimento Nr 06 2',
															hintText: 'Informe os dados para o campo Atendimento Nr 06 2',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaPppFatorRiscoController.folhaPppFatorRiscoModel.atendimentoNr062 = newValue;
																folhaPppFatorRiscoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaPppFatorRiscoController.folhaPppFatorRiscoModel.atendimentoNr063 ?? 'Sim',
															labelText: 'Atendimento Nr 06 3',
															hintText: 'Informe os dados para o campo Atendimento Nr 06 3',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaPppFatorRiscoController.folhaPppFatorRiscoModel.atendimentoNr063 = newValue;
																folhaPppFatorRiscoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaPppFatorRiscoController.folhaPppFatorRiscoModel.atendimentoNr064 ?? 'Sim',
															labelText: 'Atendimento Nr 06 4',
															hintText: 'Informe os dados para o campo Atendimento Nr 06 4',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaPppFatorRiscoController.folhaPppFatorRiscoModel.atendimentoNr064 = newValue;
																folhaPppFatorRiscoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaPppFatorRiscoController.folhaPppFatorRiscoModel.atendimentoNr065 ?? 'Sim',
															labelText: 'Atendimento Nr 06 5',
															hintText: 'Informe os dados para o campo Atendimento Nr 06 5',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaPppFatorRiscoController.folhaPppFatorRiscoModel.atendimentoNr065 = newValue;
																folhaPppFatorRiscoController.formWasChanged = true;
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
