import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_det_especifico_combustivel_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeDetEspecificoCombustivelEditPage extends StatelessWidget {
	NfeDetEspecificoCombustivelEditPage({Key? key}) : super(key: key);
	final nfeDetEspecificoCombustivelController = Get.find<NfeDetEspecificoCombustivelController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeDetEspecificoCombustivelController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Combustível - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeDetEspecificoCombustivelController.save),
						cancelAndExitButton(onPressed: nfeDetEspecificoCombustivelController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeDetEspecificoCombustivelController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeDetEspecificoCombustivelController.scrollController,
							child: SingleChildScrollView(
								controller: nfeDetEspecificoCombustivelController.scrollController,
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
															controller: nfeDetEspecificoCombustivelController.codigoAnpController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Anp',
																labelText: 'Codigo Anp',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.codigoAnp = int.tryParse(text);
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															maxLength: 95,
															controller: nfeDetEspecificoCombustivelController.descricaoAnpController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao Anp',
																labelText: 'Descricao Anp',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.descricaoAnp = text;
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															controller: nfeDetEspecificoCombustivelController.percentualGlpController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Glp',
																labelText: 'Percentual Glp',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.percentualGlp = nfeDetEspecificoCombustivelController.percentualGlpController.numberValue;
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															controller: nfeDetEspecificoCombustivelController.percentualGasNacionalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Gas Nacional',
																labelText: 'Percentual Gas Nacional',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.percentualGasNacional = nfeDetEspecificoCombustivelController.percentualGasNacionalController.numberValue;
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															controller: nfeDetEspecificoCombustivelController.percentualGasImportadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Gas Importado',
																labelText: 'Percentual Gas Importado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.percentualGasImportado = nfeDetEspecificoCombustivelController.percentualGasImportadoController.numberValue;
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															controller: nfeDetEspecificoCombustivelController.valorPartidaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Partida',
																labelText: 'Valor Partida',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.valorPartida = nfeDetEspecificoCombustivelController.valorPartidaController.numberValue;
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															maxLength: 21,
															controller: nfeDetEspecificoCombustivelController.codifController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codif',
																labelText: 'Codif',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.codif = text;
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															controller: nfeDetEspecificoCombustivelController.quantidadeTempAmbienteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Temp Ambiente',
																labelText: 'Quantidade Temp Ambiente',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.quantidadeTempAmbiente = nfeDetEspecificoCombustivelController.quantidadeTempAmbienteController.numberValue;
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.ufConsumo ?? 'AC',
															labelText: 'Uf Consumo',
															hintText: 'Informe os dados para o campo Uf Consumo',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.ufConsumo = newValue;
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															controller: nfeDetEspecificoCombustivelController.cideBaseCalculoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cide Base Calculo',
																labelText: 'Cide Base Calculo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.cideBaseCalculo = nfeDetEspecificoCombustivelController.cideBaseCalculoController.numberValue;
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															controller: nfeDetEspecificoCombustivelController.cideAliquotaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cide Aliquota',
																labelText: 'Cide Aliquota',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.cideAliquota = nfeDetEspecificoCombustivelController.cideAliquotaController.numberValue;
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															controller: nfeDetEspecificoCombustivelController.cideValorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cide Valor',
																labelText: 'Cide Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.cideValor = nfeDetEspecificoCombustivelController.cideValorController.numberValue;
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															controller: nfeDetEspecificoCombustivelController.encerranteBicoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Encerrante Bico',
																labelText: 'Encerrante Bico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.encerranteBico = int.tryParse(text);
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															controller: nfeDetEspecificoCombustivelController.encerranteBombaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Encerrante Bomba',
																labelText: 'Encerrante Bomba',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.encerranteBomba = int.tryParse(text);
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															controller: nfeDetEspecificoCombustivelController.encerranteTanqueController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Encerrante Tanque',
																labelText: 'Encerrante Tanque',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.encerranteTanque = int.tryParse(text);
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															controller: nfeDetEspecificoCombustivelController.encerranteValorInicioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Encerrante Valor Inicio',
																labelText: 'Encerrante Valor Inicio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.encerranteValorInicio = nfeDetEspecificoCombustivelController.encerranteValorInicioController.numberValue;
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
															controller: nfeDetEspecificoCombustivelController.encerranteValorFimController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Encerrante Valor Fim',
																labelText: 'Encerrante Valor Fim',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoCombustivelController.nfeDetEspecificoCombustivelModel.encerranteValorFim = nfeDetEspecificoCombustivelController.encerranteValorFimController.numberValue;
																nfeDetEspecificoCombustivelController.formWasChanged = true;
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
