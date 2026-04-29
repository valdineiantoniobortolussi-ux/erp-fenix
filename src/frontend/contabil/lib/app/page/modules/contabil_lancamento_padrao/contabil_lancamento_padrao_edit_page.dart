import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/contabil_lancamento_padrao_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class ContabilLancamentoPadraoEditPage extends StatelessWidget {
	ContabilLancamentoPadraoEditPage({Key? key}) : super(key: key);
	final contabilLancamentoPadraoController = Get.find<ContabilLancamentoPadraoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					contabilLancamentoPadraoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: contabilLancamentoPadraoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Lancamento Padrão - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: contabilLancamentoPadraoController.save),
						cancelAndExitButton(onPressed: contabilLancamentoPadraoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contabilLancamentoPadraoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contabilLancamentoPadraoController.scrollController,
							child: SingleChildScrollView(
								controller: contabilLancamentoPadraoController.scrollController,
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
															maxLength: 100,
															controller: contabilLancamentoPadraoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoPadraoController.contabilLancamentoPadraoModel.descricao = text;
																contabilLancamentoPadraoController.formWasChanged = true;
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
															maxLength: 250,
															maxLines: 3,
															controller: contabilLancamentoPadraoController.historicoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Historico',
																labelText: 'Historico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoPadraoController.contabilLancamentoPadraoModel.historico = text;
																contabilLancamentoPadraoController.formWasChanged = true;
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
															controller: contabilLancamentoPadraoController.idContaDebitoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Conta Debito',
																labelText: 'Id Conta Debito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoPadraoController.contabilLancamentoPadraoModel.idContaDebito = int.tryParse(text);
																contabilLancamentoPadraoController.formWasChanged = true;
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
															controller: contabilLancamentoPadraoController.idContaCreditoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Conta Credito',
																labelText: 'Id Conta Credito',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoPadraoController.contabilLancamentoPadraoModel.idContaCredito = int.tryParse(text);
																contabilLancamentoPadraoController.formWasChanged = true;
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
			),
		);
	}
}
