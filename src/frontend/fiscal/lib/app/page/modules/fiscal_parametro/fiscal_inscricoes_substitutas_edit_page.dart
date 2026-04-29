import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:fiscal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:fiscal/app/controller/fiscal_inscricoes_substitutas_controller.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/page/shared_widget/input/input_imports.dart';

class FiscalInscricoesSubstitutasEditPage extends StatelessWidget {
	FiscalInscricoesSubstitutasEditPage({Key? key}) : super(key: key);
	final fiscalInscricoesSubstitutasController = Get.find<FiscalInscricoesSubstitutasController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: fiscalInscricoesSubstitutasController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Inscrições Substitutas - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: fiscalInscricoesSubstitutasController.save),
						cancelAndExitButton(onPressed: fiscalInscricoesSubstitutasController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: fiscalInscricoesSubstitutasController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: fiscalInscricoesSubstitutasController.scrollController,
							child: SingleChildScrollView(
								controller: fiscalInscricoesSubstitutasController.scrollController,
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
														child: CustomDropdownButtonFormField(
															value: fiscalInscricoesSubstitutasController.fiscalInscricoesSubstitutasModel.uf ?? 'AC',
															labelText: 'Uf',
															hintText: 'Informe os dados para o campo Uf',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																fiscalInscricoesSubstitutasController.fiscalInscricoesSubstitutasModel.uf = newValue;
																fiscalInscricoesSubstitutasController.formWasChanged = true;
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
															maxLength: 30,
															controller: fiscalInscricoesSubstitutasController.inscricaoEstadualController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Inscricao Estadual',
																labelText: 'Inscricao Estadual',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fiscalInscricoesSubstitutasController.fiscalInscricoesSubstitutasModel.inscricaoEstadual = text;
																fiscalInscricoesSubstitutasController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: fiscalInscricoesSubstitutasController.fiscalInscricoesSubstitutasModel.pmpf ?? 'Sim',
															labelText: 'PMPF',
															hintText: 'Informe os dados para o campo Pmpf',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																fiscalInscricoesSubstitutasController.fiscalInscricoesSubstitutasModel.pmpf = newValue;
																fiscalInscricoesSubstitutasController.formWasChanged = true;
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
