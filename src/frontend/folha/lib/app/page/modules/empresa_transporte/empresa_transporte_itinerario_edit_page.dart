import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/empresa_transporte_itinerario_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class EmpresaTransporteItinerarioEditPage extends StatelessWidget {
	EmpresaTransporteItinerarioEditPage({Key? key}) : super(key: key);
	final empresaTransporteItinerarioController = Get.find<EmpresaTransporteItinerarioController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: empresaTransporteItinerarioController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Itinerario - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: empresaTransporteItinerarioController.save),
						cancelAndExitButton(onPressed: empresaTransporteItinerarioController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: empresaTransporteItinerarioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: empresaTransporteItinerarioController.scrollController,
							child: SingleChildScrollView(
								controller: empresaTransporteItinerarioController.scrollController,
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
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: empresaTransporteItinerarioController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaTransporteItinerarioController.empresaTransporteItinerarioModel.nome = text;
																empresaTransporteItinerarioController.formWasChanged = true;
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
															controller: empresaTransporteItinerarioController.tarifaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Tarifa',
																labelText: 'Tarifa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaTransporteItinerarioController.empresaTransporteItinerarioModel.tarifa = empresaTransporteItinerarioController.tarifaController.numberValue;
																empresaTransporteItinerarioController.formWasChanged = true;
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
															controller: empresaTransporteItinerarioController.trajetoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Trajeto',
																labelText: 'Trajeto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaTransporteItinerarioController.empresaTransporteItinerarioModel.trajeto = text;
																empresaTransporteItinerarioController.formWasChanged = true;
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
