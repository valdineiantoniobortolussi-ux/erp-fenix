import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_ferroviario_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteFerroviarioEditPage extends StatelessWidget {
	CteFerroviarioEditPage({Key? key}) : super(key: key);
	final cteFerroviarioController = Get.find<CteFerroviarioController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: cteFerroviarioController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Ferroviário - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteFerroviarioController.save),
						cancelAndExitButton(onPressed: cteFerroviarioController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteFerroviarioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteFerroviarioController.scrollController,
							child: SingleChildScrollView(
								controller: cteFerroviarioController.scrollController,
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
															value: cteFerroviarioController.cteFerroviarioModel.tipoTrafego ?? 'AAA',
															labelText: 'Tipo Trafego',
															hintText: 'Informe os dados para o campo Tipo Trafego',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteFerroviarioController.cteFerroviarioModel.tipoTrafego = newValue;
																cteFerroviarioController.formWasChanged = true;
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
															value: cteFerroviarioController.cteFerroviarioModel.responsavelFaturamento ?? 'AAA',
															labelText: 'Responsavel Faturamento',
															hintText: 'Informe os dados para o campo Responsavel Faturamento',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteFerroviarioController.cteFerroviarioModel.responsavelFaturamento = newValue;
																cteFerroviarioController.formWasChanged = true;
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
															value: cteFerroviarioController.cteFerroviarioModel.ferroviaEmitenteCte ?? 'AAA',
															labelText: 'Ferrovia Emitente Cte',
															hintText: 'Informe os dados para o campo Ferrovia Emitente Cte',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteFerroviarioController.cteFerroviarioModel.ferroviaEmitenteCte = newValue;
																cteFerroviarioController.formWasChanged = true;
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
															maxLength: 10,
															controller: cteFerroviarioController.fluxoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fluxo',
																labelText: 'Fluxo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteFerroviarioController.cteFerroviarioModel.fluxo = text;
																cteFerroviarioController.formWasChanged = true;
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
															controller: cteFerroviarioController.idTremController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Trem',
																labelText: 'Id Trem',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteFerroviarioController.cteFerroviarioModel.idTrem = text;
																cteFerroviarioController.formWasChanged = true;
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
															controller: cteFerroviarioController.valorFreteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Frete',
																labelText: 'Valor Frete',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteFerroviarioController.cteFerroviarioModel.valorFrete = cteFerroviarioController.valorFreteController.numberValue;
																cteFerroviarioController.formWasChanged = true;
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
