import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:sped/app/page/shared_widget/shared_widget_imports.dart';
import 'package:sped/app/controller/sped_contabil_controller.dart';
import 'package:sped/app/infra/infra_imports.dart';
import 'package:sped/app/page/shared_widget/input/input_imports.dart';

class SpedContabilEditPage extends StatelessWidget {
	SpedContabilEditPage({Key? key}) : super(key: key);
	final spedContabilController = Get.find<SpedContabilController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					spedContabilController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: spedContabilController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Sped Contábil - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: spedContabilController.save),
						cancelAndExitButton(onPressed: spedContabilController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: spedContabilController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: spedContabilController.scrollController,
							child: SingleChildScrollView(
								controller: spedContabilController.scrollController,
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Emissao',
																labelText: 'Data Emissao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: spedContabilController.spedContabilModel.dataEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	spedContabilController.spedContabilModel.dataEmissao = value;
																	spedContabilController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Periodo Inicial',
																labelText: 'Periodo Inicial',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: spedContabilController.spedContabilModel.periodoInicial,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	spedContabilController.spedContabilModel.periodoInicial = value;
																	spedContabilController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Periodo Final',
																labelText: 'Periodo Final',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: spedContabilController.spedContabilModel.periodoFinal,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	spedContabilController.spedContabilModel.periodoFinal = value;
																	spedContabilController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: spedContabilController.spedContabilModel.formaEscrituracao ?? 'G-Diário Geral',
															labelText: 'Forma Escrituracao',
															hintText: 'Informe os dados para o campo Forma Escrituracao',
															items: const ['G-Diário Geral','R-Diário com Escrituração Resumida','A-Diário Auxiliar','Z-Razão Auxiliar','B-Livro de Balancetes Diários e Balanços'],
															onChanged: (dynamic newValue) {
																spedContabilController.spedContabilModel.formaEscrituracao = newValue;
																spedContabilController.formWasChanged = true;
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
															controller: spedContabilController.versaoLayoutController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Versao Layout',
																labelText: 'Versao Layout',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																spedContabilController.spedContabilModel.versaoLayout = text;
																spedContabilController.formWasChanged = true;
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
