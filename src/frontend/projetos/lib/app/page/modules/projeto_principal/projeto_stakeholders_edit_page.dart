import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:projetos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:projetos/app/controller/projeto_stakeholders_controller.dart';
import 'package:projetos/app/infra/infra_imports.dart';
import 'package:projetos/app/page/shared_widget/input/input_imports.dart';

class ProjetoStakeholdersEditPage extends StatelessWidget {
	ProjetoStakeholdersEditPage({Key? key}) : super(key: key);
	final projetoStakeholdersController = Get.find<ProjetoStakeholdersController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: projetoStakeholdersController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Stakeholders - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: projetoStakeholdersController.save),
						cancelAndExitButton(onPressed: projetoStakeholdersController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: projetoStakeholdersController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: projetoStakeholdersController.scrollController,
							child: SingleChildScrollView(
								controller: projetoStakeholdersController.scrollController,
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
																		controller: projetoStakeholdersController.viewPessoaColaboradorModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Colaborador',
																			labelText: 'Colaborador *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: projetoStakeholdersController.callViewPessoaColaboradorLookup),
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
