import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:pcp/app/controller/pcp_op_cabecalho_controller.dart';
import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/page/shared_widget/input/input_imports.dart';

class PcpOpCabecalhoEditPage extends StatelessWidget {
	PcpOpCabecalhoEditPage({Key? key}) : super(key: key);
	final pcpOpCabecalhoController = Get.find<PcpOpCabecalhoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: pcpOpCabecalhoController.pcpOpCabecalhoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pcpOpCabecalhoController.pcpOpCabecalhoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pcpOpCabecalhoController.scrollController,
							child: SingleChildScrollView(
								controller: pcpOpCabecalhoController.scrollController,
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Fill with the Data Inicio',
																labelText: 'Data Inicio',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pcpOpCabecalhoController.pcpOpCabecalhoModel.dataInicio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pcpOpCabecalhoController.pcpOpCabecalhoModel.dataInicio = value;
																	pcpOpCabecalhoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Fill with the Data Previsao Entrega',
																labelText: 'Data Previsao Entrega',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pcpOpCabecalhoController.pcpOpCabecalhoModel.dataPrevisaoEntrega,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pcpOpCabecalhoController.pcpOpCabecalhoModel.dataPrevisaoEntrega = value;
																	pcpOpCabecalhoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Fill with the Data Termino',
																labelText: 'Data Termino',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pcpOpCabecalhoController.pcpOpCabecalhoModel.dataTermino,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pcpOpCabecalhoController.pcpOpCabecalhoModel.dataTermino = value;
																	pcpOpCabecalhoController.formWasChanged = true;
																},
															),
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pcpOpCabecalhoController.custoTotalPrevistoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Custo Total Previsto',
																labelText: 'Custo Total Previsto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpOpCabecalhoController.pcpOpCabecalhoModel.custoTotalPrevisto = pcpOpCabecalhoController.custoTotalPrevistoController.numberValue;
																pcpOpCabecalhoController.formWasChanged = true;
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
															controller: pcpOpCabecalhoController.custoTotalRealizadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Custo Total Realizado',
																labelText: 'Custo Total Realizado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpOpCabecalhoController.pcpOpCabecalhoModel.custoTotalRealizado = pcpOpCabecalhoController.custoTotalRealizadoController.numberValue;
																pcpOpCabecalhoController.formWasChanged = true;
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
															controller: pcpOpCabecalhoController.porcentoVendaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porcento Venda',
																labelText: 'Porcento Venda',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpOpCabecalhoController.pcpOpCabecalhoModel.porcentoVenda = pcpOpCabecalhoController.porcentoVendaController.numberValue;
																pcpOpCabecalhoController.formWasChanged = true;
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
															controller: pcpOpCabecalhoController.porcentoEstoqueController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Porcento Estoque',
																labelText: 'Porcento Estoque',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpOpCabecalhoController.pcpOpCabecalhoModel.porcentoEstoque = pcpOpCabecalhoController.porcentoEstoqueController.numberValue;
																pcpOpCabecalhoController.formWasChanged = true;
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
