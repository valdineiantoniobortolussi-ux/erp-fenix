import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:etiquetas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:etiquetas/app/controller/etiqueta_layout_controller.dart';
import 'package:etiquetas/app/infra/infra_imports.dart';
import 'package:etiquetas/app/page/shared_widget/input/input_imports.dart';

class EtiquetaLayoutEditPage extends StatelessWidget {
	EtiquetaLayoutEditPage({Key? key}) : super(key: key);
	final etiquetaLayoutController = Get.find<EtiquetaLayoutController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: etiquetaLayoutController.etiquetaLayoutEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: etiquetaLayoutController.etiquetaLayoutEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: etiquetaLayoutController.scrollController,
							child: SingleChildScrollView(
								controller: etiquetaLayoutController.scrollController,
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
																		controller: etiquetaLayoutController.etiquetaFormatoPapelModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Formato Papel',
																			labelText: 'Formato Papel *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: etiquetaLayoutController.callEtiquetaFormatoPapelLookup),
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
															maxLength: 50,
															controller: etiquetaLayoutController.codigoFabricanteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Fabricante',
																labelText: 'Codigo Fabricante',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaLayoutController.etiquetaLayoutModel.codigoFabricante = text;
																etiquetaLayoutController.formWasChanged = true;
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
															controller: etiquetaLayoutController.quantidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade',
																labelText: 'Quantidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaLayoutController.etiquetaLayoutModel.quantidade = int.tryParse(text);
																etiquetaLayoutController.formWasChanged = true;
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
															controller: etiquetaLayoutController.quantidadeHorizontalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Horizontal',
																labelText: 'Quantidade Horizontal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaLayoutController.etiquetaLayoutModel.quantidadeHorizontal = int.tryParse(text);
																etiquetaLayoutController.formWasChanged = true;
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
															controller: etiquetaLayoutController.quantidadeVerticalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Vertical',
																labelText: 'Quantidade Vertical',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaLayoutController.etiquetaLayoutModel.quantidadeVertical = int.tryParse(text);
																etiquetaLayoutController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: etiquetaLayoutController.margemSuperiorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Margem Superior',
																labelText: 'Margem Superior',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaLayoutController.etiquetaLayoutModel.margemSuperior = int.tryParse(text);
																etiquetaLayoutController.formWasChanged = true;
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
															controller: etiquetaLayoutController.margemInferiorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Margem Inferior',
																labelText: 'Margem Inferior',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaLayoutController.etiquetaLayoutModel.margemInferior = int.tryParse(text);
																etiquetaLayoutController.formWasChanged = true;
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
															controller: etiquetaLayoutController.margemEsquerdaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Margem Esquerda',
																labelText: 'Margem Esquerda',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaLayoutController.etiquetaLayoutModel.margemEsquerda = int.tryParse(text);
																etiquetaLayoutController.formWasChanged = true;
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
															controller: etiquetaLayoutController.margemDireitaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Margem Direita',
																labelText: 'Margem Direita',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaLayoutController.etiquetaLayoutModel.margemDireita = int.tryParse(text);
																etiquetaLayoutController.formWasChanged = true;
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: etiquetaLayoutController.espacamentoHorizontalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Espacamento Horizontal',
																labelText: 'Espacamento Horizontal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaLayoutController.etiquetaLayoutModel.espacamentoHorizontal = int.tryParse(text);
																etiquetaLayoutController.formWasChanged = true;
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
															controller: etiquetaLayoutController.espacamentoVerticalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Espacamento Vertical',
																labelText: 'Espacamento Vertical',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaLayoutController.etiquetaLayoutModel.espacamentoVertical = int.tryParse(text);
																etiquetaLayoutController.formWasChanged = true;
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
