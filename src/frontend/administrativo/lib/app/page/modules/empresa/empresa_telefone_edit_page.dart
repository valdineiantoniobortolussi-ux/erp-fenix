import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:administrativo/app/page/shared_widget/shared_widget_imports.dart';
import 'package:administrativo/app/controller/empresa_telefone_controller.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/page/shared_widget/input/input_imports.dart';

class EmpresaTelefoneEditPage extends StatelessWidget {
	EmpresaTelefoneEditPage({Key? key}) : super(key: key);
	final empresaTelefoneController = Get.find<EmpresaTelefoneController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: empresaTelefoneController.empresaTelefoneScaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('${ empresaTelefoneController.screenTitle } - ${ empresaTelefoneController.isNewRecord ? 'inserting'.tr : 'editing'.tr }',),
					actions: [
						saveButton(onPressed: empresaTelefoneController.save),
						cancelAndExitButton(onPressed: empresaTelefoneController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: empresaTelefoneController.empresaTelefoneFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: empresaTelefoneController.scrollController,
							child: SingleChildScrollView(
								controller: empresaTelefoneController.scrollController,
								child: BootstrapContainer(
									fluid: true,
									padding: const EdgeInsets.all(10.0),
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
														child: CustomDropdownButton(
															value: empresaTelefoneController.empresaTelefoneModel.tipo ?? 'Fixo',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Fixo','Celular','WhatsApp'],
															onChanged: (dynamic newValue) {
																empresaTelefoneController.empresaTelefoneModel.tipo = newValue;
																empresaTelefoneController.formWasChangedDetail = true;
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
															controller: empresaTelefoneController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Número',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaTelefoneController.empresaTelefoneModel.numero = text;
																empresaTelefoneController.formWasChangedDetail = true;
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
