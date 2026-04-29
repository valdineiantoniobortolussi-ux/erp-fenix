import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:pcp/app/page/shared_widget/shared_widget_imports.dart';
import 'package:pcp/app/controller/pcp_instrucao_op_controller.dart';
import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/page/shared_widget/input/input_imports.dart';

class PcpInstrucaoOpEditPage extends StatelessWidget {
	PcpInstrucaoOpEditPage({Key? key}) : super(key: key);
	final pcpInstrucaoOpController = Get.find<PcpInstrucaoOpController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: pcpInstrucaoOpController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Instruções - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: pcpInstrucaoOpController.save),
						cancelAndExitButton(onPressed: pcpInstrucaoOpController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pcpInstrucaoOpController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pcpInstrucaoOpController.scrollController,
							child: SingleChildScrollView(
								controller: pcpInstrucaoOpController.scrollController,
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
																		controller: pcpInstrucaoOpController.pcpInstrucaoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Pcp Instrucao',
																			labelText: 'Instrucao *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: pcpInstrucaoOpController.callPcpInstrucaoLookup),
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
