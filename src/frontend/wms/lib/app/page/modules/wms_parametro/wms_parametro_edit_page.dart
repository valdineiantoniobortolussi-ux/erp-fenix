import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:wms/app/page/shared_widget/shared_widget_imports.dart';
import 'package:wms/app/controller/wms_parametro_controller.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/page/shared_widget/input/input_imports.dart';

class WmsParametroEditPage extends StatelessWidget {
	WmsParametroEditPage({Key? key}) : super(key: key);
	final wmsParametroController = Get.find<WmsParametroController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					wmsParametroController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: wmsParametroController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Parâmetros - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: wmsParametroController.save),
						cancelAndExitButton(onPressed: wmsParametroController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: wmsParametroController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: wmsParametroController.scrollController,
							child: SingleChildScrollView(
								controller: wmsParametroController.scrollController,
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
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: wmsParametroController.horaPorVolumeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Por Volume',
																labelText: 'Hora Por Volume',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsParametroController.wmsParametroModel.horaPorVolume = int.tryParse(text);
																wmsParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: wmsParametroController.pessoaPorVolumeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Pessoa Por Volume',
																labelText: 'Pessoa Por Volume',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsParametroController.wmsParametroModel.pessoaPorVolume = int.tryParse(text);
																wmsParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: wmsParametroController.horaPorPesoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Hora Por Peso',
																labelText: 'Hora Por Peso',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsParametroController.wmsParametroModel.horaPorPeso = int.tryParse(text);
																wmsParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: wmsParametroController.pessoaPorPesoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Pessoa Por Peso',
																labelText: 'Pessoa Por Peso',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsParametroController.wmsParametroModel.pessoaPorPeso = int.tryParse(text);
																wmsParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: wmsParametroController.wmsParametroModel.itemDiferenteCaixa ?? 'S',
															labelText: 'Item Diferente Caixa',
															hintText: 'Informe os dados para o campo Item Diferente Caixa',
															items: const ['S','N'],
															onChanged: (dynamic newValue) {
																wmsParametroController.wmsParametroModel.itemDiferenteCaixa = newValue;
																wmsParametroController.formWasChanged = true;
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
