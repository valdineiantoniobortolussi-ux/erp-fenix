import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:sped/app/page/shared_widget/shared_widget_imports.dart';
import 'package:sped/app/controller/efd_contribuicoes_controller.dart';
import 'package:sped/app/infra/infra_imports.dart';
import 'package:sped/app/page/shared_widget/input/input_imports.dart';

class EfdContribuicoesEditPage extends StatelessWidget {
	EfdContribuicoesEditPage({Key? key}) : super(key: key);
	final efdContribuicoesController = Get.find<EfdContribuicoesController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					efdContribuicoesController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: efdContribuicoesController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('EFD Contribuições - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: efdContribuicoesController.save),
						cancelAndExitButton(onPressed: efdContribuicoesController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: efdContribuicoesController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: efdContribuicoesController.scrollController,
							child: SingleChildScrollView(
								controller: efdContribuicoesController.scrollController,
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Emissao',
																labelText: 'Data Emissao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: efdContribuicoesController.efdContribuicoesModel.dataEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	efdContribuicoesController.efdContribuicoesModel.dataEmissao = value;
																	efdContribuicoesController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
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
																dateTime: efdContribuicoesController.efdContribuicoesModel.periodoInicial,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	efdContribuicoesController.efdContribuicoesModel.periodoInicial = value;
																	efdContribuicoesController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
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
																dateTime: efdContribuicoesController.efdContribuicoesModel.periodoFinal,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	efdContribuicoesController.efdContribuicoesModel.periodoFinal = value;
																	efdContribuicoesController.formWasChanged = true;
																},
															),
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
															controller: efdContribuicoesController.finalidadeArquivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Finalidade Arquivo',
																labelText: 'Finalidade Arquivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																efdContribuicoesController.efdContribuicoesModel.finalidadeArquivo = text;
																efdContribuicoesController.formWasChanged = true;
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
