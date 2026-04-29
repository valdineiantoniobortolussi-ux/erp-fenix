import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/produto_unidade_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class ProdutoUnidadeEditPage extends StatelessWidget {
	ProdutoUnidadeEditPage({Key? key}) : super(key: key);
	final produtoUnidadeController = Get.find<ProdutoUnidadeController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					produtoUnidadeController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: produtoUnidadeController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Unidade Produto - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: produtoUnidadeController.save),
						cancelAndExitButton(onPressed: produtoUnidadeController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: produtoUnidadeController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: produtoUnidadeController.scrollController,
							child: SingleChildScrollView(
								controller: produtoUnidadeController.scrollController,
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
															controller: produtoUnidadeController.siglaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Sigla',
																labelText: 'Sigla',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																produtoUnidadeController.produtoUnidadeModel.sigla = text;
																produtoUnidadeController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: produtoUnidadeController.produtoUnidadeModel.podeFracionar ?? 'Sim',
															labelText: 'Pode Fracionar',
															hintText: 'Informe os dados para o campo Pode Fracionar',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																produtoUnidadeController.produtoUnidadeModel.podeFracionar = newValue;
																produtoUnidadeController.formWasChanged = true;
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
															maxLength: 250,
															maxLines: 3,
															controller: produtoUnidadeController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																produtoUnidadeController.produtoUnidadeModel.descricao = text;
																produtoUnidadeController.formWasChanged = true;
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
