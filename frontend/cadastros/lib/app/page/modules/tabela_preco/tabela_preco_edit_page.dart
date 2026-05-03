import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/tabela_preco_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class TabelaPrecoEditPage extends StatelessWidget {
	TabelaPrecoEditPage({Key? key}) : super(key: key);
	final tabelaPrecoController = Get.find<TabelaPrecoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					tabelaPrecoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: tabelaPrecoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tabelas de Preço - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: tabelaPrecoController.save),
						cancelAndExitButton(onPressed: tabelaPrecoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: tabelaPrecoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: tabelaPrecoController.scrollController,
							child: SingleChildScrollView(
								controller: tabelaPrecoController.scrollController,
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
															maxLength: 100,
															controller: tabelaPrecoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tabelaPrecoController.tabelaPrecoModel.nome = text;
																tabelaPrecoController.formWasChanged = true;
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
															value: tabelaPrecoController.tabelaPrecoModel.principal ?? 'Sim',
															labelText: 'Principal',
															hintText: 'Informe os dados para o campo Principal',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																tabelaPrecoController.tabelaPrecoModel.principal = newValue;
																tabelaPrecoController.formWasChanged = true;
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
															controller: tabelaPrecoController.coeficienteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Coeficiente',
																labelText: 'Coeficiente',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tabelaPrecoController.tabelaPrecoModel.coeficiente = tabelaPrecoController.coeficienteController.numberValue;
																tabelaPrecoController.formWasChanged = true;
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
