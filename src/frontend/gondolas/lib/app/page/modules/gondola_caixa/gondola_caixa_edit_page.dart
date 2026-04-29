import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:gondolas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:gondolas/app/controller/gondola_caixa_controller.dart';
import 'package:gondolas/app/infra/infra_imports.dart';
import 'package:gondolas/app/page/shared_widget/input/input_imports.dart';

class GondolaCaixaEditPage extends StatelessWidget {
	GondolaCaixaEditPage({Key? key}) : super(key: key);
	final gondolaCaixaController = Get.find<GondolaCaixaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: gondolaCaixaController.gondolaCaixaEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: gondolaCaixaController.gondolaCaixaEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: gondolaCaixaController.scrollController,
							child: SingleChildScrollView(
								controller: gondolaCaixaController.scrollController,
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
																		controller: gondolaCaixaController.gondolaEstanteModelController,
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
																child: lookupButton(onPressed: gondolaCaixaController.callGondolaEstanteLookup),
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
															controller: gondolaCaixaController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gondolaCaixaController.gondolaCaixaModel.codigo = text;
																gondolaCaixaController.formWasChanged = true;
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
															controller: gondolaCaixaController.alturaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Altura',
																labelText: 'Altura',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gondolaCaixaController.gondolaCaixaModel.altura = int.tryParse(text);
																gondolaCaixaController.formWasChanged = true;
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
															controller: gondolaCaixaController.larguraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Largura',
																labelText: 'Largura',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gondolaCaixaController.gondolaCaixaModel.largura = int.tryParse(text);
																gondolaCaixaController.formWasChanged = true;
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
															controller: gondolaCaixaController.profundidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Profundidade',
																labelText: 'Profundidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gondolaCaixaController.gondolaCaixaModel.profundidade = int.tryParse(text);
																gondolaCaixaController.formWasChanged = true;
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
