import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/contabil_dre_detalhe_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class ContabilDreDetalheEditPage extends StatelessWidget {
	ContabilDreDetalheEditPage({Key? key}) : super(key: key);
	final contabilDreDetalheController = Get.find<ContabilDreDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: contabilDreDetalheController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Detalhes - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: contabilDreDetalheController.save),
						cancelAndExitButton(onPressed: contabilDreDetalheController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contabilDreDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contabilDreDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: contabilDreDetalheController.scrollController,
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 30,
															controller: contabilDreDetalheController.classificacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Classificacao',
																labelText: 'Classificacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilDreDetalheController.contabilDreDetalheModel.classificacao = text;
																contabilDreDetalheController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: contabilDreDetalheController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilDreDetalheController.contabilDreDetalheModel.descricao = text;
																contabilDreDetalheController.formWasChanged = true;
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
															value: contabilDreDetalheController.contabilDreDetalheModel.formaCalculo ?? 'Sintética',
															labelText: 'Forma Calculo',
															hintText: 'Informe os dados para o campo Forma Calculo',
															items: const ['Sintética','Vinculada','Resultado de Operações da DRE'],
															onChanged: (dynamic newValue) {
																contabilDreDetalheController.contabilDreDetalheModel.formaCalculo = newValue;
																contabilDreDetalheController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilDreDetalheController.contabilDreDetalheModel.sinal ?? '+',
															labelText: 'Sinal',
															hintText: 'Informe os dados para o campo Sinal',
															items: const ['+','-','='],
															onChanged: (dynamic newValue) {
																contabilDreDetalheController.contabilDreDetalheModel.sinal = newValue;
																contabilDreDetalheController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilDreDetalheController.contabilDreDetalheModel.natureza ?? 'Credora',
															labelText: 'Natureza',
															hintText: 'Informe os dados para o campo Natureza',
															items: const ['Credora','Devedora'],
															onChanged: (dynamic newValue) {
																contabilDreDetalheController.contabilDreDetalheModel.natureza = newValue;
																contabilDreDetalheController.formWasChanged = true;
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
															controller: contabilDreDetalheController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilDreDetalheController.contabilDreDetalheModel.valor = contabilDreDetalheController.valorController.numberValue;
																contabilDreDetalheController.formWasChanged = true;
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
