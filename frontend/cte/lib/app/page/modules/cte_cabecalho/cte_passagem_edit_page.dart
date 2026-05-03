import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_passagem_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CtePassagemEditPage extends StatelessWidget {
	CtePassagemEditPage({Key? key}) : super(key: key);
	final ctePassagemController = Get.find<CtePassagemController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: ctePassagemController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Passagem - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: ctePassagemController.save),
						cancelAndExitButton(onPressed: ctePassagemController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: ctePassagemController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: ctePassagemController.scrollController,
							child: SingleChildScrollView(
								controller: ctePassagemController.scrollController,
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
															maxLength: 15,
															controller: ctePassagemController.siglaPassagemController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Sigla Passagem',
																labelText: 'Sigla Passagem',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ctePassagemController.ctePassagemModel.siglaPassagem = text;
																ctePassagemController.formWasChanged = true;
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
															maxLength: 15,
															controller: ctePassagemController.siglaDestinoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Sigla Destino',
																labelText: 'Sigla Destino',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ctePassagemController.ctePassagemModel.siglaDestino = text;
																ctePassagemController.formWasChanged = true;
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
															maxLength: 10,
															controller: ctePassagemController.rotaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Rota',
																labelText: 'Rota',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ctePassagemController.ctePassagemModel.rota = text;
																ctePassagemController.formWasChanged = true;
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
