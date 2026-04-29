import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:vendas/app/controller/venda_condicoes_pagamento_controller.dart';
import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/page/shared_widget/input/input_imports.dart';

class VendaCondicoesPagamentoEditPage extends StatelessWidget {
	VendaCondicoesPagamentoEditPage({Key? key}) : super(key: key);
	final vendaCondicoesPagamentoController = Get.find<VendaCondicoesPagamentoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: vendaCondicoesPagamentoController.vendaCondicoesPagamentoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: vendaCondicoesPagamentoController.vendaCondicoesPagamentoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: vendaCondicoesPagamentoController.scrollController,
							child: SingleChildScrollView(
								controller: vendaCondicoesPagamentoController.scrollController,
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
															controller: vendaCondicoesPagamentoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCondicoesPagamentoController.vendaCondicoesPagamentoModel.nome = text;
																vendaCondicoesPagamentoController.formWasChanged = true;
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
															controller: vendaCondicoesPagamentoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCondicoesPagamentoController.vendaCondicoesPagamentoModel.descricao = text;
																vendaCondicoesPagamentoController.formWasChanged = true;
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
															controller: vendaCondicoesPagamentoController.faturamentoMinimoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Faturamento Minimo',
																labelText: 'Faturamento Minimo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCondicoesPagamentoController.vendaCondicoesPagamentoModel.faturamentoMinimo = vendaCondicoesPagamentoController.faturamentoMinimoController.numberValue;
																vendaCondicoesPagamentoController.formWasChanged = true;
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
															controller: vendaCondicoesPagamentoController.faturamentoMaximoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Faturamento Maximo',
																labelText: 'Faturamento Maximo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCondicoesPagamentoController.vendaCondicoesPagamentoModel.faturamentoMaximo = vendaCondicoesPagamentoController.faturamentoMaximoController.numberValue;
																vendaCondicoesPagamentoController.formWasChanged = true;
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
															controller: vendaCondicoesPagamentoController.indiceCorrecaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Indice Correcao',
																labelText: 'Indice Correcao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCondicoesPagamentoController.vendaCondicoesPagamentoModel.indiceCorrecao = vendaCondicoesPagamentoController.indiceCorrecaoController.numberValue;
																vendaCondicoesPagamentoController.formWasChanged = true;
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
															controller: vendaCondicoesPagamentoController.diasToleranciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dias Tolerancia',
																labelText: 'Dias Tolerancia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCondicoesPagamentoController.vendaCondicoesPagamentoModel.diasTolerancia = int.tryParse(text);
																vendaCondicoesPagamentoController.formWasChanged = true;
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
															controller: vendaCondicoesPagamentoController.valorToleranciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Tolerancia',
																labelText: 'Valor Tolerancia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCondicoesPagamentoController.vendaCondicoesPagamentoModel.valorTolerancia = vendaCondicoesPagamentoController.valorToleranciaController.numberValue;
																vendaCondicoesPagamentoController.formWasChanged = true;
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
															controller: vendaCondicoesPagamentoController.prazoMedioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Prazo Medio',
																labelText: 'Prazo Medio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCondicoesPagamentoController.vendaCondicoesPagamentoModel.prazoMedio = int.tryParse(text);
																vendaCondicoesPagamentoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: vendaCondicoesPagamentoController.vendaCondicoesPagamentoModel.vistaPrazo ?? 'A Vista',
															labelText: 'Vista ou Prazo',
															hintText: 'Informe os dados para o campo Vista ou Prazo',
															items: const ['A Vista','A Prazo'],
															onChanged: (dynamic newValue) {
																vendaCondicoesPagamentoController.vendaCondicoesPagamentoModel.vistaPrazo = newValue;
																vendaCondicoesPagamentoController.formWasChanged = true;
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
