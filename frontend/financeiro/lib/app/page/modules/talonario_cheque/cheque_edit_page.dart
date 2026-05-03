import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro/app/controller/cheque_controller.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/page/shared_widget/input/input_imports.dart';

class ChequeEditPage extends StatelessWidget {
	ChequeEditPage({Key? key}) : super(key: key);
	final chequeController = Get.find<ChequeController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: chequeController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Cheque - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: chequeController.save),
						cancelAndExitButton(onPressed: chequeController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: chequeController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: chequeController.scrollController,
							child: SingleChildScrollView(
								controller: chequeController.scrollController,
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
															controller: chequeController.numeroController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero',
																labelText: 'Numero',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																chequeController.chequeModel.numero = int.tryParse(text);
																chequeController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: chequeController.chequeModel.statusCheque ?? 'Em Ser',
															labelText: 'Status',
															hintText: 'Informe os dados para o campo Status Cheque',
															items: const ['Em Ser','Baixado','Utilizado','Compensado','Cancelado','Sustado'],
															onChanged: (dynamic newValue) {
																chequeController.chequeModel.statusCheque = newValue;
																chequeController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Status',
																labelText: 'Data Status',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: chequeController.chequeModel.dataStatus,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	chequeController.chequeModel.dataStatus = value;
																	chequeController.formWasChanged = true;
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
