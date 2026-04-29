import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:fiscal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:fiscal/app/controller/simples_nacional_detalhe_controller.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/page/shared_widget/input/input_imports.dart';

class SimplesNacionalDetalheEditPage extends StatelessWidget {
	SimplesNacionalDetalheEditPage({Key? key}) : super(key: key);
	final simplesNacionalDetalheController = Get.find<SimplesNacionalDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: simplesNacionalDetalheController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Detalhes - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: simplesNacionalDetalheController.save),
						cancelAndExitButton(onPressed: simplesNacionalDetalheController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: simplesNacionalDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: simplesNacionalDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: simplesNacionalDetalheController.scrollController,
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: simplesNacionalDetalheController.faixaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Faixa',
																labelText: 'Faixa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalDetalheController.simplesNacionalDetalheModel.faixa = int.tryParse(text);
																simplesNacionalDetalheController.formWasChanged = true;
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
															controller: simplesNacionalDetalheController.valorInicialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Inicial',
																labelText: 'Valor Inicial',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalDetalheController.simplesNacionalDetalheModel.valorInicial = simplesNacionalDetalheController.valorInicialController.numberValue;
																simplesNacionalDetalheController.formWasChanged = true;
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
															controller: simplesNacionalDetalheController.valorFinalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Final',
																labelText: 'Valor Final',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalDetalheController.simplesNacionalDetalheModel.valorFinal = simplesNacionalDetalheController.valorFinalController.numberValue;
																simplesNacionalDetalheController.formWasChanged = true;
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
															controller: simplesNacionalDetalheController.aliquotaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota',
																labelText: 'Aliquota',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalDetalheController.simplesNacionalDetalheModel.aliquota = simplesNacionalDetalheController.aliquotaController.numberValue;
																simplesNacionalDetalheController.formWasChanged = true;
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
															controller: simplesNacionalDetalheController.irpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Irpj',
																labelText: 'Irpj',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalDetalheController.simplesNacionalDetalheModel.irpj = simplesNacionalDetalheController.irpjController.numberValue;
																simplesNacionalDetalheController.formWasChanged = true;
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
															controller: simplesNacionalDetalheController.csllController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Csll',
																labelText: 'Csll',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalDetalheController.simplesNacionalDetalheModel.csll = simplesNacionalDetalheController.csllController.numberValue;
																simplesNacionalDetalheController.formWasChanged = true;
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
															controller: simplesNacionalDetalheController.cofinsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cofins',
																labelText: 'Cofins',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalDetalheController.simplesNacionalDetalheModel.cofins = simplesNacionalDetalheController.cofinsController.numberValue;
																simplesNacionalDetalheController.formWasChanged = true;
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
															controller: simplesNacionalDetalheController.pisPasepController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Pis Pasep',
																labelText: 'Pis Pasep',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalDetalheController.simplesNacionalDetalheModel.pisPasep = simplesNacionalDetalheController.pisPasepController.numberValue;
																simplesNacionalDetalheController.formWasChanged = true;
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
															controller: simplesNacionalDetalheController.cppController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cpp',
																labelText: 'Cpp',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalDetalheController.simplesNacionalDetalheModel.cpp = simplesNacionalDetalheController.cppController.numberValue;
																simplesNacionalDetalheController.formWasChanged = true;
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
															controller: simplesNacionalDetalheController.icmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Icms',
																labelText: 'Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalDetalheController.simplesNacionalDetalheModel.icms = simplesNacionalDetalheController.icmsController.numberValue;
																simplesNacionalDetalheController.formWasChanged = true;
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
															controller: simplesNacionalDetalheController.ipiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ipi',
																labelText: 'Ipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalDetalheController.simplesNacionalDetalheModel.ipi = simplesNacionalDetalheController.ipiController.numberValue;
																simplesNacionalDetalheController.formWasChanged = true;
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
															controller: simplesNacionalDetalheController.issController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Iss',
																labelText: 'Iss',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalDetalheController.simplesNacionalDetalheModel.iss = simplesNacionalDetalheController.issController.numberValue;
																simplesNacionalDetalheController.formWasChanged = true;
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
