import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:mdfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:mdfe/app/controller/mdfe_rodoviario_pedagio_controller.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/page/shared_widget/input/input_imports.dart';

class MdfeRodoviarioPedagioEditPage extends StatelessWidget {
	MdfeRodoviarioPedagioEditPage({Key? key}) : super(key: key);
	final mdfeRodoviarioPedagioController = Get.find<MdfeRodoviarioPedagioController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					mdfeRodoviarioPedagioController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: mdfeRodoviarioPedagioController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Rodoviario Pedagio - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: mdfeRodoviarioPedagioController.save),
						cancelAndExitButton(onPressed: mdfeRodoviarioPedagioController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: mdfeRodoviarioPedagioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: mdfeRodoviarioPedagioController.scrollController,
							child: SingleChildScrollView(
								controller: mdfeRodoviarioPedagioController.scrollController,
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
													sizes: 'col-12',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: mdfeRodoviarioPedagioController.mdfeRodoviarioModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Mdfe Rodoviario',
																			labelText: 'Id Mdfe Rodoviario *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: mdfeRodoviarioPedagioController.callMdfeRodoviarioLookup),
															),
														],
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
															controller: mdfeRodoviarioPedagioController.cnpjFornecedorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj Fornecedor',
																labelText: 'Cnpj Fornecedor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioPedagioController.mdfeRodoviarioPedagioModel.cnpjFornecedor = text;
																mdfeRodoviarioPedagioController.formWasChanged = true;
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
															controller: mdfeRodoviarioPedagioController.cnpjResponsavelController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj Responsavel',
																labelText: 'Cnpj Responsavel',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioPedagioController.mdfeRodoviarioPedagioModel.cnpjResponsavel = text;
																mdfeRodoviarioPedagioController.formWasChanged = true;
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
															controller: mdfeRodoviarioPedagioController.cpfResponsavelController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cpf Responsavel',
																labelText: 'Cpf Responsavel',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioPedagioController.mdfeRodoviarioPedagioModel.cpfResponsavel = text;
																mdfeRodoviarioPedagioController.formWasChanged = true;
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
															maxLength: 20,
															controller: mdfeRodoviarioPedagioController.numeroComprovanteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Comprovante',
																labelText: 'Numero Comprovante',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioPedagioController.mdfeRodoviarioPedagioModel.numeroComprovante = text;
																mdfeRodoviarioPedagioController.formWasChanged = true;
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
															controller: mdfeRodoviarioPedagioController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioPedagioController.mdfeRodoviarioPedagioModel.valor = mdfeRodoviarioPedagioController.valorController.numberValue;
																mdfeRodoviarioPedagioController.formWasChanged = true;
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
