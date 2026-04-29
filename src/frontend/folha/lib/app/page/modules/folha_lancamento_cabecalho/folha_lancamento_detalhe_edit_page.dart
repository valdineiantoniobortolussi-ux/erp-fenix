import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/folha_lancamento_detalhe_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FolhaLancamentoDetalheEditPage extends StatelessWidget {
	FolhaLancamentoDetalheEditPage({Key? key}) : super(key: key);
	final folhaLancamentoDetalheController = Get.find<FolhaLancamentoDetalheController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: folhaLancamentoDetalheController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Detalhes - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: folhaLancamentoDetalheController.save),
						cancelAndExitButton(onPressed: folhaLancamentoDetalheController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: folhaLancamentoDetalheController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: folhaLancamentoDetalheController.scrollController,
							child: SingleChildScrollView(
								controller: folhaLancamentoDetalheController.scrollController,
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
																		controller: folhaLancamentoDetalheController.folhaEventoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Evento',
																			labelText: 'Evento *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: folhaLancamentoDetalheController.callFolhaEventoLookup),
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
															controller: folhaLancamentoDetalheController.origemController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Origem',
																labelText: 'Origem',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaLancamentoDetalheController.folhaLancamentoDetalheModel.origem = folhaLancamentoDetalheController.origemController.numberValue;
																folhaLancamentoDetalheController.formWasChanged = true;
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
															controller: folhaLancamentoDetalheController.proventoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Provento',
																labelText: 'Provento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaLancamentoDetalheController.folhaLancamentoDetalheModel.provento = folhaLancamentoDetalheController.proventoController.numberValue;
																folhaLancamentoDetalheController.formWasChanged = true;
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
															controller: folhaLancamentoDetalheController.descontoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Desconto',
																labelText: 'Desconto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaLancamentoDetalheController.folhaLancamentoDetalheModel.desconto = folhaLancamentoDetalheController.descontoController.numberValue;
																folhaLancamentoDetalheController.formWasChanged = true;
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
