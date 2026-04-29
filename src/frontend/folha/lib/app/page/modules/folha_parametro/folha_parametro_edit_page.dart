import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/folha_parametro_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FolhaParametroEditPage extends StatelessWidget {
	FolhaParametroEditPage({Key? key}) : super(key: key);
	final folhaParametroController = Get.find<FolhaParametroController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					folhaParametroController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: folhaParametroController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Parâmetros - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: folhaParametroController.save),
						cancelAndExitButton(onPressed: folhaParametroController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: folhaParametroController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: folhaParametroController.scrollController,
							child: SingleChildScrollView(
								controller: folhaParametroController.scrollController,
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
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: folhaParametroController.competenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Competencia',
																labelText: 'Competencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaParametroController.folhaParametroModel.competencia = text;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaParametroController.folhaParametroModel.contribuiPis ?? 'Sim',
															labelText: 'Contribui Pis',
															hintText: 'Informe os dados para o campo Contribui Pis',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaParametroController.folhaParametroModel.contribuiPis = newValue;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: folhaParametroController.aliquotaPisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Pis',
																labelText: 'Aliquota Pis',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaParametroController.folhaParametroModel.aliquotaPis = folhaParametroController.aliquotaPisController.numberValue;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaParametroController.folhaParametroModel.discriminarDsr ?? 'Sim',
															labelText: 'Discriminar Dsr',
															hintText: 'Informe os dados para o campo Discriminar Dsr',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaParametroController.folhaParametroModel.discriminarDsr = newValue;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 2,
															controller: folhaParametroController.diaPagamentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dia Pagamento',
																labelText: 'Dia Pagamento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaParametroController.folhaParametroModel.diaPagamento = text;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaParametroController.folhaParametroModel.calculoProporcionalidade ?? '30 Dias',
															labelText: 'Calculo Proporcionalidade',
															hintText: 'Informe os dados para o campo Calculo Proporcionalidade',
															items: const ['30 Dias','Conforme dias do mês'],
															onChanged: (dynamic newValue) {
																folhaParametroController.folhaParametroModel.calculoProporcionalidade = newValue;
																folhaParametroController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: folhaParametroController.folhaParametroModel.descontarFaltas13 ?? 'Sim',
															labelText: 'Descontar Faltas 13',
															hintText: 'Informe os dados para o campo Descontar Faltas 13',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaParametroController.folhaParametroModel.descontarFaltas13 = newValue;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaParametroController.folhaParametroModel.pagarAdicionais13 ?? 'Sim',
															labelText: 'Pagar Adicionais 13',
															hintText: 'Informe os dados para o campo Pagar Adicionais 13',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaParametroController.folhaParametroModel.pagarAdicionais13 = newValue;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaParametroController.folhaParametroModel.pagarEstagiarios13 ?? 'Sim',
															labelText: 'Pagar Estagiarios 13',
															hintText: 'Informe os dados para o campo Pagar Estagiarios 13',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaParametroController.folhaParametroModel.pagarEstagiarios13 = newValue;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 2,
															controller: folhaParametroController.mesAdiantamento13Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Mes Adiantamento 13',
																labelText: 'Mes Adiantamento 13',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaParametroController.folhaParametroModel.mesAdiantamento13 = text;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: folhaParametroController.percentualAdiantam13Controller,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Adiantam 13',
																labelText: 'Percentual Adiantam 13',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaParametroController.folhaParametroModel.percentualAdiantam13 = folhaParametroController.percentualAdiantam13Controller.numberValue;
																folhaParametroController.formWasChanged = true;
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
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaParametroController.folhaParametroModel.feriasDescontarFaltas ?? 'Sim',
															labelText: 'Ferias Descontar Faltas',
															hintText: 'Informe os dados para o campo Ferias Descontar Faltas',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaParametroController.folhaParametroModel.feriasDescontarFaltas = newValue;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaParametroController.folhaParametroModel.feriasPagarAdicionais ?? 'Sim',
															labelText: 'Ferias Pagar Adicionais',
															hintText: 'Informe os dados para o campo Ferias Pagar Adicionais',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaParametroController.folhaParametroModel.feriasPagarAdicionais = newValue;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaParametroController.folhaParametroModel.feriasAdiantar13 ?? 'Sim',
															labelText: 'Ferias Adiantar 13',
															hintText: 'Informe os dados para o campo Ferias Adiantar 13',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaParametroController.folhaParametroModel.feriasAdiantar13 = newValue;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaParametroController.folhaParametroModel.feriasPagarEstagiarios ?? 'Sim',
															labelText: 'Ferias Pagar Estagiarios',
															hintText: 'Informe os dados para o campo Ferias Pagar Estagiarios',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaParametroController.folhaParametroModel.feriasPagarEstagiarios = newValue;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaParametroController.folhaParametroModel.feriasCalcJustaCausa ?? 'Sim',
															labelText: 'Ferias Calc Justa Causa',
															hintText: 'Informe os dados para o campo Ferias Calc Justa Causa',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaParametroController.folhaParametroModel.feriasCalcJustaCausa = newValue;
																folhaParametroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaParametroController.folhaParametroModel.feriasMovimentoMensal ?? 'Sim',
															labelText: 'Ferias Movimento Mensal',
															hintText: 'Informe os dados para o campo Ferias Movimento Mensal',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaParametroController.folhaParametroModel.feriasMovimentoMensal = newValue;
																folhaParametroController.formWasChanged = true;
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
