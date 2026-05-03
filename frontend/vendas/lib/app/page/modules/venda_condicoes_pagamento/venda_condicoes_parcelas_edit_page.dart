import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:vendas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:vendas/app/controller/venda_condicoes_parcelas_controller.dart';
import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/page/shared_widget/input/input_imports.dart';

class VendaCondicoesParcelasEditPage extends StatelessWidget {
	VendaCondicoesParcelasEditPage({Key? key}) : super(key: key);
	final vendaCondicoesParcelasController = Get.find<VendaCondicoesParcelasController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: vendaCondicoesParcelasController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Parcelas - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: vendaCondicoesParcelasController.save),
						cancelAndExitButton(onPressed: vendaCondicoesParcelasController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: vendaCondicoesParcelasController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: vendaCondicoesParcelasController.scrollController,
							child: SingleChildScrollView(
								controller: vendaCondicoesParcelasController.scrollController,
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
														child: TextFormField(
															autofocus: true,
															controller: vendaCondicoesParcelasController.parcelaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Parcela',
																labelText: 'Parcela',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCondicoesParcelasController.vendaCondicoesParcelasModel.parcela = int.tryParse(text);
																vendaCondicoesParcelasController.formWasChanged = true;
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
															controller: vendaCondicoesParcelasController.diasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dias a Partir da Venda',
																labelText: 'Dias a Partir da Venda',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCondicoesParcelasController.vendaCondicoesParcelasModel.dias = int.tryParse(text);
																vendaCondicoesParcelasController.formWasChanged = true;
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
															controller: vendaCondicoesParcelasController.taxaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo % da Parcela',
																labelText: '% da Parcela',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaCondicoesParcelasController.vendaCondicoesParcelasModel.taxa = vendaCondicoesParcelasController.taxaController.numberValue;
																vendaCondicoesParcelasController.formWasChanged = true;
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
