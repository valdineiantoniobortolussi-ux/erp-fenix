import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:esocial/app/page/shared_widget/shared_widget_imports.dart';
import 'package:esocial/app/controller/esocial_classificacao_tribut_controller.dart';
import 'package:esocial/app/infra/infra_imports.dart';
import 'package:esocial/app/page/shared_widget/input/input_imports.dart';

class EsocialClassificacaoTributEditPage extends StatelessWidget {
	EsocialClassificacaoTributEditPage({Key? key}) : super(key: key);
	final esocialClassificacaoTributController = Get.find<EsocialClassificacaoTributController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					esocialClassificacaoTributController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: esocialClassificacaoTributController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Classificação Tributária - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: esocialClassificacaoTributController.save),
						cancelAndExitButton(onPressed: esocialClassificacaoTributController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: esocialClassificacaoTributController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: esocialClassificacaoTributController.scrollController,
							child: SingleChildScrollView(
								controller: esocialClassificacaoTributController.scrollController,
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
															controller: esocialClassificacaoTributController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																esocialClassificacaoTributController.esocialClassificacaoTributModel.codigo = text;
																esocialClassificacaoTributController.formWasChanged = true;
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
															controller: esocialClassificacaoTributController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																esocialClassificacaoTributController.esocialClassificacaoTributModel.descricao = text;
																esocialClassificacaoTributController.formWasChanged = true;
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
