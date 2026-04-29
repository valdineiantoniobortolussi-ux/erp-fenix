import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:sped/app/page/shared_widget/shared_widget_imports.dart';
import 'package:sped/app/controller/sped_fiscal_controller.dart';
import 'package:sped/app/infra/infra_imports.dart';
import 'package:sped/app/page/shared_widget/input/input_imports.dart';

class SpedFiscalEditPage extends StatelessWidget {
	SpedFiscalEditPage({Key? key}) : super(key: key);
	final spedFiscalController = Get.find<SpedFiscalController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					spedFiscalController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: spedFiscalController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Sped Fiscal - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: spedFiscalController.save),
						cancelAndExitButton(onPressed: spedFiscalController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: spedFiscalController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: spedFiscalController.scrollController,
							child: SingleChildScrollView(
								controller: spedFiscalController.scrollController,
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
																dateTime: spedFiscalController.spedFiscalModel.dataEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	spedFiscalController.spedFiscalModel.dataEmissao = value;
																	spedFiscalController.formWasChanged = true;
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
																dateTime: spedFiscalController.spedFiscalModel.periodoInicial,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	spedFiscalController.spedFiscalModel.periodoInicial = value;
																	spedFiscalController.formWasChanged = true;
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
																dateTime: spedFiscalController.spedFiscalModel.periodoFinal,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	spedFiscalController.spedFiscalModel.periodoFinal = value;
																	spedFiscalController.formWasChanged = true;
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
															value: spedFiscalController.spedFiscalModel.perfilApresentacao ?? 'A',
															labelText: 'Perfil Apresentacao',
															hintText: 'Informe os dados para o campo Perfil Apresentacao',
															items: const ['A','B','C'],
															onChanged: (dynamic newValue) {
																spedFiscalController.spedFiscalModel.perfilApresentacao = newValue;
																spedFiscalController.formWasChanged = true;
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
															controller: spedFiscalController.finalidadeArquivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Finalidade Arquivo',
																labelText: 'Finalidade Arquivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																spedFiscalController.spedFiscalModel.finalidadeArquivo = text;
																spedFiscalController.formWasChanged = true;
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
															controller: spedFiscalController.versaoLayoutController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Versao Layout',
																labelText: 'Versao Layout',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																spedFiscalController.spedFiscalModel.versaoLayout = text;
																spedFiscalController.formWasChanged = true;
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
