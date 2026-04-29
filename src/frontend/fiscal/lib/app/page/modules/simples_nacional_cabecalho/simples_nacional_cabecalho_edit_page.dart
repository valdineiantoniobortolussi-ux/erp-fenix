import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:fiscal/app/controller/simples_nacional_cabecalho_controller.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/page/shared_widget/input/input_imports.dart';

class SimplesNacionalCabecalhoEditPage extends StatelessWidget {
	SimplesNacionalCabecalhoEditPage({Key? key}) : super(key: key);
	final simplesNacionalCabecalhoController = Get.find<SimplesNacionalCabecalhoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: simplesNacionalCabecalhoController.simplesNacionalCabecalhoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: simplesNacionalCabecalhoController.simplesNacionalCabecalhoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: simplesNacionalCabecalhoController.scrollController,
							child: SingleChildScrollView(
								controller: simplesNacionalCabecalhoController.scrollController,
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Vigencia Inicial',
																labelText: 'Vigencia Inicial',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: simplesNacionalCabecalhoController.simplesNacionalCabecalhoModel.vigenciaInicial,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	simplesNacionalCabecalhoController.simplesNacionalCabecalhoModel.vigenciaInicial = value;
																	simplesNacionalCabecalhoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Vigencia Final',
																labelText: 'Vigencia Final',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: simplesNacionalCabecalhoController.simplesNacionalCabecalhoModel.vigenciaFinal,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	simplesNacionalCabecalhoController.simplesNacionalCabecalhoModel.vigenciaFinal = value;
																	simplesNacionalCabecalhoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 10,
															controller: simplesNacionalCabecalhoController.anexoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Anexo',
																labelText: 'Anexo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalCabecalhoController.simplesNacionalCabecalhoModel.anexo = text;
																simplesNacionalCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 10,
															controller: simplesNacionalCabecalhoController.tabelaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Tabela',
																labelText: 'Tabela',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																simplesNacionalCabecalhoController.simplesNacionalCabecalhoModel.tabela = text;
																simplesNacionalCabecalhoController.formWasChanged = true;
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
			);
	}
}
