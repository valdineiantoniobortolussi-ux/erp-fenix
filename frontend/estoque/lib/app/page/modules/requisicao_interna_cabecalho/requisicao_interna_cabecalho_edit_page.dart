import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:estoque/app/page/shared_widget/shared_widget_imports.dart';
import 'package:estoque/app/controller/requisicao_interna_cabecalho_controller.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/page/shared_widget/input/input_imports.dart';

class RequisicaoInternaCabecalhoEditPage extends StatelessWidget {
	RequisicaoInternaCabecalhoEditPage({Key? key}) : super(key: key);
	final requisicaoInternaCabecalhoController = Get.find<RequisicaoInternaCabecalhoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: requisicaoInternaCabecalhoController.requisicaoInternaCabecalhoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: requisicaoInternaCabecalhoController.requisicaoInternaCabecalhoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: requisicaoInternaCabecalhoController.scrollController,
							child: SingleChildScrollView(
								controller: requisicaoInternaCabecalhoController.scrollController,
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
																		controller: requisicaoInternaCabecalhoController.viewPessoaColaboradorModelController,
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
																child: lookupButton(onPressed: requisicaoInternaCabecalhoController.callViewPessoaColaboradorLookup),
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Requisicao',
																labelText: 'Data Requisicao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: requisicaoInternaCabecalhoController.requisicaoInternaCabecalhoModel.dataRequisicao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	requisicaoInternaCabecalhoController.requisicaoInternaCabecalhoModel.dataRequisicao = value;
																	requisicaoInternaCabecalhoController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: requisicaoInternaCabecalhoController.requisicaoInternaCabecalhoModel.situacao ?? 'Aberta',
															labelText: 'Situacao',
															hintText: 'Informe os dados para o campo Situacao',
															items: const ['Aberta','Deferida','Indeferida'],
															onChanged: (dynamic newValue) {
																requisicaoInternaCabecalhoController.requisicaoInternaCabecalhoModel.situacao = newValue;
																requisicaoInternaCabecalhoController.formWasChanged = true;
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
