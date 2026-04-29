import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_detalhe_imposto_ipi_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeDetalheImpostoIpiEditPage extends StatelessWidget {
	NfeDetalheImpostoIpiEditPage({Key? key}) : super(key: key);
	final nfeDetalheImpostoIpiController = Get.find<NfeDetalheImpostoIpiController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeDetalheImpostoIpiController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('IPI - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeDetalheImpostoIpiController.save),
						cancelAndExitButton(onPressed: nfeDetalheImpostoIpiController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeDetalheImpostoIpiController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeDetalheImpostoIpiController.scrollController,
							child: SingleChildScrollView(
								controller: nfeDetalheImpostoIpiController.scrollController,
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
															controller: nfeDetalheImpostoIpiController.cnpjProdutorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj Produtor',
																labelText: 'Cnpj Produtor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIpiController.nfeDetalheImpostoIpiModel.cnpjProdutor = text;
																nfeDetalheImpostoIpiController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIpiController.codigoSeloIpiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Selo Ipi',
																labelText: 'Codigo Selo Ipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIpiController.nfeDetalheImpostoIpiModel.codigoSeloIpi = text;
																nfeDetalheImpostoIpiController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIpiController.quantidadeSeloIpiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Selo Ipi',
																labelText: 'Quantidade Selo Ipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIpiController.nfeDetalheImpostoIpiModel.quantidadeSeloIpi = int.tryParse(text);
																nfeDetalheImpostoIpiController.formWasChanged = true;
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
															value: nfeDetalheImpostoIpiController.nfeDetalheImpostoIpiModel.enquadramentoLegalIpi ?? 'AAA',
															labelText: 'Enquadramento Legal Ipi',
															hintText: 'Informe os dados para o campo Enquadramento Legal Ipi',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetalheImpostoIpiController.nfeDetalheImpostoIpiModel.enquadramentoLegalIpi = newValue;
																nfeDetalheImpostoIpiController.formWasChanged = true;
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
															value: nfeDetalheImpostoIpiController.nfeDetalheImpostoIpiModel.cstIpi ?? 'AAA',
															labelText: 'Cst Ipi',
															hintText: 'Informe os dados para o campo Cst Ipi',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeDetalheImpostoIpiController.nfeDetalheImpostoIpiModel.cstIpi = newValue;
																nfeDetalheImpostoIpiController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIpiController.valorBaseCalculoIpiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Base Calculo Ipi',
																labelText: 'Valor Base Calculo Ipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIpiController.nfeDetalheImpostoIpiModel.valorBaseCalculoIpi = nfeDetalheImpostoIpiController.valorBaseCalculoIpiController.numberValue;
																nfeDetalheImpostoIpiController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIpiController.quantidadeUnidadeTributavelController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Unidade Tributavel',
																labelText: 'Quantidade Unidade Tributavel',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIpiController.nfeDetalheImpostoIpiModel.quantidadeUnidadeTributavel = nfeDetalheImpostoIpiController.quantidadeUnidadeTributavelController.numberValue;
																nfeDetalheImpostoIpiController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIpiController.valorUnidadeTributavelController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Unidade Tributavel',
																labelText: 'Valor Unidade Tributavel',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIpiController.nfeDetalheImpostoIpiModel.valorUnidadeTributavel = nfeDetalheImpostoIpiController.valorUnidadeTributavelController.numberValue;
																nfeDetalheImpostoIpiController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIpiController.aliquotaIpiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Ipi',
																labelText: 'Aliquota Ipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIpiController.nfeDetalheImpostoIpiModel.aliquotaIpi = nfeDetalheImpostoIpiController.aliquotaIpiController.numberValue;
																nfeDetalheImpostoIpiController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIpiController.valorIpiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Ipi',
																labelText: 'Valor Ipi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIpiController.nfeDetalheImpostoIpiModel.valorIpi = nfeDetalheImpostoIpiController.valorIpiController.numberValue;
																nfeDetalheImpostoIpiController.formWasChanged = true;
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
