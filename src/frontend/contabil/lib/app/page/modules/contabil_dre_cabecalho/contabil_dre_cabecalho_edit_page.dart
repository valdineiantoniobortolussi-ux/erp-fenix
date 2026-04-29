import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_dre_cabecalho_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class ContabilDreCabecalhoEditPage extends StatelessWidget {
	ContabilDreCabecalhoEditPage({Key? key}) : super(key: key);
	final contabilDreCabecalhoController = Get.find<ContabilDreCabecalhoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: contabilDreCabecalhoController.contabilDreCabecalhoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contabilDreCabecalhoController.contabilDreCabecalhoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contabilDreCabecalhoController.scrollController,
							child: SingleChildScrollView(
								controller: contabilDreCabecalhoController.scrollController,
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
															controller: contabilDreCabecalhoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilDreCabecalhoController.contabilDreCabecalhoModel.descricao = text;
																contabilDreCabecalhoController.formWasChanged = true;
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
															value: contabilDreCabecalhoController.contabilDreCabecalhoModel.padrao ?? 'Sim',
															labelText: 'Padrao',
															hintText: 'Informe os dados para o campo Padrao',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																contabilDreCabecalhoController.contabilDreCabecalhoModel.padrao = newValue;
																contabilDreCabecalhoController.formWasChanged = true;
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
															controller: contabilDreCabecalhoController.periodoInicialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Periodo Inicial',
																labelText: 'Periodo Inicial',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilDreCabecalhoController.contabilDreCabecalhoModel.periodoInicial = text;
																contabilDreCabecalhoController.formWasChanged = true;
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
															controller: contabilDreCabecalhoController.periodoFinalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Periodo Final',
																labelText: 'Periodo Final',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilDreCabecalhoController.contabilDreCabecalhoModel.periodoFinal = text;
																contabilDreCabecalhoController.formWasChanged = true;
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
