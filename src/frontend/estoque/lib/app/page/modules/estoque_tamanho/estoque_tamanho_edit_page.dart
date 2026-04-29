import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:estoque/app/page/shared_widget/shared_widget_imports.dart';
import 'package:estoque/app/controller/estoque_tamanho_controller.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/page/shared_widget/input/input_imports.dart';

class EstoqueTamanhoEditPage extends StatelessWidget {
	EstoqueTamanhoEditPage({Key? key}) : super(key: key);
	final estoqueTamanhoController = Get.find<EstoqueTamanhoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					estoqueTamanhoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: estoqueTamanhoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tamanhos - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: estoqueTamanhoController.save),
						cancelAndExitButton(onPressed: estoqueTamanhoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: estoqueTamanhoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: estoqueTamanhoController.scrollController,
							child: SingleChildScrollView(
								controller: estoqueTamanhoController.scrollController,
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
															maxLength: 4,
															controller: estoqueTamanhoController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																estoqueTamanhoController.estoqueTamanhoModel.codigo = text;
																estoqueTamanhoController.formWasChanged = true;
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
															controller: estoqueTamanhoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																estoqueTamanhoController.estoqueTamanhoModel.nome = text;
																estoqueTamanhoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: estoqueTamanhoController.alturaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Altura',
																labelText: 'Altura',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																estoqueTamanhoController.estoqueTamanhoModel.altura = estoqueTamanhoController.alturaController.numberValue;
																estoqueTamanhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: estoqueTamanhoController.comprimentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Comprimento',
																labelText: 'Comprimento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																estoqueTamanhoController.estoqueTamanhoModel.comprimento = estoqueTamanhoController.comprimentoController.numberValue;
																estoqueTamanhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: estoqueTamanhoController.larguraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Largura',
																labelText: 'Largura',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																estoqueTamanhoController.estoqueTamanhoModel.largura = estoqueTamanhoController.larguraController.numberValue;
																estoqueTamanhoController.formWasChanged = true;
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
