import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:vendas/app/controller/venda_comissao_controller.dart';
import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/page/shared_widget/input/input_imports.dart';

class VendaComissaoEditPage extends StatelessWidget {
	VendaComissaoEditPage({Key? key}) : super(key: key);
	final vendaComissaoController = Get.find<VendaComissaoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: vendaComissaoController.scaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: vendaComissaoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: vendaComissaoController.scrollController,
							child: SingleChildScrollView(
								controller: vendaComissaoController.scrollController,
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: vendaComissaoController.valorVendaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Venda',
																labelText: 'Valor Venda',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaComissaoController.vendaComissaoModel.valorVenda = vendaComissaoController.valorVendaController.numberValue;
																vendaComissaoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: vendaComissaoController.vendaComissaoModel.tipoContabil ?? 'Crédito',
															labelText: 'Tipo Contabil',
															hintText: 'Informe os dados para o campo Tipo Contabil',
															items: const ['Crédito','Débido'],
															onChanged: (dynamic newValue) {
																vendaComissaoController.vendaComissaoModel.tipoContabil = newValue;
																vendaComissaoController.formWasChanged = true;
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
															controller: vendaComissaoController.valorComissaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Comissao',
																labelText: 'Valor Comissao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																vendaComissaoController.vendaComissaoModel.valorComissao = vendaComissaoController.valorComissaoController.numberValue;
																vendaComissaoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: vendaComissaoController.vendaComissaoModel.situacao ?? 'Aberto',
															labelText: 'Situacao',
															hintText: 'Informe os dados para o campo Situacao',
															items: const ['Aberto','Quitado'],
															onChanged: (dynamic newValue) {
																vendaComissaoController.vendaComissaoModel.situacao = newValue;
																vendaComissaoController.formWasChanged = true;
															},
														),
													),
												),
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
																dateTime: vendaComissaoController.vendaComissaoModel.dataLancamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	vendaComissaoController.vendaComissaoModel.dataLancamento = value;
																	vendaComissaoController.formWasChanged = true;
																},
															),
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
