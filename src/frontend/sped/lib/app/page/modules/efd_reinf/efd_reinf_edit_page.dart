import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:sped/app/page/shared_widget/shared_widget_imports.dart';
import 'package:sped/app/controller/efd_reinf_controller.dart';
import 'package:sped/app/infra/infra_imports.dart';
import 'package:sped/app/page/shared_widget/input/input_imports.dart';

class EfdReinfEditPage extends StatelessWidget {
	EfdReinfEditPage({Key? key}) : super(key: key);
	final efdReinfController = Get.find<EfdReinfController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					efdReinfController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: efdReinfController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('EFD REINF - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: efdReinfController.save),
						cancelAndExitButton(onPressed: efdReinfController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: efdReinfController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: efdReinfController.scrollController,
							child: SingleChildScrollView(
								controller: efdReinfController.scrollController,
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
																dateTime: efdReinfController.efdReinfModel.dataEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	efdReinfController.efdReinfModel.dataEmissao = value;
																	efdReinfController.formWasChanged = true;
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
																dateTime: efdReinfController.efdReinfModel.periodoInicial,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	efdReinfController.efdReinfModel.periodoInicial = value;
																	efdReinfController.formWasChanged = true;
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
																dateTime: efdReinfController.efdReinfModel.periodoFinal,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	efdReinfController.efdReinfModel.periodoFinal = value;
																	efdReinfController.formWasChanged = true;
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
															controller: efdReinfController.finalidadeArquivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Finalidade Arquivo',
																labelText: 'Finalidade Arquivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																efdReinfController.efdReinfModel.finalidadeArquivo = text;
																efdReinfController.formWasChanged = true;
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
