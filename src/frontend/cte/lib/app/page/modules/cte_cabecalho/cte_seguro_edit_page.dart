import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_seguro_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteSeguroEditPage extends StatelessWidget {
	CteSeguroEditPage({Key? key}) : super(key: key);
	final cteSeguroController = Get.find<CteSeguroController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: cteSeguroController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Seguro - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteSeguroController.save),
						cancelAndExitButton(onPressed: cteSeguroController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteSeguroController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteSeguroController.scrollController,
							child: SingleChildScrollView(
								controller: cteSeguroController.scrollController,
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
														child: CustomDropdownButtonFormField(
															value: cteSeguroController.cteSeguroModel.responsavel ?? 'AAA',
															labelText: 'Responsavel',
															hintText: 'Informe os dados para o campo Responsavel',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteSeguroController.cteSeguroModel.responsavel = newValue;
																cteSeguroController.formWasChanged = true;
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
															maxLength: 30,
															controller: cteSeguroController.seguradoraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Seguradora',
																labelText: 'Seguradora',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteSeguroController.cteSeguroModel.seguradora = text;
																cteSeguroController.formWasChanged = true;
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
															maxLength: 20,
															controller: cteSeguroController.apoliceController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Apolice',
																labelText: 'Apolice',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteSeguroController.cteSeguroModel.apolice = text;
																cteSeguroController.formWasChanged = true;
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
															maxLength: 20,
															controller: cteSeguroController.averbacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Averbacao',
																labelText: 'Averbacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteSeguroController.cteSeguroModel.averbacao = text;
																cteSeguroController.formWasChanged = true;
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
															controller: cteSeguroController.valorCargaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Carga',
																labelText: 'Valor Carga',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteSeguroController.cteSeguroModel.valorCarga = cteSeguroController.valorCargaController.numberValue;
																cteSeguroController.formWasChanged = true;
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
