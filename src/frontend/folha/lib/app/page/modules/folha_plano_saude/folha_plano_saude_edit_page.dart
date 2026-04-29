import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/folha_plano_saude_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FolhaPlanoSaudeEditPage extends StatelessWidget {
	FolhaPlanoSaudeEditPage({Key? key}) : super(key: key);
	final folhaPlanoSaudeController = Get.find<FolhaPlanoSaudeController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					folhaPlanoSaudeController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: folhaPlanoSaudeController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Plano de Saúde - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: folhaPlanoSaudeController.save),
						cancelAndExitButton(onPressed: folhaPlanoSaudeController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: folhaPlanoSaudeController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: folhaPlanoSaudeController.scrollController,
							child: SingleChildScrollView(
								controller: folhaPlanoSaudeController.scrollController,
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
																		controller: folhaPlanoSaudeController.operadoraPlanoSaudeModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Operadora',
																			labelText: 'Operadora *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: folhaPlanoSaudeController.callOperadoraPlanoSaudeLookup),
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: folhaPlanoSaudeController.viewPessoaColaboradorModelController,
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
																child: lookupButton(onPressed: folhaPlanoSaudeController.callViewPessoaColaboradorLookup),
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Inicio',
																labelText: 'Data Inicio',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: folhaPlanoSaudeController.folhaPlanoSaudeModel.dataInicio,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaPlanoSaudeController.folhaPlanoSaudeModel.dataInicio = value;
																	folhaPlanoSaudeController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: folhaPlanoSaudeController.folhaPlanoSaudeModel.beneficiario ?? '1=Somente Colaborador',
															labelText: 'Beneficiario',
															hintText: 'Informe os dados para o campo Beneficiario',
															items: const ['1=Somente Colaborador','2=Colaborador e Dependentes','3=Somente Dependentes'],
															onChanged: (dynamic newValue) {
																folhaPlanoSaudeController.folhaPlanoSaudeModel.beneficiario = newValue;
																folhaPlanoSaudeController.formWasChanged = true;
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
