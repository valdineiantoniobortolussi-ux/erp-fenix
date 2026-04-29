import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_detalhe_imposto_cofins_st_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeDetalheImpostoCofinsStEditPage extends StatelessWidget {
	NfeDetalheImpostoCofinsStEditPage({Key? key}) : super(key: key);
	final nfeDetalheImpostoCofinsStController = Get.find<NfeDetalheImpostoCofinsStController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeDetalheImpostoCofinsStController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('COFINS ST - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeDetalheImpostoCofinsStController.save),
						cancelAndExitButton(onPressed: nfeDetalheImpostoCofinsStController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeDetalheImpostoCofinsStController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeDetalheImpostoCofinsStController.scrollController,
							child: SingleChildScrollView(
								controller: nfeDetalheImpostoCofinsStController.scrollController,
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
															controller: nfeDetalheImpostoCofinsStController.baseCalculoCofinsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo Cofins St',
																labelText: 'Base Calculo Cofins St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoCofinsStController.nfeDetalheImpostoCofinsStModel.baseCalculoCofinsSt = nfeDetalheImpostoCofinsStController.baseCalculoCofinsStController.numberValue;
																nfeDetalheImpostoCofinsStController.formWasChanged = true;
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
															controller: nfeDetalheImpostoCofinsStController.aliquotaCofinsStPercentualController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Cofins St Percentual',
																labelText: 'Aliquota Cofins St Percentual',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoCofinsStController.nfeDetalheImpostoCofinsStModel.aliquotaCofinsStPercentual = nfeDetalheImpostoCofinsStController.aliquotaCofinsStPercentualController.numberValue;
																nfeDetalheImpostoCofinsStController.formWasChanged = true;
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
															controller: nfeDetalheImpostoCofinsStController.quantidadeVendidaCofinsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Vendida Cofins St',
																labelText: 'Quantidade Vendida Cofins St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoCofinsStController.nfeDetalheImpostoCofinsStModel.quantidadeVendidaCofinsSt = nfeDetalheImpostoCofinsStController.quantidadeVendidaCofinsStController.numberValue;
																nfeDetalheImpostoCofinsStController.formWasChanged = true;
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
															controller: nfeDetalheImpostoCofinsStController.aliquotaCofinsStReaisController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Cofins St Reais',
																labelText: 'Aliquota Cofins St Reais',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoCofinsStController.nfeDetalheImpostoCofinsStModel.aliquotaCofinsStReais = nfeDetalheImpostoCofinsStController.aliquotaCofinsStReaisController.numberValue;
																nfeDetalheImpostoCofinsStController.formWasChanged = true;
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
															controller: nfeDetalheImpostoCofinsStController.valorCofinsStController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Cofins St',
																labelText: 'Valor Cofins St',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoCofinsStController.nfeDetalheImpostoCofinsStModel.valorCofinsSt = nfeDetalheImpostoCofinsStController.valorCofinsStController.numberValue;
																nfeDetalheImpostoCofinsStController.formWasChanged = true;
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
