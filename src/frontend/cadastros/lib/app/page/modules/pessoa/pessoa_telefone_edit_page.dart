import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/pessoa_telefone_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class PessoaTelefoneEditPage extends StatelessWidget {
	PessoaTelefoneEditPage({Key? key}) : super(key: key);
	final pessoaTelefoneController = Get.find<PessoaTelefoneController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: pessoaTelefoneController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Telefones - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: pessoaTelefoneController.save),
						cancelAndExitButton(onPressed: pessoaTelefoneController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pessoaTelefoneController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pessoaTelefoneController.scrollController,
							child: SingleChildScrollView(
								controller: pessoaTelefoneController.scrollController,
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
														child: CustomDropdownButtonFormField(
															value: pessoaTelefoneController.pessoaTelefoneModel.tipo ?? 'Fixo',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['Fixo','Celular','Whatsapp'],
															onChanged: (dynamic newValue) {
																pessoaTelefoneController.pessoaTelefoneModel.tipo = newValue;
																pessoaTelefoneController.formWasChanged = true;
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
															controller: pessoaTelefoneController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pessoaTelefoneController.pessoaTelefoneModel.numero = text;
																pessoaTelefoneController.formWasChanged = true;
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
