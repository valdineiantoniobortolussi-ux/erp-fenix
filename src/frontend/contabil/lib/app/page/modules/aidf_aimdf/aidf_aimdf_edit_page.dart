import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/aidf_aimdf_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class AidfAimdfEditPage extends StatelessWidget {
	AidfAimdfEditPage({Key? key}) : super(key: key);
	final aidfAimdfController = Get.find<AidfAimdfController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					aidfAimdfController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: aidfAimdfController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('AIDF/AIMDF - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: aidfAimdfController.save),
						cancelAndExitButton(onPressed: aidfAimdfController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: aidfAimdfController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: aidfAimdfController.scrollController,
							child: SingleChildScrollView(
								controller: aidfAimdfController.scrollController,
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
														child: TextFormField(
															autofocus: true,
															controller: aidfAimdfController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																aidfAimdfController.aidfAimdfModel.numero = int.tryParse(text);
																aidfAimdfController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Validade',
																labelText: 'Data Validade',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: aidfAimdfController.aidfAimdfModel.dataValidade,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	aidfAimdfController.aidfAimdfModel.dataValidade = value;
																	aidfAimdfController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Autorizacao',
																labelText: 'Data Autorizacao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: aidfAimdfController.aidfAimdfModel.dataAutorizacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	aidfAimdfController.aidfAimdfModel.dataAutorizacao = value;
																	aidfAimdfController.formWasChanged = true;
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
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 20,
															controller: aidfAimdfController.numeroAutorizacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Autorizacao',
																labelText: 'Numero Autorizacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																aidfAimdfController.aidfAimdfModel.numeroAutorizacao = text;
																aidfAimdfController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: aidfAimdfController.aidfAimdfModel.formularioDisponivel ?? 'Sim',
															labelText: 'Formulario Disponivel',
															hintText: 'Informe os dados para o campo Formulario Disponivel',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																aidfAimdfController.aidfAimdfModel.formularioDisponivel = newValue;
																aidfAimdfController.formWasChanged = true;
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
