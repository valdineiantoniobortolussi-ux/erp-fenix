import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:etiquetas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:etiquetas/app/controller/etiqueta_template_controller.dart';
import 'package:etiquetas/app/infra/infra_imports.dart';
import 'package:etiquetas/app/page/shared_widget/input/input_imports.dart';

class EtiquetaTemplateEditPage extends StatelessWidget {
	EtiquetaTemplateEditPage({Key? key}) : super(key: key);
	final etiquetaTemplateController = Get.find<EtiquetaTemplateController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: etiquetaTemplateController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Templates - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: etiquetaTemplateController.save),
						cancelAndExitButton(onPressed: etiquetaTemplateController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: etiquetaTemplateController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: etiquetaTemplateController.scrollController,
							child: SingleChildScrollView(
								controller: etiquetaTemplateController.scrollController,
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
															maxLength: 50,
															controller: etiquetaTemplateController.tabelaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Tabela',
																labelText: 'Tabela',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaTemplateController.etiquetaTemplateModel.tabela = text;
																etiquetaTemplateController.formWasChanged = true;
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
															maxLength: 50,
															controller: etiquetaTemplateController.campoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Campo',
																labelText: 'Campo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaTemplateController.etiquetaTemplateModel.campo = text;
																etiquetaTemplateController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: etiquetaTemplateController.etiquetaTemplateModel.formato ?? '0=EAN',
															labelText: 'Formato',
															hintText: 'Informe os dados para o campo Formato',
															items: const ['0=EAN','1=QR Code'],
															onChanged: (dynamic newValue) {
																etiquetaTemplateController.etiquetaTemplateModel.formato = newValue;
																etiquetaTemplateController.formWasChanged = true;
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
															controller: etiquetaTemplateController.quantidadeRepeticoesController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Repeticoes',
																labelText: 'Quantidade Repeticoes',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaTemplateController.etiquetaTemplateModel.quantidadeRepeticoes = int.tryParse(text);
																etiquetaTemplateController.formWasChanged = true;
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
															controller: etiquetaTemplateController.filtroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Filtro',
																labelText: 'Filtro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																etiquetaTemplateController.etiquetaTemplateModel.filtro = text;
																etiquetaTemplateController.formWasChanged = true;
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
