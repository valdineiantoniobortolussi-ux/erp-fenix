import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_fatura_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeFaturaEditPage extends StatelessWidget {
	NfeFaturaEditPage({Key? key}) : super(key: key);
	final nfeFaturaController = Get.find<NfeFaturaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeFaturaController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Fatura - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeFaturaController.save),
						cancelAndExitButton(onPressed: nfeFaturaController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeFaturaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeFaturaController.scrollController,
							child: SingleChildScrollView(
								controller: nfeFaturaController.scrollController,
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
															maxLength: 60,
															controller: nfeFaturaController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeFaturaController.nfeFaturaModel.numero = text;
																nfeFaturaController.formWasChanged = true;
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
															controller: nfeFaturaController.valorOriginalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Original',
																labelText: 'Valor Original',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeFaturaController.nfeFaturaModel.valorOriginal = nfeFaturaController.valorOriginalController.numberValue;
																nfeFaturaController.formWasChanged = true;
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
															controller: nfeFaturaController.valorDescontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Desconto',
																labelText: 'Valor Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeFaturaController.nfeFaturaModel.valorDesconto = nfeFaturaController.valorDescontoController.numberValue;
																nfeFaturaController.formWasChanged = true;
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
															controller: nfeFaturaController.valorLiquidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Liquido',
																labelText: 'Valor Liquido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeFaturaController.nfeFaturaModel.valorLiquido = nfeFaturaController.valorLiquidoController.numberValue;
																nfeFaturaController.formWasChanged = true;
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
