import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_perigoso_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CtePerigosoEditPage extends StatelessWidget {
	CtePerigosoEditPage({Key? key}) : super(key: key);
	final ctePerigosoController = Get.find<CtePerigosoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: ctePerigosoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Perigoso - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: ctePerigosoController.save),
						cancelAndExitButton(onPressed: ctePerigosoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: ctePerigosoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: ctePerigosoController.scrollController,
							child: SingleChildScrollView(
								controller: ctePerigosoController.scrollController,
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
															maxLength: 4,
															controller: ctePerigosoController.numeroOnuController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Onu',
																labelText: 'Numero Onu',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ctePerigosoController.ctePerigosoModel.numeroOnu = text;
																ctePerigosoController.formWasChanged = true;
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
															maxLength: 150,
															controller: ctePerigosoController.nomeApropriadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Apropriado',
																labelText: 'Nome Apropriado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ctePerigosoController.ctePerigosoModel.nomeApropriado = text;
																ctePerigosoController.formWasChanged = true;
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
															maxLength: 40,
															controller: ctePerigosoController.classeRiscoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Classe Risco',
																labelText: 'Classe Risco',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ctePerigosoController.ctePerigosoModel.classeRisco = text;
																ctePerigosoController.formWasChanged = true;
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
															maxLength: 6,
															controller: ctePerigosoController.grupoEmbalagemController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Grupo Embalagem',
																labelText: 'Grupo Embalagem',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ctePerigosoController.ctePerigosoModel.grupoEmbalagem = text;
																ctePerigosoController.formWasChanged = true;
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
															maxLength: 20,
															controller: ctePerigosoController.quantidadeTotalProdutoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Total Produto',
																labelText: 'Quantidade Total Produto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ctePerigosoController.ctePerigosoModel.quantidadeTotalProduto = text;
																ctePerigosoController.formWasChanged = true;
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
															controller: ctePerigosoController.quantidadeTipoVolumeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Tipo Volume',
																labelText: 'Quantidade Tipo Volume',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ctePerigosoController.ctePerigosoModel.quantidadeTipoVolume = text;
																ctePerigosoController.formWasChanged = true;
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
															maxLength: 6,
															controller: ctePerigosoController.pontoFulgorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ponto Fulgor',
																labelText: 'Ponto Fulgor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ctePerigosoController.ctePerigosoModel.pontoFulgor = text;
																ctePerigosoController.formWasChanged = true;
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
