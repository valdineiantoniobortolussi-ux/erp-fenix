import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:pcp/app/page/shared_widget/shared_widget_imports.dart';
import 'package:pcp/app/controller/pcp_op_detalhe_controller.dart';
import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/page/shared_widget/input/input_imports.dart';

class PcpOpDetalheEditPage extends StatelessWidget {
	PcpOpDetalheEditPage({Key? key}) : super(key: key);
	final pcpOpDetalheController = Get.find<PcpOpDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: pcpOpDetalheController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Itens - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: pcpOpDetalheController.save),
						cancelAndExitButton(onPressed: pcpOpDetalheController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pcpOpDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pcpOpDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: pcpOpDetalheController.scrollController,
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
																		controller: pcpOpDetalheController.produtoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Produto',
																			labelText: 'Produto *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: pcpOpDetalheController.callProdutoLookup),
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pcpOpDetalheController.quantidadeProduzirController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Produzir',
																labelText: 'Quantidade Produzir',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpOpDetalheController.pcpOpDetalheModel.quantidadeProduzir = pcpOpDetalheController.quantidadeProduzirController.numberValue;
																pcpOpDetalheController.formWasChanged = true;
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
															controller: pcpOpDetalheController.quantidadeProduzidaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Produzida',
																labelText: 'Quantidade Produzida',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpOpDetalheController.pcpOpDetalheModel.quantidadeProduzida = pcpOpDetalheController.quantidadeProduzidaController.numberValue;
																pcpOpDetalheController.formWasChanged = true;
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
															controller: pcpOpDetalheController.quantidadeEntregueController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Entregue',
																labelText: 'Quantidade Entregue',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpOpDetalheController.pcpOpDetalheModel.quantidadeEntregue = pcpOpDetalheController.quantidadeEntregueController.numberValue;
																pcpOpDetalheController.formWasChanged = true;
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
														child: TextFormField(
															autofocus: true,
															controller: pcpOpDetalheController.custoPrevistoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Custo Previsto',
																labelText: 'Custo Previsto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpOpDetalheController.pcpOpDetalheModel.custoPrevisto = pcpOpDetalheController.custoPrevistoController.numberValue;
																pcpOpDetalheController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: pcpOpDetalheController.custoRealizadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Custo Realizado',
																labelText: 'Custo Realizado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pcpOpDetalheController.pcpOpDetalheModel.custoRealizado = pcpOpDetalheController.custoRealizadoController.numberValue;
																pcpOpDetalheController.formWasChanged = true;
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
