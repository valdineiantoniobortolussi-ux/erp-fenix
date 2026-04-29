import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:patrimonio/app/page/shared_widget/shared_widget_imports.dart';
import 'package:patrimonio/app/controller/patrim_tipo_aquisicao_bem_controller.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/page/shared_widget/input/input_imports.dart';

class PatrimTipoAquisicaoBemEditPage extends StatelessWidget {
	PatrimTipoAquisicaoBemEditPage({Key? key}) : super(key: key);
	final patrimTipoAquisicaoBemController = Get.find<PatrimTipoAquisicaoBemController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					patrimTipoAquisicaoBemController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: patrimTipoAquisicaoBemController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tipo Aquisição Bem - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: patrimTipoAquisicaoBemController.save),
						cancelAndExitButton(onPressed: patrimTipoAquisicaoBemController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: patrimTipoAquisicaoBemController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: patrimTipoAquisicaoBemController.scrollController,
							child: SingleChildScrollView(
								controller: patrimTipoAquisicaoBemController.scrollController,
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
															value: patrimTipoAquisicaoBemController.patrimTipoAquisicaoBemModel.tipo ?? '1=Compra',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['1=Compra','2=Permuta','3=Doação','4=Locação','5=Comodato','6=Leasing','7=Transferência'],
															onChanged: (dynamic newValue) {
																patrimTipoAquisicaoBemController.patrimTipoAquisicaoBemModel.tipo = newValue;
																patrimTipoAquisicaoBemController.formWasChanged = true;
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
															maxLength: 50,
															controller: patrimTipoAquisicaoBemController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimTipoAquisicaoBemController.patrimTipoAquisicaoBemModel.nome = text;
																patrimTipoAquisicaoBemController.formWasChanged = true;
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
															controller: patrimTipoAquisicaoBemController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimTipoAquisicaoBemController.patrimTipoAquisicaoBemModel.descricao = text;
																patrimTipoAquisicaoBemController.formWasChanged = true;
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
