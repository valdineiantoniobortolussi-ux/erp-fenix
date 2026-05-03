import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/folha_inss_retencao_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FolhaInssRetencaoEditPage extends StatelessWidget {
	FolhaInssRetencaoEditPage({Key? key}) : super(key: key);
	final folhaInssRetencaoController = Get.find<FolhaInssRetencaoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: folhaInssRetencaoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Retenções - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: folhaInssRetencaoController.save),
						cancelAndExitButton(onPressed: folhaInssRetencaoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: folhaInssRetencaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: folhaInssRetencaoController.scrollController,
							child: SingleChildScrollView(
								controller: folhaInssRetencaoController.scrollController,
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
																		controller: folhaInssRetencaoController.folhaInssServicoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Serviço INSS',
																			labelText: 'Serviço INSS *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: folhaInssRetencaoController.callFolhaInssServicoLookup),
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
														child: TextFormField(
															autofocus: true,
															controller: folhaInssRetencaoController.valorMensalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Mensal',
																labelText: 'Valor Mensal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaInssRetencaoController.folhaInssRetencaoModel.valorMensal = folhaInssRetencaoController.valorMensalController.numberValue;
																folhaInssRetencaoController.formWasChanged = true;
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
															controller: folhaInssRetencaoController.valor13Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor 13',
																labelText: 'Valor 13',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaInssRetencaoController.folhaInssRetencaoModel.valor13 = folhaInssRetencaoController.valor13Controller.numberValue;
																folhaInssRetencaoController.formWasChanged = true;
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
