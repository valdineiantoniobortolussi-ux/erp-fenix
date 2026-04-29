import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/vendedor_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class VendedorEditPage extends StatelessWidget {
	VendedorEditPage({Key? key}) : super(key: key);
	final vendedorController = Get.find<VendedorController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: vendedorController.scaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: vendedorController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: vendedorController.scrollController,
							child: SingleChildScrollView(
								controller: vendedorController.scrollController,
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
																		controller: vendedorController.comissaoPerfilModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Perfil Comissão',
																			labelText: 'Perfil Comissão *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: vendedorController.callComissaoPerfilLookup),
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: vendedorController.comissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Comissao',
																labelText: 'Comissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendedorController.vendedorModel.comissao = vendedorController.comissaoController.numberValue;
																vendedorController.formWasChanged = true;
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
															controller: vendedorController.metaVendaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Meta Venda',
																labelText: 'Meta Venda',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendedorController.vendedorModel.metaVenda = vendedorController.metaVendaController.numberValue;
																vendedorController.formWasChanged = true;
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
