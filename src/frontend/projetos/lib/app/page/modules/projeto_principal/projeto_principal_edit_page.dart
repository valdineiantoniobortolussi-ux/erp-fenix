import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:projetos/app/controller/projeto_principal_controller.dart';
import 'package:projetos/app/infra/infra_imports.dart';
import 'package:projetos/app/page/shared_widget/input/input_imports.dart';

class ProjetoPrincipalEditPage extends StatelessWidget {
	ProjetoPrincipalEditPage({Key? key}) : super(key: key);
	final projetoPrincipalController = Get.find<ProjetoPrincipalController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: projetoPrincipalController.projetoPrincipalEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: projetoPrincipalController.projetoPrincipalEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: projetoPrincipalController.scrollController,
							child: SingleChildScrollView(
								controller: projetoPrincipalController.scrollController,
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
															maxLength: 100,
															controller: projetoPrincipalController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoPrincipalController.projetoPrincipalModel.nome = text;
																projetoPrincipalController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
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
																dateTime: projetoPrincipalController.projetoPrincipalModel.dataInicio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	projetoPrincipalController.projetoPrincipalModel.dataInicio = value;
																	projetoPrincipalController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Previsao Fim',
																labelText: 'Data Previsao Fim',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: projetoPrincipalController.projetoPrincipalModel.dataPrevisaoFim,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	projetoPrincipalController.projetoPrincipalModel.dataPrevisaoFim = value;
																	projetoPrincipalController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
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
																dateTime: projetoPrincipalController.projetoPrincipalModel.dataFim,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	projetoPrincipalController.projetoPrincipalModel.dataFim = value;
																	projetoPrincipalController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: projetoPrincipalController.valorOrcamentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Orcamento',
																labelText: 'Valor Orcamento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoPrincipalController.projetoPrincipalModel.valorOrcamento = projetoPrincipalController.valorOrcamentoController.numberValue;
																projetoPrincipalController.formWasChanged = true;
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
															maxLength: 100,
															controller: projetoPrincipalController.linkQuadroKanbanController,
															decoration: inputDecoration(
																hintText: 'Fill with the Link Quadro Kanban',
																labelText: 'Link Quadro Kanban',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoPrincipalController.projetoPrincipalModel.linkQuadroKanban = text;
																projetoPrincipalController.formWasChanged = true;
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
															controller: projetoPrincipalController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoPrincipalController.projetoPrincipalModel.observacao = text;
																projetoPrincipalController.formWasChanged = true;
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
