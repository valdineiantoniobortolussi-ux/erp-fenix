import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:patrimonio/app/page/shared_widget/shared_widget_imports.dart';
import 'package:patrimonio/app/controller/patrim_tipo_movimentacao_controller.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/page/shared_widget/input/input_imports.dart';

class PatrimTipoMovimentacaoEditPage extends StatelessWidget {
	PatrimTipoMovimentacaoEditPage({Key? key}) : super(key: key);
	final patrimTipoMovimentacaoController = Get.find<PatrimTipoMovimentacaoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					patrimTipoMovimentacaoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: patrimTipoMovimentacaoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tipo Movimentação Bem - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: patrimTipoMovimentacaoController.save),
						cancelAndExitButton(onPressed: patrimTipoMovimentacaoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: patrimTipoMovimentacaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: patrimTipoMovimentacaoController.scrollController,
							child: SingleChildScrollView(
								controller: patrimTipoMovimentacaoController.scrollController,
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
															value: patrimTipoMovimentacaoController.patrimTipoMovimentacaoModel.tipo ?? '1=Distribuição',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['1=Distribuição','2=Remanejamento','3=Saída Provisória','4=Empréstimo','5=Arrendamento'],
															onChanged: (dynamic newValue) {
																patrimTipoMovimentacaoController.patrimTipoMovimentacaoModel.tipo = newValue;
																patrimTipoMovimentacaoController.formWasChanged = true;
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
															controller: patrimTipoMovimentacaoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimTipoMovimentacaoController.patrimTipoMovimentacaoModel.nome = text;
																patrimTipoMovimentacaoController.formWasChanged = true;
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
															controller: patrimTipoMovimentacaoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimTipoMovimentacaoController.patrimTipoMovimentacaoModel.descricao = text;
																patrimTipoMovimentacaoController.formWasChanged = true;
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
