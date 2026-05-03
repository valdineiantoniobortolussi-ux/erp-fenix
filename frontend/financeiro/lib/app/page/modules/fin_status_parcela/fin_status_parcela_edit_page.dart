import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro/app/controller/fin_status_parcela_controller.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/page/shared_widget/input/input_imports.dart';

class FinStatusParcelaEditPage extends StatelessWidget {
	FinStatusParcelaEditPage({Key? key}) : super(key: key);
	final finStatusParcelaController = Get.find<FinStatusParcelaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					finStatusParcelaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: finStatusParcelaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Status Parcela - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: finStatusParcelaController.save),
						cancelAndExitButton(onPressed: finStatusParcelaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: finStatusParcelaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: finStatusParcelaController.scrollController,
							child: SingleChildScrollView(
								controller: finStatusParcelaController.scrollController,
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
														child: CustomDropdownButtonFormField(
															value: finStatusParcelaController.finStatusParcelaModel.situacao ?? '01 = Aberto',
															labelText: 'Situacao',
															hintText: 'Informe os dados para o campo Situacao',
															items: const ['01 = Aberto','02 = Quitado','03 = Quitado Parcial','04 = Vencido','05 = Renegociado'],
															onChanged: (dynamic newValue) {
																finStatusParcelaController.finStatusParcelaModel.situacao = newValue;
																finStatusParcelaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 30,
															controller: finStatusParcelaController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finStatusParcelaController.finStatusParcelaModel.descricao = text;
																finStatusParcelaController.formWasChanged = true;
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
															controller: finStatusParcelaController.procedimentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Procedimento',
																labelText: 'Procedimento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finStatusParcelaController.finStatusParcelaModel.procedimento = text;
																finStatusParcelaController.formWasChanged = true;
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
