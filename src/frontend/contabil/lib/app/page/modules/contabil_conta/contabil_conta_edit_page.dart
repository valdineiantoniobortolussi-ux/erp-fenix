import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/contabil_conta_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class ContabilContaEditPage extends StatelessWidget {
	ContabilContaEditPage({Key? key}) : super(key: key);
	final contabilContaController = Get.find<ContabilContaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					contabilContaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: contabilContaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Conta Contábil - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: contabilContaController.save),
						cancelAndExitButton(onPressed: contabilContaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contabilContaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contabilContaController.scrollController,
							child: SingleChildScrollView(
								controller: contabilContaController.scrollController,
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
													sizes: 'col-12 col-md-6',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: contabilContaController.planoContaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Plano Conta',
																			labelText: 'Plano Conta *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: contabilContaController.callPlanoContaLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: contabilContaController.planoContaRefSpedModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Conta SPED',
																			labelText: 'Conta SPED',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: contabilContaController.callPlanoContaRefSpedLookup),
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
															controller: contabilContaController.idContabilContaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Conta Pai',
																labelText: 'Conta Pai',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilContaController.contabilContaModel.idContabilConta = int.tryParse(text);
																contabilContaController.formWasChanged = true;
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
															maxLength: 30,
															controller: contabilContaController.classificacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Classificacao',
																labelText: 'Classificacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilContaController.contabilContaModel.classificacao = text;
																contabilContaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilContaController.contabilContaModel.tipo ?? 'Sintética',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Sintética','Analítica'],
															onChanged: (dynamic newValue) {
																contabilContaController.contabilContaModel.tipo = newValue;
																contabilContaController.formWasChanged = true;
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
															maxLength: 100,
															controller: contabilContaController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilContaController.contabilContaModel.descricao = text;
																contabilContaController.formWasChanged = true;
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Inclusao',
																labelText: 'Data Inclusao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: contabilContaController.contabilContaModel.dataInclusao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contabilContaController.contabilContaModel.dataInclusao = value;
																	contabilContaController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilContaController.contabilContaModel.situacao ?? 'Ativa',
															labelText: 'Situacao',
															hintText: 'Informe os dados para o campo Situacao',
															items: const ['Ativa','Inativa'],
															onChanged: (dynamic newValue) {
																contabilContaController.contabilContaModel.situacao = newValue;
																contabilContaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilContaController.contabilContaModel.natureza ?? 'Credora',
															labelText: 'Natureza',
															hintText: 'Informe os dados para o campo Natureza',
															items: const ['Credora','Devedora'],
															onChanged: (dynamic newValue) {
																contabilContaController.contabilContaModel.natureza = newValue;
																contabilContaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilContaController.contabilContaModel.patrimonioResultado ?? 'Patrimonio',
															labelText: 'Patrimonio Resultado',
															hintText: 'Informe os dados para o campo Patrimonio Resultado',
															items: const ['Patrimonio','Resultado'],
															onChanged: (dynamic newValue) {
																contabilContaController.contabilContaModel.patrimonioResultado = newValue;
																contabilContaController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: contabilContaController.contabilContaModel.livroCaixa ?? 'Sim',
															labelText: 'Livro Caixa',
															hintText: 'Informe os dados para o campo Livro Caixa',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																contabilContaController.contabilContaModel.livroCaixa = newValue;
																contabilContaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilContaController.contabilContaModel.dfc ?? 'Não participa',
															labelText: 'DFC',
															hintText: 'Informe os dados para o campo DFC',
															items: const ['Não participa','Atividades Operacionais','Atividades de Financiamento','Atividades de Investimento'],
															onChanged: (dynamic newValue) {
																contabilContaController.contabilContaModel.dfc = newValue;
																contabilContaController.formWasChanged = true;
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
															maxLength: 2,
															controller: contabilContaController.codigoEfdController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo EFD',
																labelText: 'Codigo EFD',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilContaController.contabilContaModel.codigoEfd = text;
																contabilContaController.formWasChanged = true;
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
															maxLength: 20,
															controller: contabilContaController.ordemController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ordem',
																labelText: 'Ordem',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilContaController.contabilContaModel.ordem = text;
																contabilContaController.formWasChanged = true;
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
															maxLength: 10,
															controller: contabilContaController.codigoReduzidoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Reduzido',
																labelText: 'Codigo Reduzido',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilContaController.contabilContaModel.codigoReduzido = text;
																contabilContaController.formWasChanged = true;
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
