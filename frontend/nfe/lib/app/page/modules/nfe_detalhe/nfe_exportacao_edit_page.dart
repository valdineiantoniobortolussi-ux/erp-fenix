import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_exportacao_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeExportacaoEditPage extends StatelessWidget {
	NfeExportacaoEditPage({Key? key}) : super(key: key);
	final nfeExportacaoController = Get.find<NfeExportacaoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeExportacaoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Exportacao - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeExportacaoController.save),
						cancelAndExitButton(onPressed: nfeExportacaoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeExportacaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeExportacaoController.scrollController,
							child: SingleChildScrollView(
								controller: nfeExportacaoController.scrollController,
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
															controller: nfeExportacaoController.drawbackController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Drawback',
																labelText: 'Drawback',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeExportacaoController.nfeExportacaoModel.drawback = int.tryParse(text);
																nfeExportacaoController.formWasChanged = true;
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
															controller: nfeExportacaoController.numeroRegistroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Registro',
																labelText: 'Numero Registro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeExportacaoController.nfeExportacaoModel.numeroRegistro = int.tryParse(text);
																nfeExportacaoController.formWasChanged = true;
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
															maxLength: 44,
															controller: nfeExportacaoController.chaveAcessoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Chave Acesso',
																labelText: 'Chave Acesso',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeExportacaoController.nfeExportacaoModel.chaveAcesso = text;
																nfeExportacaoController.formWasChanged = true;
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
															controller: nfeExportacaoController.quantidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade',
																labelText: 'Quantidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeExportacaoController.nfeExportacaoModel.quantidade = nfeExportacaoController.quantidadeController.numberValue;
																nfeExportacaoController.formWasChanged = true;
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
