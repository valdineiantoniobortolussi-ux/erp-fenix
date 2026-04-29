import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_livro_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class ContabilLivroEditPage extends StatelessWidget {
	ContabilLivroEditPage({Key? key}) : super(key: key);
	final contabilLivroController = Get.find<ContabilLivroController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: contabilLivroController.contabilLivroEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contabilLivroController.contabilLivroEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contabilLivroController.scrollController,
							child: SingleChildScrollView(
								controller: contabilLivroController.scrollController,
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
														child: TextFormField(
															autofocus: true,
															controller: contabilLivroController.competenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Competencia',
																labelText: 'Competencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLivroController.contabilLivroModel.competencia = text;
																contabilLivroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilLivroController.contabilLivroModel.formaEscrituracao ?? 'Diário Geral',
															labelText: 'Forma Escrituracao',
															hintText: 'Informe os dados para o campo Forma Escrituracao',
															items: const ['Diário Geral','Diário com Escrituração Resumida','Diário Auxiliar','Razão Auxiliar','Livro de Balancetes Diários e Balanços'],
															onChanged: (dynamic newValue) {
																contabilLivroController.contabilLivroModel.formaEscrituracao = newValue;
																contabilLivroController.formWasChanged = true;
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
															controller: contabilLivroController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLivroController.contabilLivroModel.descricao = text;
																contabilLivroController.formWasChanged = true;
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
