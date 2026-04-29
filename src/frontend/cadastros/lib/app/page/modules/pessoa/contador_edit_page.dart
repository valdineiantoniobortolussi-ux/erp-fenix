import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/controller/contador_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class ContadorEditPage extends StatelessWidget {
	ContadorEditPage({Key? key}) : super(key: key);
	final contadorController = Get.find<ContadorController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: contadorController.scaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contadorController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contadorController.scrollController,
							child: SingleChildScrollView(
								controller: contadorController.scrollController,
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
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 15,
															controller: contadorController.crcInscricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Inscricao CRC',
																labelText: 'Inscricao CRC',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contadorController.contadorModel.crcInscricao = text;
																contadorController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contadorController.contadorModel.crcUf ?? 'AC',
															labelText: 'UF CRC',
															hintText: 'Informe os dados para o campo UF CRC',
															items: const ['AC','AL','AM','AP','BA','CE','DF','ES','GO','MA','MG','MS','MT','PA','PB','PE','PI','PR','RJ','RN','RO','RR','RS','SC','SE','SP','TO'],
															onChanged: (dynamic newValue) {
																contadorController.contadorModel.crcUf = newValue;
																contadorController.formWasChanged = true;
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
