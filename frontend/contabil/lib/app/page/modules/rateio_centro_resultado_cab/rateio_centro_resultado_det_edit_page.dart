import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/rateio_centro_resultado_det_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class RateioCentroResultadoDetEditPage extends StatelessWidget {
	RateioCentroResultadoDetEditPage({Key? key}) : super(key: key);
	final rateioCentroResultadoDetController = Get.find<RateioCentroResultadoDetController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: rateioCentroResultadoDetController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Detalhes - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: rateioCentroResultadoDetController.save),
						cancelAndExitButton(onPressed: rateioCentroResultadoDetController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: rateioCentroResultadoDetController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: rateioCentroResultadoDetController.scrollController,
							child: SingleChildScrollView(
								controller: rateioCentroResultadoDetController.scrollController,
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
																		controller: rateioCentroResultadoDetController.centroResultadoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Centro Resultado Destino',
																			labelText: 'Centro Resultado Destino *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: rateioCentroResultadoDetController.callCentroResultadoLookup),
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: rateioCentroResultadoDetController.porcentoRateioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porcento Rateio',
																labelText: 'Porcento Rateio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																rateioCentroResultadoDetController.rateioCentroResultadoDetModel.porcentoRateio = rateioCentroResultadoDetController.porcentoRateioController.numberValue;
																rateioCentroResultadoDetController.formWasChanged = true;
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
