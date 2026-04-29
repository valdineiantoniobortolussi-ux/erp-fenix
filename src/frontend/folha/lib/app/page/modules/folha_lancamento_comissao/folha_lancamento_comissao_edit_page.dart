import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/folha_lancamento_comissao_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FolhaLancamentoComissaoEditPage extends StatelessWidget {
	FolhaLancamentoComissaoEditPage({Key? key}) : super(key: key);
	final folhaLancamentoComissaoController = Get.find<FolhaLancamentoComissaoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					folhaLancamentoComissaoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: folhaLancamentoComissaoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Comissões - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: folhaLancamentoComissaoController.save),
						cancelAndExitButton(onPressed: folhaLancamentoComissaoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: folhaLancamentoComissaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: folhaLancamentoComissaoController.scrollController,
							child: SingleChildScrollView(
								controller: folhaLancamentoComissaoController.scrollController,
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
																		controller: folhaLancamentoComissaoController.viewPessoaColaboradorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Colaborador',
																			labelText: 'Colaborador *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: folhaLancamentoComissaoController.callViewPessoaColaboradorLookup),
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
															controller: folhaLancamentoComissaoController.competenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Competencia',
																labelText: 'Competencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaLancamentoComissaoController.folhaLancamentoComissaoModel.competencia = text;
																folhaLancamentoComissaoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Vencimento',
																labelText: 'Vencimento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: folhaLancamentoComissaoController.folhaLancamentoComissaoModel.vencimento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaLancamentoComissaoController.folhaLancamentoComissaoModel.vencimento = value;
																	folhaLancamentoComissaoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: folhaLancamentoComissaoController.baseCalculoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Base Calculo',
																labelText: 'Base Calculo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaLancamentoComissaoController.folhaLancamentoComissaoModel.baseCalculo = folhaLancamentoComissaoController.baseCalculoController.numberValue;
																folhaLancamentoComissaoController.formWasChanged = true;
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
															controller: folhaLancamentoComissaoController.valorComissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Comissao',
																labelText: 'Valor Comissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaLancamentoComissaoController.folhaLancamentoComissaoModel.valorComissao = folhaLancamentoComissaoController.valorComissaoController.numberValue;
																folhaLancamentoComissaoController.formWasChanged = true;
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
