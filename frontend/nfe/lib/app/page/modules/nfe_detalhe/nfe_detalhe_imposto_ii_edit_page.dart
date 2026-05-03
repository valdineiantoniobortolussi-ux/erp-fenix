import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_detalhe_imposto_ii_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeDetalheImpostoIiEditPage extends StatelessWidget {
	NfeDetalheImpostoIiEditPage({Key? key}) : super(key: key);
	final nfeDetalheImpostoIiController = Get.find<NfeDetalheImpostoIiController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeDetalheImpostoIiController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Imposto Importação - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeDetalheImpostoIiController.save),
						cancelAndExitButton(onPressed: nfeDetalheImpostoIiController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeDetalheImpostoIiController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeDetalheImpostoIiController.scrollController,
							child: SingleChildScrollView(
								controller: nfeDetalheImpostoIiController.scrollController,
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
															controller: nfeDetalheImpostoIiController.valorBcIiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Ii',
																labelText: 'Valor Bc Ii',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIiController.nfeDetalheImpostoIiModel.valorBcIi = nfeDetalheImpostoIiController.valorBcIiController.numberValue;
																nfeDetalheImpostoIiController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIiController.valorDespesasAduaneirasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Despesas Aduaneiras',
																labelText: 'Valor Despesas Aduaneiras',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIiController.nfeDetalheImpostoIiModel.valorDespesasAduaneiras = nfeDetalheImpostoIiController.valorDespesasAduaneirasController.numberValue;
																nfeDetalheImpostoIiController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIiController.valorImpostoImportacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Imposto Importacao',
																labelText: 'Valor Imposto Importacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIiController.nfeDetalheImpostoIiModel.valorImpostoImportacao = nfeDetalheImpostoIiController.valorImpostoImportacaoController.numberValue;
																nfeDetalheImpostoIiController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIiController.valorIofController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Iof',
																labelText: 'Valor Iof',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIiController.nfeDetalheImpostoIiModel.valorIof = nfeDetalheImpostoIiController.valorIofController.numberValue;
																nfeDetalheImpostoIiController.formWasChanged = true;
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
