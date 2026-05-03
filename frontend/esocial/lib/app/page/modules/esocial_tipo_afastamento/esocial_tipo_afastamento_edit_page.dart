import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:esocial/app/page/shared_widget/shared_widget_imports.dart';
import 'package:esocial/app/controller/esocial_tipo_afastamento_controller.dart';
import 'package:esocial/app/infra/infra_imports.dart';
import 'package:esocial/app/page/shared_widget/input/input_imports.dart';

class EsocialTipoAfastamentoEditPage extends StatelessWidget {
	EsocialTipoAfastamentoEditPage({Key? key}) : super(key: key);
	final esocialTipoAfastamentoController = Get.find<EsocialTipoAfastamentoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					esocialTipoAfastamentoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: esocialTipoAfastamentoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tipo Afastamento - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: esocialTipoAfastamentoController.save),
						cancelAndExitButton(onPressed: esocialTipoAfastamentoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: esocialTipoAfastamentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: esocialTipoAfastamentoController.scrollController,
							child: SingleChildScrollView(
								controller: esocialTipoAfastamentoController.scrollController,
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
															maxLength: 2,
															controller: esocialTipoAfastamentoController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																esocialTipoAfastamentoController.esocialTipoAfastamentoModel.codigo = text;
																esocialTipoAfastamentoController.formWasChanged = true;
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
															controller: esocialTipoAfastamentoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																esocialTipoAfastamentoController.esocialTipoAfastamentoModel.descricao = text;
																esocialTipoAfastamentoController.formWasChanged = true;
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
