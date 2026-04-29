import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:wms/app/page/shared_widget/shared_widget_imports.dart';
import 'package:wms/app/controller/wms_rua_controller.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/page/shared_widget/input/input_imports.dart';

class WmsRuaEditPage extends StatelessWidget {
	WmsRuaEditPage({Key? key}) : super(key: key);
	final wmsRuaController = Get.find<WmsRuaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					wmsRuaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: wmsRuaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Rua - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: wmsRuaController.save),
						cancelAndExitButton(onPressed: wmsRuaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: wmsRuaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: wmsRuaController.scrollController,
							child: SingleChildScrollView(
								controller: wmsRuaController.scrollController,
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
															maxLength: 10,
															controller: wmsRuaController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsRuaController.wmsRuaModel.codigo = text;
																wmsRuaController.formWasChanged = true;
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
															controller: wmsRuaController.quantidadeEstanteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Estante',
																labelText: 'Quantidade Estante',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsRuaController.wmsRuaModel.quantidadeEstante = int.tryParse(text);
																wmsRuaController.formWasChanged = true;
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
															controller: wmsRuaController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsRuaController.wmsRuaModel.nome = text;
																wmsRuaController.formWasChanged = true;
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
