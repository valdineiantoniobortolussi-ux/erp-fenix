import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/folha_rescisao_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FolhaRescisaoEditPage extends StatelessWidget {
	FolhaRescisaoEditPage({Key? key}) : super(key: key);
	final folhaRescisaoController = Get.find<FolhaRescisaoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					folhaRescisaoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: folhaRescisaoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Rescisão - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: folhaRescisaoController.save),
						cancelAndExitButton(onPressed: folhaRescisaoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: folhaRescisaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: folhaRescisaoController.scrollController,
							child: SingleChildScrollView(
								controller: folhaRescisaoController.scrollController,
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
																		controller: folhaRescisaoController.viewPessoaColaboradorModelController,
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
																child: lookupButton(onPressed: folhaRescisaoController.callViewPessoaColaboradorLookup),
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Demissao',
																labelText: 'Data Demissao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: folhaRescisaoController.folhaRescisaoModel.dataDemissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaRescisaoController.folhaRescisaoModel.dataDemissao = value;
																	folhaRescisaoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Pagamento',
																labelText: 'Data Pagamento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: folhaRescisaoController.folhaRescisaoModel.dataPagamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaRescisaoController.folhaRescisaoModel.dataPagamento = value;
																	folhaRescisaoController.formWasChanged = true;
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: folhaRescisaoController.motivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Motivo',
																labelText: 'Motivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaRescisaoController.folhaRescisaoModel.motivo = text;
																folhaRescisaoController.formWasChanged = true;
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
															maxLength: 2,
															controller: folhaRescisaoController.motivoEsocialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Motivo Esocial',
																labelText: 'Motivo Esocial',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaRescisaoController.folhaRescisaoModel.motivoEsocial = text;
																folhaRescisaoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Aviso Previo',
																labelText: 'Data Aviso Previo',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: folhaRescisaoController.folhaRescisaoModel.dataAvisoPrevio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaRescisaoController.folhaRescisaoModel.dataAvisoPrevio = value;
																	folhaRescisaoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: folhaRescisaoController.diasAvisoPrevioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Dias Aviso Previo',
																labelText: 'Dias Aviso Previo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaRescisaoController.folhaRescisaoModel.diasAvisoPrevio = int.tryParse(text);
																folhaRescisaoController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: folhaRescisaoController.folhaRescisaoModel.comprovouNovoEmprego ?? 'Sim',
															labelText: 'Comprovou Novo Emprego',
															hintText: 'Informe os dados para o campo Comprovou Novo Emprego',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaRescisaoController.folhaRescisaoModel.comprovouNovoEmprego = newValue;
																folhaRescisaoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaRescisaoController.folhaRescisaoModel.dispensouEmpregado ?? 'Sim',
															labelText: 'Dispensou Empregado',
															hintText: 'Informe os dados para o campo Dispensou Empregado',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																folhaRescisaoController.folhaRescisaoModel.dispensouEmpregado = newValue;
																folhaRescisaoController.formWasChanged = true;
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
															controller: folhaRescisaoController.pensaoAlimenticiaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Pensao Alimenticia',
																labelText: 'Pensao Alimenticia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaRescisaoController.folhaRescisaoModel.pensaoAlimenticia = folhaRescisaoController.pensaoAlimenticiaController.numberValue;
																folhaRescisaoController.formWasChanged = true;
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
															controller: folhaRescisaoController.pensaoAlimenticiaFgtsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Pensao Alimenticia Fgts',
																labelText: 'Pensao Alimenticia Fgts',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaRescisaoController.folhaRescisaoModel.pensaoAlimenticiaFgts = folhaRescisaoController.pensaoAlimenticiaFgtsController.numberValue;
																folhaRescisaoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: folhaRescisaoController.fgtsValorRescisaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fgts Valor Rescisao',
																labelText: 'Fgts Valor Rescisao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaRescisaoController.folhaRescisaoModel.fgtsValorRescisao = folhaRescisaoController.fgtsValorRescisaoController.numberValue;
																folhaRescisaoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: folhaRescisaoController.fgtsSaldoBancoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fgts Saldo Banco',
																labelText: 'Fgts Saldo Banco',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaRescisaoController.folhaRescisaoModel.fgtsSaldoBanco = folhaRescisaoController.fgtsSaldoBancoController.numberValue;
																folhaRescisaoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-2',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: folhaRescisaoController.fgtsComplementoSaldoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fgts Complemento Saldo',
																labelText: 'Fgts Complemento Saldo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaRescisaoController.folhaRescisaoModel.fgtsComplementoSaldo = folhaRescisaoController.fgtsComplementoSaldoController.numberValue;
																folhaRescisaoController.formWasChanged = true;
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
															maxLength: 10,
															controller: folhaRescisaoController.fgtsCodigoAfastamentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fgts Codigo Afastamento',
																labelText: 'Fgts Codigo Afastamento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaRescisaoController.folhaRescisaoModel.fgtsCodigoAfastamento = text;
																folhaRescisaoController.formWasChanged = true;
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
															maxLength: 10,
															controller: folhaRescisaoController.fgtsCodigoSaqueController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Fgts Codigo Saque',
																labelText: 'Fgts Codigo Saque',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaRescisaoController.folhaRescisaoModel.fgtsCodigoSaque = text;
																folhaRescisaoController.formWasChanged = true;
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
