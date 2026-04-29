import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_aquaviario_balsa_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteAquaviarioBalsaEditPage extends StatelessWidget {
	CteAquaviarioBalsaEditPage({Key? key}) : super(key: key);
	final cteAquaviarioBalsaController = Get.find<CteAquaviarioBalsaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					cteAquaviarioBalsaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: cteAquaviarioBalsaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Cte Aquaviario Balsa - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteAquaviarioBalsaController.save),
						cancelAndExitButton(onPressed: cteAquaviarioBalsaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteAquaviarioBalsaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteAquaviarioBalsaController.scrollController,
							child: SingleChildScrollView(
								controller: cteAquaviarioBalsaController.scrollController,
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
																		controller: cteAquaviarioBalsaController.cteAquaviarioModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Cte Aquaviario',
																			labelText: 'Id Cte Aquaviario *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: cteAquaviarioBalsaController.callCteAquaviarioLookup),
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
															maxLength: 60,
															controller: cteAquaviarioBalsaController.idBalsaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Balsa',
																labelText: 'Id Balsa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAquaviarioBalsaController.cteAquaviarioBalsaModel.idBalsa = text;
																cteAquaviarioBalsaController.formWasChanged = true;
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
															controller: cteAquaviarioBalsaController.numeroViagemController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Viagem',
																labelText: 'Numero Viagem',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAquaviarioBalsaController.cteAquaviarioBalsaModel.numeroViagem = int.tryParse(text);
																cteAquaviarioBalsaController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: cteAquaviarioBalsaController.cteAquaviarioBalsaModel.direcao ?? 'AAA',
															labelText: 'Direcao',
															hintText: 'Informe os dados para o campo Direcao',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteAquaviarioBalsaController.cteAquaviarioBalsaModel.direcao = newValue;
																cteAquaviarioBalsaController.formWasChanged = true;
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
															controller: cteAquaviarioBalsaController.portoEmbarqueController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porto Embarque',
																labelText: 'Porto Embarque',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAquaviarioBalsaController.cteAquaviarioBalsaModel.portoEmbarque = text;
																cteAquaviarioBalsaController.formWasChanged = true;
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
															controller: cteAquaviarioBalsaController.portoTransbordoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porto Transbordo',
																labelText: 'Porto Transbordo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAquaviarioBalsaController.cteAquaviarioBalsaModel.portoTransbordo = text;
																cteAquaviarioBalsaController.formWasChanged = true;
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
															controller: cteAquaviarioBalsaController.portoDestinoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porto Destino',
																labelText: 'Porto Destino',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAquaviarioBalsaController.cteAquaviarioBalsaModel.portoDestino = text;
																cteAquaviarioBalsaController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: cteAquaviarioBalsaController.cteAquaviarioBalsaModel.tipoNavegacao ?? 'AAA',
															labelText: 'Tipo Navegacao',
															hintText: 'Informe os dados para o campo Tipo Navegacao',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteAquaviarioBalsaController.cteAquaviarioBalsaModel.tipoNavegacao = newValue;
																cteAquaviarioBalsaController.formWasChanged = true;
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
															controller: cteAquaviarioBalsaController.irinController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Irin',
																labelText: 'Irin',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteAquaviarioBalsaController.cteAquaviarioBalsaModel.irin = text;
																cteAquaviarioBalsaController.formWasChanged = true;
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
			),
		);
	}
}
