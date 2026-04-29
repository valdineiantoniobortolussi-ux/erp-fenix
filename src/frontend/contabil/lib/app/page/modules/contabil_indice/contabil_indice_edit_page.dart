import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_indice_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class ContabilIndiceEditPage extends StatelessWidget {
	ContabilIndiceEditPage({Key? key}) : super(key: key);
	final contabilIndiceController = Get.find<ContabilIndiceController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: contabilIndiceController.contabilIndiceEditPageScaffoldKey,				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contabilIndiceController.contabilIndiceEditPageFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contabilIndiceController.scrollController,
							child: SingleChildScrollView(
								controller: contabilIndiceController.scrollController,
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
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: contabilIndiceController.indiceController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Indice',
																labelText: 'Indice',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilIndiceController.contabilIndiceModel.indice = text;
																contabilIndiceController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: contabilIndiceController.contabilIndiceModel.periodicidade ?? 'Diário',
															labelText: 'Periodicidade',
															hintText: 'Informe os dados para o campo Periodicidade',
															items: const ['Diário','Mensal'],
															onChanged: (dynamic newValue) {
																contabilIndiceController.contabilIndiceModel.periodicidade = newValue;
																contabilIndiceController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Diario A Partir De',
																labelText: 'Diario A Partir De',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: contabilIndiceController.contabilIndiceModel.diarioAPartirDe,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contabilIndiceController.contabilIndiceModel.diarioAPartirDe = value;
																	contabilIndiceController.formWasChanged = true;
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
															controller: contabilIndiceController.mensalMesAnoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Mensal Mes Ano',
																labelText: 'Mensal Mes Ano',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilIndiceController.contabilIndiceModel.mensalMesAno = text;
																contabilIndiceController.formWasChanged = true;
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
