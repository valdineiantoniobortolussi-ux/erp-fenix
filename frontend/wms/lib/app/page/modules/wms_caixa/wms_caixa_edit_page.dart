import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:wms/app/page/shared_widget/shared_widget_imports.dart';
import 'package:wms/app/controller/wms_caixa_controller.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/page/shared_widget/input/input_imports.dart';

class WmsCaixaEditPage extends StatelessWidget {
	WmsCaixaEditPage({Key? key}) : super(key: key);
	final wmsCaixaController = Get.find<WmsCaixaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: wmsCaixaController.wmsCaixaEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: wmsCaixaController.wmsCaixaEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: wmsCaixaController.scrollController,
							child: SingleChildScrollView(
								controller: wmsCaixaController.scrollController,
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
																		controller: wmsCaixaController.wmsEstanteModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Estante',
																			labelText: 'Estante *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: wmsCaixaController.callWmsEstanteLookup),
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 10,
															controller: wmsCaixaController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsCaixaController.wmsCaixaModel.codigo = text;
																wmsCaixaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: wmsCaixaController.alturaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Altura',
																labelText: 'Altura',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsCaixaController.wmsCaixaModel.altura = int.tryParse(text);
																wmsCaixaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: wmsCaixaController.larguraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Largura',
																labelText: 'Largura',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsCaixaController.wmsCaixaModel.largura = int.tryParse(text);
																wmsCaixaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: wmsCaixaController.profundidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Profundidade',
																labelText: 'Profundidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsCaixaController.wmsCaixaModel.profundidade = int.tryParse(text);
																wmsCaixaController.formWasChanged = true;
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
