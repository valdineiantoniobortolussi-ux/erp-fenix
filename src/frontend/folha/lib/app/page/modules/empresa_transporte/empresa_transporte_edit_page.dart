import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/controller/empresa_transporte_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class EmpresaTransporteEditPage extends StatelessWidget {
	EmpresaTransporteEditPage({Key? key}) : super(key: key);
	final empresaTransporteController = Get.find<EmpresaTransporteController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: empresaTransporteController.empresaTransporteEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: empresaTransporteController.empresaTransporteEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: empresaTransporteController.scrollController,
							child: SingleChildScrollView(
								controller: empresaTransporteController.scrollController,
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
															maxLength: 100,
															controller: empresaTransporteController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaTransporteController.empresaTransporteModel.nome = text;
																empresaTransporteController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: empresaTransporteController.empresaTransporteModel.uf ?? 'AC',
															labelText: 'Uf',
															hintText: 'Informe os dados para o campo Uf',
															items: const ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'],
															onChanged: (dynamic newValue) {
																empresaTransporteController.empresaTransporteModel.uf = newValue;
																empresaTransporteController.formWasChanged = true;
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
															maxLength: 30,
															controller: empresaTransporteController.classificacaoContabilContaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Classificacao Contabil Conta',
																labelText: 'Classificacao Contabil Conta',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaTransporteController.empresaTransporteModel.classificacaoContabilConta = text;
																empresaTransporteController.formWasChanged = true;
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
