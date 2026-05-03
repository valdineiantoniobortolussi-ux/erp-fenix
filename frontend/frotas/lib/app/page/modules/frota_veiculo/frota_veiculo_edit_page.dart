import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:frotas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:frotas/app/controller/frota_veiculo_controller.dart';
import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/page/shared_widget/input/input_imports.dart';

class FrotaVeiculoEditPage extends StatelessWidget {
	FrotaVeiculoEditPage({Key? key}) : super(key: key);
	final frotaVeiculoController = Get.find<FrotaVeiculoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: frotaVeiculoController.frotaVeiculoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: frotaVeiculoController.frotaVeiculoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: frotaVeiculoController.scrollController,
							child: SingleChildScrollView(
								controller: frotaVeiculoController.scrollController,
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: frotaVeiculoController.frotaVeiculoTipoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Tipo Veículo',
																			labelText: 'Tipo *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: frotaVeiculoController.callFrotaVeiculoTipoLookup),
															),
														],
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: frotaVeiculoController.frotaCombustivelTipoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Combustível',
																			labelText: 'Combustivel *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: frotaVeiculoController.callFrotaCombustivelTipoLookup),
															),
														],
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
															maxLength: 100,
															controller: frotaVeiculoController.marcaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Marca',
																labelText: 'Marca',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoController.frotaVeiculoModel.marca = text;
																frotaVeiculoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-9',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: frotaVeiculoController.modeloController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Modelo',
																labelText: 'Modelo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoController.frotaVeiculoModel.modelo = text;
																frotaVeiculoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 4,
															controller: frotaVeiculoController.modeloAnoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Modelo Ano',
																labelText: 'Modelo Ano',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoController.frotaVeiculoModel.modeloAno = text;
																frotaVeiculoController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															maxLength: 7,
															controller: frotaVeiculoController.placaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Placa',
																labelText: 'Placa',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoController.frotaVeiculoModel.placa = text;
																frotaVeiculoController.formWasChanged = true;
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
															maxLength: 7,
															controller: frotaVeiculoController.codigoFipeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Fipe',
																labelText: 'Codigo Fipe',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoController.frotaVeiculoModel.codigoFipe = text;
																frotaVeiculoController.formWasChanged = true;
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
															maxLength: 11,
															controller: frotaVeiculoController.renavamController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Renavam',
																labelText: 'Renavam',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoController.frotaVeiculoModel.renavam = text;
																frotaVeiculoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: frotaVeiculoController.frotaVeiculoModel.ipvaMesVencimento ?? '01',
															labelText: 'Ipva Mes Vencimento',
															hintText: 'Informe os dados para o campo Ipva Mes Vencimento',
															items: const ['01','02','03','04','05','06','07','08','09','10','11','12'],
															onChanged: (dynamic newValue) {
																frotaVeiculoController.frotaVeiculoModel.ipvaMesVencimento = newValue;
																frotaVeiculoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: frotaVeiculoController.frotaVeiculoModel.dpvatMesVencimento ?? '01',
															labelText: 'Dpvat Mes Vencimento',
															hintText: 'Informe os dados para o campo Dpvat Mes Vencimento',
															items: const ['01','02','03','04','05','06','07','08','09','10','11','12'],
															onChanged: (dynamic newValue) {
																frotaVeiculoController.frotaVeiculoModel.dpvatMesVencimento = newValue;
																frotaVeiculoController.formWasChanged = true;
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
