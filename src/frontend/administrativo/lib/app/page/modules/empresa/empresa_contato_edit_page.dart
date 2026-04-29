import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:administrativo/app/page/shared_widget/shared_widget_imports.dart';
import 'package:administrativo/app/controller/empresa_contato_controller.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/page/shared_widget/input/input_imports.dart';

class EmpresaContatoEditPage extends StatelessWidget {
	EmpresaContatoEditPage({Key? key}) : super(key: key);
	final empresaContatoController = Get.find<EmpresaContatoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: empresaContatoController.empresaContatoScaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('${ empresaContatoController.screenTitle } - ${ empresaContatoController.isNewRecord ? 'inserting'.tr : 'editing'.tr }',),
					actions: [
						saveButton(onPressed: empresaContatoController.save),
						cancelAndExitButton(onPressed: empresaContatoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: empresaContatoController.empresaContatoFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: empresaContatoController.scrollController,
							child: SingleChildScrollView(
								controller: empresaContatoController.scrollController,
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 150,
															controller: empresaContatoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaContatoController.empresaContatoModel.nome = text;
																empresaContatoController.formWasChangedDetail = true;
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
															validator: ValidateFormField.validateEmail,
															maxLength: 250,
															controller: empresaContatoController.emailController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Email',
																labelText: 'Email',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaContatoController.empresaContatoModel.email = text;
																empresaContatoController.formWasChangedDetail = true;
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
															maxLength: 250,
															maxLines: 3,
															controller: empresaContatoController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observação',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaContatoController.empresaContatoModel.observacao = text;
																empresaContatoController.formWasChangedDetail = true;
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
