import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:patrimonio/app/page/shared_widget/shared_widget_imports.dart';
import 'package:patrimonio/app/controller/patrim_documento_bem_controller.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/page/shared_widget/input/input_imports.dart';

class PatrimDocumentoBemEditPage extends StatelessWidget {
	PatrimDocumentoBemEditPage({Key? key}) : super(key: key);
	final patrimDocumentoBemController = Get.find<PatrimDocumentoBemController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: patrimDocumentoBemController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Documentos - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: patrimDocumentoBemController.save),
						cancelAndExitButton(onPressed: patrimDocumentoBemController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: patrimDocumentoBemController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: patrimDocumentoBemController.scrollController,
							child: SingleChildScrollView(
								controller: patrimDocumentoBemController.scrollController,
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
															maxLength: 50,
															controller: patrimDocumentoBemController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimDocumentoBemController.patrimDocumentoBemModel.nome = text;
																patrimDocumentoBemController.formWasChanged = true;
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
															controller: patrimDocumentoBemController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimDocumentoBemController.patrimDocumentoBemModel.descricao = text;
																patrimDocumentoBemController.formWasChanged = true;
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
															controller: patrimDocumentoBemController.imagemController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Imagem',
																labelText: 'Imagem',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimDocumentoBemController.patrimDocumentoBemModel.imagem = text;
																patrimDocumentoBemController.formWasChanged = true;
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
