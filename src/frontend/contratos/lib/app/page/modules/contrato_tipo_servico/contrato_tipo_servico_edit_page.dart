import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contratos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contratos/app/controller/contrato_tipo_servico_controller.dart';
import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/page/shared_widget/input/input_imports.dart';

class ContratoTipoServicoEditPage extends StatelessWidget {
	ContratoTipoServicoEditPage({Key? key}) : super(key: key);
	final contratoTipoServicoController = Get.find<ContratoTipoServicoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					contratoTipoServicoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: contratoTipoServicoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tipo de Serviço - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: contratoTipoServicoController.save),
						cancelAndExitButton(onPressed: contratoTipoServicoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contratoTipoServicoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contratoTipoServicoController.scrollController,
							child: SingleChildScrollView(
								controller: contratoTipoServicoController.scrollController,
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
															maxLength: 50,
															controller: contratoTipoServicoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contratoTipoServicoController.contratoTipoServicoModel.nome = text;
																contratoTipoServicoController.formWasChanged = true;
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
															controller: contratoTipoServicoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contratoTipoServicoController.contratoTipoServicoModel.descricao = text;
																contratoTipoServicoController.formWasChanged = true;
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
