import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_aquaviario_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteAquaviarioEditPage extends StatelessWidget {
	CteAquaviarioEditPage({Key? key}) : super(key: key);
	final cteAquaviarioController = Get.find<CteAquaviarioController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: cteAquaviarioController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Aquaviário - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteAquaviarioController.save),
						cancelAndExitButton(onPressed: cteAquaviarioController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteAquaviarioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteAquaviarioController.scrollController,
							child: SingleChildScrollView(
								controller: cteAquaviarioController.scrollController,
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
															controller: cteAquaviarioController.valorPrestacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Prestacao',
																labelText: 'Valor Prestacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAquaviarioController.cteAquaviarioModel.valorPrestacao = cteAquaviarioController.valorPrestacaoController.numberValue;
																cteAquaviarioController.formWasChanged = true;
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
															controller: cteAquaviarioController.afrmmController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Afrmm',
																labelText: 'Afrmm',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAquaviarioController.cteAquaviarioModel.afrmm = cteAquaviarioController.afrmmController.numberValue;
																cteAquaviarioController.formWasChanged = true;
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
															controller: cteAquaviarioController.numeroBookingController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Booking',
																labelText: 'Numero Booking',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAquaviarioController.cteAquaviarioModel.numeroBooking = text;
																cteAquaviarioController.formWasChanged = true;
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
															controller: cteAquaviarioController.numeroControleController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Controle',
																labelText: 'Numero Controle',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAquaviarioController.cteAquaviarioModel.numeroControle = text;
																cteAquaviarioController.formWasChanged = true;
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
															maxLength: 60,
															controller: cteAquaviarioController.idNavioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Navio',
																labelText: 'Id Navio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAquaviarioController.cteAquaviarioModel.idNavio = text;
																cteAquaviarioController.formWasChanged = true;
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
