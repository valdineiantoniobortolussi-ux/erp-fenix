import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_det_especifico_veiculo_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeDetEspecificoVeiculoEditPage extends StatelessWidget {
	NfeDetEspecificoVeiculoEditPage({Key? key}) : super(key: key);
	final nfeDetEspecificoVeiculoController = Get.find<NfeDetEspecificoVeiculoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeDetEspecificoVeiculoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Veículo - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeDetEspecificoVeiculoController.save),
						cancelAndExitButton(onPressed: nfeDetEspecificoVeiculoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeDetEspecificoVeiculoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeDetEspecificoVeiculoController.scrollController,
							child: SingleChildScrollView(
								controller: nfeDetEspecificoVeiculoController.scrollController,
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
														child: CustomDropdownButtonFormField(
															value: nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.tipoOperacao ?? 'AAA',
															labelText: 'Tipo Operacao',
															hintText: 'Informe os dados para o campo Tipo Operacao',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.tipoOperacao = newValue;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															maxLength: 17,
															controller: nfeDetEspecificoVeiculoController.chassiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Chassi',
																labelText: 'Chassi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.chassi = text;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															maxLength: 4,
															controller: nfeDetEspecificoVeiculoController.corController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cor',
																labelText: 'Cor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.cor = text;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															controller: nfeDetEspecificoVeiculoController.descricaoCorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao Cor',
																labelText: 'Descricao Cor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.descricaoCor = text;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															maxLength: 4,
															controller: nfeDetEspecificoVeiculoController.potenciaMotorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Potencia Motor',
																labelText: 'Potencia Motor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.potenciaMotor = text;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															maxLength: 4,
															controller: nfeDetEspecificoVeiculoController.cilindradasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cilindradas',
																labelText: 'Cilindradas',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.cilindradas = text;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															maxLength: 9,
															controller: nfeDetEspecificoVeiculoController.pesoLiquidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Peso Liquido',
																labelText: 'Peso Liquido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.pesoLiquido = text;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															maxLength: 9,
															controller: nfeDetEspecificoVeiculoController.pesoBrutoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Peso Bruto',
																labelText: 'Peso Bruto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.pesoBruto = text;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															maxLength: 9,
															controller: nfeDetEspecificoVeiculoController.numeroSerieController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Serie',
																labelText: 'Numero Serie',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.numeroSerie = text;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															value: nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.tipoCombustivel ?? 'AAA',
															labelText: 'Tipo Combustivel',
															hintText: 'Informe os dados para o campo Tipo Combustivel',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.tipoCombustivel = newValue;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															controller: nfeDetEspecificoVeiculoController.numeroMotorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Motor',
																labelText: 'Numero Motor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.numeroMotor = text;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															maxLength: 9,
															controller: nfeDetEspecificoVeiculoController.capacidadeMaximaTracaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Capacidade Maxima Tracao',
																labelText: 'Capacidade Maxima Tracao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.capacidadeMaximaTracao = text;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															maxLength: 4,
															controller: nfeDetEspecificoVeiculoController.distanciaEixosController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Distancia Eixos',
																labelText: 'Distancia Eixos',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.distanciaEixos = text;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															value: nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.anoModelo ?? 'AAA',
															labelText: 'Ano Modelo',
															hintText: 'Informe os dados para o campo Ano Modelo',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.anoModelo = newValue;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															value: nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.anoFabricacao ?? 'AAA',
															labelText: 'Ano Fabricacao',
															hintText: 'Informe os dados para o campo Ano Fabricacao',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.anoFabricacao = newValue;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															value: nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.tipoPintura ?? 'AAA',
															labelText: 'Tipo Pintura',
															hintText: 'Informe os dados para o campo Tipo Pintura',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.tipoPintura = newValue;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															value: nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.tipoVeiculo ?? 'AAA',
															labelText: 'Tipo Veiculo',
															hintText: 'Informe os dados para o campo Tipo Veiculo',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.tipoVeiculo = newValue;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															value: nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.especieVeiculo ?? 'AAA',
															labelText: 'Especie Veiculo',
															hintText: 'Informe os dados para o campo Especie Veiculo',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.especieVeiculo = newValue;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															value: nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.condicaoVin ?? 'AAA',
															labelText: 'Condicao Vin',
															hintText: 'Informe os dados para o campo Condicao Vin',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.condicaoVin = newValue;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															value: nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.condicaoVeiculo ?? 'AAA',
															labelText: 'Condicao Veiculo',
															hintText: 'Informe os dados para o campo Condicao Veiculo',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.condicaoVeiculo = newValue;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															controller: nfeDetEspecificoVeiculoController.codigoMarcaModeloController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Marca Modelo',
																labelText: 'Codigo Marca Modelo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.codigoMarcaModelo = text;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															value: nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.codigoCorDenatran ?? 'AAA',
															labelText: 'Codigo Cor Denatran',
															hintText: 'Informe os dados para o campo Codigo Cor Denatran',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.codigoCorDenatran = newValue;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															controller: nfeDetEspecificoVeiculoController.lotacaoMaximaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Lotacao Maxima',
																labelText: 'Lotacao Maxima',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.lotacaoMaxima = int.tryParse(text);
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
															value: nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.restricao ?? 'AAA',
															labelText: 'Restricao',
															hintText: 'Informe os dados para o campo Restricao',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetEspecificoVeiculoController.nfeDetEspecificoVeiculoModel.restricao = newValue;
																nfeDetEspecificoVeiculoController.formWasChanged = true;
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
