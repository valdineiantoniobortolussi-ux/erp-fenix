import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/contabil_lancamento_orcado_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class ContabilLancamentoOrcadoEditPage extends StatelessWidget {
	ContabilLancamentoOrcadoEditPage({Key? key}) : super(key: key);
	final contabilLancamentoOrcadoController = Get.find<ContabilLancamentoOrcadoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					contabilLancamentoOrcadoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: contabilLancamentoOrcadoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Lançamento Orcado - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: contabilLancamentoOrcadoController.save),
						cancelAndExitButton(onPressed: contabilLancamentoOrcadoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contabilLancamentoOrcadoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contabilLancamentoOrcadoController.scrollController,
							child: SingleChildScrollView(
								controller: contabilLancamentoOrcadoController.scrollController,
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
													sizes: 'col-12 col-md-9',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: contabilLancamentoOrcadoController.contabilContaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Conta Contabil',
																			labelText: 'Conta Contabil *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: contabilLancamentoOrcadoController.callContabilContaLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 4,
															controller: contabilLancamentoOrcadoController.anoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ano',
																labelText: 'Ano',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoOrcadoController.contabilLancamentoOrcadoModel.ano = text;
																contabilLancamentoOrcadoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: contabilLancamentoOrcadoController.janeiroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Janeiro',
																labelText: 'Janeiro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoOrcadoController.contabilLancamentoOrcadoModel.janeiro = contabilLancamentoOrcadoController.janeiroController.numberValue;
																contabilLancamentoOrcadoController.formWasChanged = true;
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
															controller: contabilLancamentoOrcadoController.fevereiroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fevereiro',
																labelText: 'Fevereiro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoOrcadoController.contabilLancamentoOrcadoModel.fevereiro = contabilLancamentoOrcadoController.fevereiroController.numberValue;
																contabilLancamentoOrcadoController.formWasChanged = true;
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
															controller: contabilLancamentoOrcadoController.marcoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Marco',
																labelText: 'Marco',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoOrcadoController.contabilLancamentoOrcadoModel.marco = contabilLancamentoOrcadoController.marcoController.numberValue;
																contabilLancamentoOrcadoController.formWasChanged = true;
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
															controller: contabilLancamentoOrcadoController.abrilController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Abril',
																labelText: 'Abril',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoOrcadoController.contabilLancamentoOrcadoModel.abril = contabilLancamentoOrcadoController.abrilController.numberValue;
																contabilLancamentoOrcadoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: contabilLancamentoOrcadoController.maioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Maio',
																labelText: 'Maio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoOrcadoController.contabilLancamentoOrcadoModel.maio = contabilLancamentoOrcadoController.maioController.numberValue;
																contabilLancamentoOrcadoController.formWasChanged = true;
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
															controller: contabilLancamentoOrcadoController.junhoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Junho',
																labelText: 'Junho',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoOrcadoController.contabilLancamentoOrcadoModel.junho = contabilLancamentoOrcadoController.junhoController.numberValue;
																contabilLancamentoOrcadoController.formWasChanged = true;
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
															controller: contabilLancamentoOrcadoController.julhoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Julho',
																labelText: 'Julho',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoOrcadoController.contabilLancamentoOrcadoModel.julho = contabilLancamentoOrcadoController.julhoController.numberValue;
																contabilLancamentoOrcadoController.formWasChanged = true;
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
															controller: contabilLancamentoOrcadoController.agostoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Agosto',
																labelText: 'Agosto',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoOrcadoController.contabilLancamentoOrcadoModel.agosto = contabilLancamentoOrcadoController.agostoController.numberValue;
																contabilLancamentoOrcadoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: contabilLancamentoOrcadoController.setembroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Setembro',
																labelText: 'Setembro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoOrcadoController.contabilLancamentoOrcadoModel.setembro = contabilLancamentoOrcadoController.setembroController.numberValue;
																contabilLancamentoOrcadoController.formWasChanged = true;
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
															controller: contabilLancamentoOrcadoController.outubroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Outubro',
																labelText: 'Outubro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoOrcadoController.contabilLancamentoOrcadoModel.outubro = contabilLancamentoOrcadoController.outubroController.numberValue;
																contabilLancamentoOrcadoController.formWasChanged = true;
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
															controller: contabilLancamentoOrcadoController.novembroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Novembro',
																labelText: 'Novembro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoOrcadoController.contabilLancamentoOrcadoModel.novembro = contabilLancamentoOrcadoController.novembroController.numberValue;
																contabilLancamentoOrcadoController.formWasChanged = true;
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
															controller: contabilLancamentoOrcadoController.dezembroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dezembro',
																labelText: 'Dezembro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoOrcadoController.contabilLancamentoOrcadoModel.dezembro = contabilLancamentoOrcadoController.dezembroController.numberValue;
																contabilLancamentoOrcadoController.formWasChanged = true;
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
