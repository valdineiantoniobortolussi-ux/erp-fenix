import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro/app/controller/fin_tipo_recebimento_controller.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/page/shared_widget/input/input_imports.dart';

class FinTipoRecebimentoEditPage extends StatelessWidget {
	FinTipoRecebimentoEditPage({Key? key}) : super(key: key);
	final finTipoRecebimentoController = Get.find<FinTipoRecebimentoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					finTipoRecebimentoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: finTipoRecebimentoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tipo Recebimento - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: finTipoRecebimentoController.save),
						cancelAndExitButton(onPressed: finTipoRecebimentoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: finTipoRecebimentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: finTipoRecebimentoController.scrollController,
							child: SingleChildScrollView(
								controller: finTipoRecebimentoController.scrollController,
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
															maxLength: 2,
															controller: finTipoRecebimentoController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finTipoRecebimentoController.finTipoRecebimentoModel.codigo = text;
																finTipoRecebimentoController.formWasChanged = true;
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
															controller: finTipoRecebimentoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																finTipoRecebimentoController.finTipoRecebimentoModel.descricao = text;
																finTipoRecebimentoController.formWasChanged = true;
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
