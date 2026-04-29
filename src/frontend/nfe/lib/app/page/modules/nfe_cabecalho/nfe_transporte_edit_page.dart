import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_transporte_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeTransporteEditPage extends StatelessWidget {
	NfeTransporteEditPage({Key? key}) : super(key: key);
	final nfeTransporteController = Get.find<NfeTransporteController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeTransporteController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Transporte - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeTransporteController.save),
						cancelAndExitButton(onPressed: nfeTransporteController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeTransporteController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeTransporteController.scrollController,
							child: SingleChildScrollView(
								controller: nfeTransporteController.scrollController,
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
															controller: nfeTransporteController.idTransportadoraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Transportadora',
																labelText: 'Id Transportadora',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.idTransportadora = int.tryParse(text);
																nfeTransporteController.formWasChanged = true;
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
															value: nfeTransporteController.nfeTransporteModel.modalidadeFrete ?? 'AAA',
															labelText: 'Modalidade Frete',
															hintText: 'Informe os dados para o campo Modalidade Frete',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeTransporteController.nfeTransporteModel.modalidadeFrete = newValue;
																nfeTransporteController.formWasChanged = true;
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
															controller: nfeTransporteController.cnpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj',
																labelText: 'Cnpj',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.cnpj = text;
																nfeTransporteController.formWasChanged = true;
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
															controller: nfeTransporteController.cpfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cpf',
																labelText: 'Cpf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.cpf = text;
																nfeTransporteController.formWasChanged = true;
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
															maxLength: 60,
															controller: nfeTransporteController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.nome = text;
																nfeTransporteController.formWasChanged = true;
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
															maxLength: 14,
															controller: nfeTransporteController.inscricaoEstadualController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Inscricao Estadual',
																labelText: 'Inscricao Estadual',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.inscricaoEstadual = text;
																nfeTransporteController.formWasChanged = true;
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
															maxLength: 60,
															controller: nfeTransporteController.enderecoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Endereco',
																labelText: 'Endereco',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.endereco = text;
																nfeTransporteController.formWasChanged = true;
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
															maxLength: 60,
															controller: nfeTransporteController.nomeMunicipioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Municipio',
																labelText: 'Nome Municipio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.nomeMunicipio = text;
																nfeTransporteController.formWasChanged = true;
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
															value: nfeTransporteController.nfeTransporteModel.uf ?? 'AC',
															labelText: 'Uf',
															hintText: 'Informe os dados para o campo Uf',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																nfeTransporteController.nfeTransporteModel.uf = newValue;
																nfeTransporteController.formWasChanged = true;
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
															controller: nfeTransporteController.valorServicoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Servico',
																labelText: 'Valor Servico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.valorServico = nfeTransporteController.valorServicoController.numberValue;
																nfeTransporteController.formWasChanged = true;
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
															controller: nfeTransporteController.valorBcRetencaoIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Retencao Icms',
																labelText: 'Valor Bc Retencao Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.valorBcRetencaoIcms = nfeTransporteController.valorBcRetencaoIcmsController.numberValue;
																nfeTransporteController.formWasChanged = true;
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
															controller: nfeTransporteController.aliquotaRetencaoIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Retencao Icms',
																labelText: 'Aliquota Retencao Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.aliquotaRetencaoIcms = nfeTransporteController.aliquotaRetencaoIcmsController.numberValue;
																nfeTransporteController.formWasChanged = true;
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
															controller: nfeTransporteController.valorIcmsRetidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms Retido',
																labelText: 'Valor Icms Retido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.valorIcmsRetido = nfeTransporteController.valorIcmsRetidoController.numberValue;
																nfeTransporteController.formWasChanged = true;
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
															controller: nfeTransporteController.cfopController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cfop',
																labelText: 'Cfop',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.cfop = int.tryParse(text);
																nfeTransporteController.formWasChanged = true;
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
															controller: nfeTransporteController.municipioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Municipio',
																labelText: 'Municipio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.municipio = int.tryParse(text);
																nfeTransporteController.formWasChanged = true;
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
															maxLength: 7,
															controller: nfeTransporteController.placaVeiculoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Placa Veiculo',
																labelText: 'Placa Veiculo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.placaVeiculo = text;
																nfeTransporteController.formWasChanged = true;
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
															value: nfeTransporteController.nfeTransporteModel.ufVeiculo ?? 'AC',
															labelText: 'Uf Veiculo',
															hintText: 'Informe os dados para o campo Uf Veiculo',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																nfeTransporteController.nfeTransporteModel.ufVeiculo = newValue;
																nfeTransporteController.formWasChanged = true;
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
															maxLength: 20,
															controller: nfeTransporteController.rntcVeiculoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Rntc Veiculo',
																labelText: 'Rntc Veiculo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeTransporteController.nfeTransporteModel.rntcVeiculo = text;
																nfeTransporteController.formWasChanged = true;
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
