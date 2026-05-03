import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:wms/app/page/shared_widget/shared_widget_imports.dart';
import 'package:wms/app/controller/wms_recebimento_detalhe_controller.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/page/shared_widget/input/input_imports.dart';

class WmsRecebimentoDetalheEditPage extends StatelessWidget {
	WmsRecebimentoDetalheEditPage({Key? key}) : super(key: key);
	final wmsRecebimentoDetalheController = Get.find<WmsRecebimentoDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: wmsRecebimentoDetalheController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Itens - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: wmsRecebimentoDetalheController.save),
						cancelAndExitButton(onPressed: wmsRecebimentoDetalheController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: wmsRecebimentoDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: wmsRecebimentoDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: wmsRecebimentoDetalheController.scrollController,
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
																		controller: wmsRecebimentoDetalheController.produtoModelController,
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
																child: lookupButton(onPressed: wmsRecebimentoDetalheController.callProdutoLookup),
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: wmsRecebimentoDetalheController.quantidadeVolumeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Volume',
																labelText: 'Quantidade Volume',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsRecebimentoDetalheController.wmsRecebimentoDetalheModel.quantidadeVolume = int.tryParse(text);
																wmsRecebimentoDetalheController.formWasChanged = true;
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
															controller: wmsRecebimentoDetalheController.quantidadeItemPorVolumeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Item Por Volume',
																labelText: 'Quantidade Item Por Volume',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsRecebimentoDetalheController.wmsRecebimentoDetalheModel.quantidadeItemPorVolume = int.tryParse(text);
																wmsRecebimentoDetalheController.formWasChanged = true;
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
															controller: wmsRecebimentoDetalheController.quantidadeRecebidaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Recebida',
																labelText: 'Quantidade Recebida',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																wmsRecebimentoDetalheController.wmsRecebimentoDetalheModel.quantidadeRecebida = int.tryParse(text);
																wmsRecebimentoDetalheController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: wmsRecebimentoDetalheController.wmsRecebimentoDetalheModel.destino ?? 'Armazenamento',
															labelText: 'Destino',
															hintText: 'Informe os dados para o campo Destino',
															items: const ['Armazenamento','Expedição','Produção'],
															onChanged: (dynamic newValue) {
																wmsRecebimentoDetalheController.wmsRecebimentoDetalheModel.destino = newValue;
																wmsRecebimentoDetalheController.formWasChanged = true;
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
