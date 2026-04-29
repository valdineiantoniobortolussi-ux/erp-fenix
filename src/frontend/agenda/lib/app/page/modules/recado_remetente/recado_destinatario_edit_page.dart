import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:agenda/app/page/shared_widget/shared_widget_imports.dart';
import 'package:agenda/app/controller/recado_destinatario_controller.dart';
import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/page/shared_widget/input/input_imports.dart';

class RecadoDestinatarioEditPage extends StatelessWidget {
	RecadoDestinatarioEditPage({Key? key}) : super(key: key);
	final recadoDestinatarioController = Get.find<RecadoDestinatarioController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: recadoDestinatarioController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Destinatarios - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: recadoDestinatarioController.save),
						cancelAndExitButton(onPressed: recadoDestinatarioController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: recadoDestinatarioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: recadoDestinatarioController.scrollController,
							child: SingleChildScrollView(
								controller: recadoDestinatarioController.scrollController,
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
																		controller: recadoDestinatarioController.viewPessoaColaboradorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Destinatário',
																			labelText: 'Destinatário *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: recadoDestinatarioController.callViewPessoaColaboradorLookup),
															),
														],
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
