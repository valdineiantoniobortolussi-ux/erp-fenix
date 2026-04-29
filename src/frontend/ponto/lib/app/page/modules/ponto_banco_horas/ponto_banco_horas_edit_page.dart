import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:ponto/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ponto/app/controller/ponto_banco_horas_controller.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/page/shared_widget/input/input_imports.dart';

class PontoBancoHorasEditPage extends StatelessWidget {
	PontoBancoHorasEditPage({Key? key}) : super(key: key);
	final pontoBancoHorasController = Get.find<PontoBancoHorasController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: pontoBancoHorasController.pontoBancoHorasEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: pontoBancoHorasController.pontoBancoHorasEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: pontoBancoHorasController.scrollController,
							child: SingleChildScrollView(
								controller: pontoBancoHorasController.scrollController,
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
																		controller: pontoBancoHorasController.viewPessoaColaboradorModelController,
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
																child: lookupButton(onPressed: pontoBancoHorasController.callViewPessoaColaboradorLookup),
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
																hintText: 'Informe os dados para o campo Data Trabalho',
																labelText: 'Data Trabalho',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: pontoBancoHorasController.pontoBancoHorasModel.dataTrabalho,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	pontoBancoHorasController.pontoBancoHorasModel.dataTrabalho = value;
																	pontoBancoHorasController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 8,
															controller: pontoBancoHorasController.quantidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade',
																labelText: 'Quantidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																pontoBancoHorasController.pontoBancoHorasModel.quantidade = text;
																pontoBancoHorasController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: pontoBancoHorasController.pontoBancoHorasModel.situacao ?? 'Não Utilizado',
															labelText: 'Situacao',
															hintText: 'Informe os dados para o campo Situacao',
															items: const ['Não Utilizado','Utilizado','Utilizado Parcialmente'],
															onChanged: (dynamic newValue) {
																pontoBancoHorasController.pontoBancoHorasModel.situacao = newValue;
																pontoBancoHorasController.formWasChanged = true;
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
