import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_veiculo_novo_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteVeiculoNovoEditPage extends StatelessWidget {
	CteVeiculoNovoEditPage({Key? key}) : super(key: key);
	final cteVeiculoNovoController = Get.find<CteVeiculoNovoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: cteVeiculoNovoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Veículo Novo - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteVeiculoNovoController.save),
						cancelAndExitButton(onPressed: cteVeiculoNovoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteVeiculoNovoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteVeiculoNovoController.scrollController,
							child: SingleChildScrollView(
								controller: cteVeiculoNovoController.scrollController,
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
															maxLength: 17,
															controller: cteVeiculoNovoController.chassiController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Chassi',
																labelText: 'Chassi',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteVeiculoNovoController.cteVeiculoNovoModel.chassi = text;
																cteVeiculoNovoController.formWasChanged = true;
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
															controller: cteVeiculoNovoController.corController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cor',
																labelText: 'Cor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteVeiculoNovoController.cteVeiculoNovoModel.cor = text;
																cteVeiculoNovoController.formWasChanged = true;
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
															maxLength: 40,
															controller: cteVeiculoNovoController.descricaoCorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao Cor',
																labelText: 'Descricao Cor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteVeiculoNovoController.cteVeiculoNovoModel.descricaoCor = text;
																cteVeiculoNovoController.formWasChanged = true;
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
															maxLength: 6,
															controller: cteVeiculoNovoController.codigoMarcaModeloController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Marca Modelo',
																labelText: 'Codigo Marca Modelo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteVeiculoNovoController.cteVeiculoNovoModel.codigoMarcaModelo = text;
																cteVeiculoNovoController.formWasChanged = true;
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
															controller: cteVeiculoNovoController.valorUnitarioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Unitario',
																labelText: 'Valor Unitario',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteVeiculoNovoController.cteVeiculoNovoModel.valorUnitario = cteVeiculoNovoController.valorUnitarioController.numberValue;
																cteVeiculoNovoController.formWasChanged = true;
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
															controller: cteVeiculoNovoController.valorFreteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Frete',
																labelText: 'Valor Frete',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteVeiculoNovoController.cteVeiculoNovoModel.valorFrete = cteVeiculoNovoController.valorFreteController.numberValue;
																cteVeiculoNovoController.formWasChanged = true;
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
