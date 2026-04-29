import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:wms/app/controller/wms_ordem_separacao_cab_controller.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/page/shared_widget/input/input_imports.dart';

class WmsOrdemSeparacaoCabEditPage extends StatelessWidget {
	WmsOrdemSeparacaoCabEditPage({Key? key}) : super(key: key);
	final wmsOrdemSeparacaoCabController = Get.find<WmsOrdemSeparacaoCabController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: wmsOrdemSeparacaoCabController.wmsOrdemSeparacaoCabEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: wmsOrdemSeparacaoCabController.wmsOrdemSeparacaoCabEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: wmsOrdemSeparacaoCabController.scrollController,
							child: SingleChildScrollView(
								controller: wmsOrdemSeparacaoCabController.scrollController,
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
														child: CustomDropdownButtonFormField(
															value: wmsOrdemSeparacaoCabController.wmsOrdemSeparacaoCabModel.origem ?? 'Produção',
															labelText: 'Origem',
															hintText: 'Informe os dados para o campo Origem',
															items: const ['Produção','Matriz','Filial'],
															onChanged: (dynamic newValue) {
																wmsOrdemSeparacaoCabController.wmsOrdemSeparacaoCabModel.origem = newValue;
																wmsOrdemSeparacaoCabController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Solicitação',
																labelText: 'Data Solicitacao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: wmsOrdemSeparacaoCabController.wmsOrdemSeparacaoCabModel.dataSolicitacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	wmsOrdemSeparacaoCabController.wmsOrdemSeparacaoCabModel.dataSolicitacao = value;
																	wmsOrdemSeparacaoCabController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Limite',
																labelText: 'Data Limite',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: wmsOrdemSeparacaoCabController.wmsOrdemSeparacaoCabModel.dataLimite,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	wmsOrdemSeparacaoCabController.wmsOrdemSeparacaoCabModel.dataLimite = value;
																	wmsOrdemSeparacaoCabController.formWasChanged = true;
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
