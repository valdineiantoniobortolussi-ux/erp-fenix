import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_prod_rural_referenciada_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeProdRuralReferenciadaEditPage extends StatelessWidget {
	NfeProdRuralReferenciadaEditPage({Key? key}) : super(key: key);
	final nfeProdRuralReferenciadaController = Get.find<NfeProdRuralReferenciadaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeProdRuralReferenciadaController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('NFe Produtor Rural - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeProdRuralReferenciadaController.save),
						cancelAndExitButton(onPressed: nfeProdRuralReferenciadaController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeProdRuralReferenciadaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeProdRuralReferenciadaController.scrollController,
							child: SingleChildScrollView(
								controller: nfeProdRuralReferenciadaController.scrollController,
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
															controller: nfeProdRuralReferenciadaController.codigoUfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Uf',
																labelText: 'Codigo Uf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeProdRuralReferenciadaController.nfeProdRuralReferenciadaModel.codigoUf = int.tryParse(text);
																nfeProdRuralReferenciadaController.formWasChanged = true;
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
															controller: nfeProdRuralReferenciadaController.anoMesController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ano Mes',
																labelText: 'Ano Mes',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeProdRuralReferenciadaController.nfeProdRuralReferenciadaModel.anoMes = text;
																nfeProdRuralReferenciadaController.formWasChanged = true;
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
															controller: nfeProdRuralReferenciadaController.cnpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj',
																labelText: 'Cnpj',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeProdRuralReferenciadaController.nfeProdRuralReferenciadaModel.cnpj = text;
																nfeProdRuralReferenciadaController.formWasChanged = true;
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
															controller: nfeProdRuralReferenciadaController.cpfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cpf',
																labelText: 'Cpf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeProdRuralReferenciadaController.nfeProdRuralReferenciadaModel.cpf = text;
																nfeProdRuralReferenciadaController.formWasChanged = true;
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
															controller: nfeProdRuralReferenciadaController.inscricaoEstadualController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Inscricao Estadual',
																labelText: 'Inscricao Estadual',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeProdRuralReferenciadaController.nfeProdRuralReferenciadaModel.inscricaoEstadual = text;
																nfeProdRuralReferenciadaController.formWasChanged = true;
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
															value: nfeProdRuralReferenciadaController.nfeProdRuralReferenciadaModel.modelo ?? 'AAA',
															labelText: 'Modelo',
															hintText: 'Informe os dados para o campo Modelo',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeProdRuralReferenciadaController.nfeProdRuralReferenciadaModel.modelo = newValue;
																nfeProdRuralReferenciadaController.formWasChanged = true;
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
															value: nfeProdRuralReferenciadaController.nfeProdRuralReferenciadaModel.serie ?? 'AAA',
															labelText: 'Serie',
															hintText: 'Informe os dados para o campo Serie',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeProdRuralReferenciadaController.nfeProdRuralReferenciadaModel.serie = newValue;
																nfeProdRuralReferenciadaController.formWasChanged = true;
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
															controller: nfeProdRuralReferenciadaController.numeroNfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Nf',
																labelText: 'Numero Nf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeProdRuralReferenciadaController.nfeProdRuralReferenciadaModel.numeroNf = int.tryParse(text);
																nfeProdRuralReferenciadaController.formWasChanged = true;
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
