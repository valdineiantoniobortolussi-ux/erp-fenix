import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:tributacao/app/page/shared_widget/shared_widget_imports.dart';
import 'package:tributacao/app/controller/tribut_grupo_tributario_controller.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/page/shared_widget/input/input_imports.dart';

class TributGrupoTributarioEditPage extends StatelessWidget {
	TributGrupoTributarioEditPage({Key? key}) : super(key: key);
	final tributGrupoTributarioController = Get.find<TributGrupoTributarioController>();

	@override
	Widget build(BuildContext context) {
return KeyboardListener(
      autofocus: false,
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event.logicalKey == LogicalKeyboardKey.escape) {
					tributGrupoTributarioController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: tributGrupoTributarioController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tribut Grupo Tributario - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: tributGrupoTributarioController.save),
						cancelAndExitButton(onPressed: tributGrupoTributarioController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: tributGrupoTributarioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: tributGrupoTributarioController.scrollController,
							child: SingleChildScrollView(
								controller: tributGrupoTributarioController.scrollController,
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
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: tributGrupoTributarioController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descrição',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributGrupoTributarioController.tributGrupoTributarioModel.descricao = text;
																tributGrupoTributarioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: tributGrupoTributarioController.tributGrupoTributarioModel.origemMercadoria ?? '0=Nacional',
															labelText: 'Origem Mercadoria',
															hintText: 'Informe os dados para o campo Origem Mercadoria',
															items: const ['0=Nacional','1=Estrangeira - Importação Direta','2=Estrangeira - Adquirida no Mercado Interno'],
															onChanged: (dynamic newValue) {
																tributGrupoTributarioController.tributGrupoTributarioModel.origemMercadoria = newValue;
																tributGrupoTributarioController.formWasChanged = true;
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
															controller: tributGrupoTributarioController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observação',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																tributGrupoTributarioController.tributGrupoTributarioModel.observacao = text;
																tributGrupoTributarioController.formWasChanged = true;
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
