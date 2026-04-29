import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/controller/fornecedor_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class FornecedorEditPage extends StatelessWidget {
	FornecedorEditPage({Key? key}) : super(key: key);
	final fornecedorController = Get.find<FornecedorController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: fornecedorController.scaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: fornecedorController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: fornecedorController.scrollController,
							child: SingleChildScrollView(
								controller: fornecedorController.scrollController,
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
																hintText: 'Informe os dados para o campo Desde',
																labelText: 'Desde',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: fornecedorController.fornecedorModel.desde,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	fornecedorController.fornecedorModel.desde = value;
																	fornecedorController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Cadastro',
																labelText: 'Data Cadastro',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: fornecedorController.fornecedorModel.dataCadastro,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	fornecedorController.fornecedorModel.dataCadastro = value;
																	fornecedorController.formWasChanged = true;
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
															maxLength: 250,
															maxLines: 3,
															controller: fornecedorController.observacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Observacao',
																labelText: 'Observacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																fornecedorController.fornecedorModel.observacao = text;
																fornecedorController.formWasChanged = true;
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
