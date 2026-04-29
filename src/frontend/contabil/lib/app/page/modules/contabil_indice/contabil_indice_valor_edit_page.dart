import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/contabil_indice_valor_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class ContabilIndiceValorEditPage extends StatelessWidget {
	ContabilIndiceValorEditPage({Key? key}) : super(key: key);
	final contabilIndiceValorController = Get.find<ContabilIndiceValorController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: contabilIndiceValorController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Valores - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: contabilIndiceValorController.save),
						cancelAndExitButton(onPressed: contabilIndiceValorController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: contabilIndiceValorController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: contabilIndiceValorController.scrollController,
							child: SingleChildScrollView(
								controller: contabilIndiceValorController.scrollController,
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Indice',
																labelText: 'Data Indice',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: contabilIndiceValorController.contabilIndiceValorModel.dataIndice,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	contabilIndiceValorController.contabilIndiceValorModel.dataIndice = value;
																	contabilIndiceValorController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: contabilIndiceValorController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																contabilIndiceValorController.contabilIndiceValorModel.valor = contabilIndiceValorController.valorController.numberValue;
																contabilIndiceValorController.formWasChanged = true;
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
