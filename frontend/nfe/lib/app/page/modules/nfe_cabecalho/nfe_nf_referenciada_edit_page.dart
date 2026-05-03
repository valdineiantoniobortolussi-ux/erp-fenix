import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_nf_referenciada_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeNfReferenciadaEditPage extends StatelessWidget {
	NfeNfReferenciadaEditPage({Key? key}) : super(key: key);
	final nfeNfReferenciadaController = Get.find<NfeNfReferenciadaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeNfReferenciadaController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('NF Referenciada - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeNfReferenciadaController.save),
						cancelAndExitButton(onPressed: nfeNfReferenciadaController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeNfReferenciadaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeNfReferenciadaController.scrollController,
							child: SingleChildScrollView(
								controller: nfeNfReferenciadaController.scrollController,
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
															controller: nfeNfReferenciadaController.codigoUfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Uf',
																labelText: 'Codigo Uf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeNfReferenciadaController.nfeNfReferenciadaModel.codigoUf = int.tryParse(text);
																nfeNfReferenciadaController.formWasChanged = true;
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
															controller: nfeNfReferenciadaController.anoMesController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ano Mes',
																labelText: 'Ano Mes',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeNfReferenciadaController.nfeNfReferenciadaModel.anoMes = text;
																nfeNfReferenciadaController.formWasChanged = true;
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
															controller: nfeNfReferenciadaController.cnpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj',
																labelText: 'Cnpj',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeNfReferenciadaController.nfeNfReferenciadaModel.cnpj = text;
																nfeNfReferenciadaController.formWasChanged = true;
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
															value: nfeNfReferenciadaController.nfeNfReferenciadaModel.modelo ?? 'AAA',
															labelText: 'Modelo',
															hintText: 'Informe os dados para o campo Modelo',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeNfReferenciadaController.nfeNfReferenciadaModel.modelo = newValue;
																nfeNfReferenciadaController.formWasChanged = true;
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
															value: nfeNfReferenciadaController.nfeNfReferenciadaModel.serie ?? 'AAA',
															labelText: 'Serie',
															hintText: 'Informe os dados para o campo Serie',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																nfeNfReferenciadaController.nfeNfReferenciadaModel.serie = newValue;
																nfeNfReferenciadaController.formWasChanged = true;
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
															controller: nfeNfReferenciadaController.numeroNfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Nf',
																labelText: 'Numero Nf',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeNfReferenciadaController.nfeNfReferenciadaModel.numeroNf = int.tryParse(text);
																nfeNfReferenciadaController.formWasChanged = true;
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
