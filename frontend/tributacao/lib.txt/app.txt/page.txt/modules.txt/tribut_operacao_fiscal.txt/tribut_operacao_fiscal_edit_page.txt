import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:tributacao/app/page/shared_widget/shared_widget_imports.dart';
import 'package:tributacao/app/controller/tribut_operacao_fiscal_controller.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/page/shared_widget/input/input_imports.dart';

class TributOperacaoFiscalEditPage extends StatelessWidget {
	TributOperacaoFiscalEditPage({Key? key}) : super(key: key);
	final tributOperacaoFiscalController = Get.find<TributOperacaoFiscalController>();

	@override
	Widget build(BuildContext context) {
return KeyboardListener(
      autofocus: false,
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event.logicalKey == LogicalKeyboardKey.escape) {
					tributOperacaoFiscalController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: tributOperacaoFiscalController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tribut Operacao Fiscal - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: tributOperacaoFiscalController.save),
						cancelAndExitButton(onPressed: tributOperacaoFiscalController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: tributOperacaoFiscalController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: tributOperacaoFiscalController.scrollController,
							child: SingleChildScrollView(
								controller: tributOperacaoFiscalController.scrollController,
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: tributOperacaoFiscalController.cfopController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cfop',
																labelText: 'CFOP',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributOperacaoFiscalController.tributOperacaoFiscalModel.cfop = int.tryParse(text);
																tributOperacaoFiscalController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-9',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: tributOperacaoFiscalController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descrição',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributOperacaoFiscalController.tributOperacaoFiscalModel.descricao = text;
																tributOperacaoFiscalController.formWasChanged = true;
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
															controller: tributOperacaoFiscalController.descricaoNaNfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao Na Nf',
																labelText: 'Descrição Na Nota Fiscal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributOperacaoFiscalController.tributOperacaoFiscalModel.descricaoNaNf = text;
																tributOperacaoFiscalController.formWasChanged = true;
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
															maxLines: 3,
															controller: tributOperacaoFiscalController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observação',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributOperacaoFiscalController.tributOperacaoFiscalModel.observacao = text;
																tributOperacaoFiscalController.formWasChanged = true;
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
