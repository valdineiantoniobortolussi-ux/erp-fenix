import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:projetos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:projetos/app/controller/projeto_risco_controller.dart';
import 'package:projetos/app/infra/infra_imports.dart';
import 'package:projetos/app/page/shared_widget/input/input_imports.dart';

class ProjetoRiscoEditPage extends StatelessWidget {
	ProjetoRiscoEditPage({Key? key}) : super(key: key);
	final projetoRiscoController = Get.find<ProjetoRiscoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: projetoRiscoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Riscos - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: projetoRiscoController.save),
						cancelAndExitButton(onPressed: projetoRiscoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: projetoRiscoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: projetoRiscoController.scrollController,
							child: SingleChildScrollView(
								controller: projetoRiscoController.scrollController,
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
															controller: projetoRiscoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoRiscoController.projetoRiscoModel.nome = text;
																projetoRiscoController.formWasChanged = true;
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
															controller: projetoRiscoController.probabilidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Probabilidade',
																labelText: 'Probabilidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoRiscoController.projetoRiscoModel.probabilidade = int.tryParse(text);
																projetoRiscoController.formWasChanged = true;
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
															controller: projetoRiscoController.impactoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Impacto',
																labelText: 'Impacto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoRiscoController.projetoRiscoModel.impacto = int.tryParse(text);
																projetoRiscoController.formWasChanged = true;
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
															controller: projetoRiscoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																projetoRiscoController.projetoRiscoModel.descricao = text;
																projetoRiscoController.formWasChanged = true;
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
