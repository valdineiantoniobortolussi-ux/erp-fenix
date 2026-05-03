import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/contabil_lancamento_cabecalho_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class ContabilLancamentoCabecalhoEditPage extends StatelessWidget {
	ContabilLancamentoCabecalhoEditPage({Key? key}) : super(key: key);
	final contabilLancamentoCabecalhoController = Get.find<ContabilLancamentoCabecalhoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: contabilLancamentoCabecalhoController.contabilLancamentoCabecalhoEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contabilLancamentoCabecalhoController.contabilLancamentoCabecalhoEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contabilLancamentoCabecalhoController.scrollController,
							child: SingleChildScrollView(
								controller: contabilLancamentoCabecalhoController.scrollController,
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
																		controller: contabilLancamentoCabecalhoController.contabilLoteModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Lote Contábil',
																			labelText: 'Lote Contábil',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: contabilLancamentoCabecalhoController.callContabilLoteLookup),
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
																hintText: 'Informe os dados para o campo Data Lancamento',
																labelText: 'Data Lancamento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: contabilLancamentoCabecalhoController.contabilLancamentoCabecalhoModel.dataLancamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contabilLancamentoCabecalhoController.contabilLancamentoCabecalhoModel.dataLancamento = value;
																	contabilLancamentoCabecalhoController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Inclusao',
																labelText: 'Data Inclusao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: contabilLancamentoCabecalhoController.contabilLancamentoCabecalhoModel.dataInclusao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contabilLancamentoCabecalhoController.contabilLancamentoCabecalhoModel.dataInclusao = value;
																	contabilLancamentoCabecalhoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilLancamentoCabecalhoController.contabilLancamentoCabecalhoModel.tipo ?? 'UDVC=Um Débito para Vários Créditos',
															labelText: 'Tipo',
															hintText: 'Informe os dados para o campo Tipo',
															items: const ['UDVC=Um Débito para Vários Créditos','UCVD=Um Crédito para Vários Débitos','UDUC=Um Débito para Um Crédito','VDVC = Vários Débitos para Vários Créditos'],
															onChanged: (dynamic newValue) {
																contabilLancamentoCabecalhoController.contabilLancamentoCabecalhoModel.tipo = newValue;
																contabilLancamentoCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilLancamentoCabecalhoController.contabilLancamentoCabecalhoModel.liberado ?? 'Sim',
															labelText: 'Liberado',
															hintText: 'Informe os dados para o campo Liberado',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																contabilLancamentoCabecalhoController.contabilLancamentoCabecalhoModel.liberado = newValue;
																contabilLancamentoCabecalhoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: contabilLancamentoCabecalhoController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilLancamentoCabecalhoController.contabilLancamentoCabecalhoModel.valor = contabilLancamentoCabecalhoController.valorController.numberValue;
																contabilLancamentoCabecalhoController.formWasChanged = true;
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
