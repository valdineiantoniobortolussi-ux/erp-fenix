import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/registro_cartorio_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class RegistroCartorioEditPage extends StatelessWidget {
	RegistroCartorioEditPage({Key? key}) : super(key: key);
	final registroCartorioController = Get.find<RegistroCartorioController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					registroCartorioController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: registroCartorioController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Registro em Cartório - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: registroCartorioController.save),
						cancelAndExitButton(onPressed: registroCartorioController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: registroCartorioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: registroCartorioController.scrollController,
							child: SingleChildScrollView(
								controller: registroCartorioController.scrollController,
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
															controller: registroCartorioController.nomeCartorioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome Cartorio',
																labelText: 'Nome Cartorio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																registroCartorioController.registroCartorioModel.nomeCartorio = text;
																registroCartorioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Registro',
																labelText: 'Data Registro',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: registroCartorioController.registroCartorioModel.dataRegistro,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	registroCartorioController.registroCartorioModel.dataRegistro = value;
																	registroCartorioController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: registroCartorioController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																registroCartorioController.registroCartorioModel.numero = int.tryParse(text);
																registroCartorioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: registroCartorioController.folhaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Folha',
																labelText: 'Folha',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																registroCartorioController.registroCartorioModel.folha = int.tryParse(text);
																registroCartorioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: registroCartorioController.livroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Livro',
																labelText: 'Livro',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																registroCartorioController.registroCartorioModel.livro = int.tryParse(text);
																registroCartorioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 11,
															controller: registroCartorioController.nireController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo NIRE',
																labelText: 'NIRE',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																registroCartorioController.registroCartorioModel.nire = text;
																registroCartorioController.formWasChanged = true;
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
