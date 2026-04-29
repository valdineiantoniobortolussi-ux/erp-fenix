import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/controller/folha_ppp_cat_controller.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/page/shared_widget/input/input_imports.dart';

class FolhaPppCatEditPage extends StatelessWidget {
	FolhaPppCatEditPage({Key? key}) : super(key: key);
	final folhaPppCatController = Get.find<FolhaPppCatController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: folhaPppCatController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('CAT - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: folhaPppCatController.save),
						cancelAndExitButton(onPressed: folhaPppCatController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: folhaPppCatController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: folhaPppCatController.scrollController,
							child: SingleChildScrollView(
								controller: folhaPppCatController.scrollController,
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
															controller: folhaPppCatController.numeroCatController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero CAT',
																labelText: 'Numero CAT',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																folhaPppCatController.folhaPppCatModel.numeroCat = int.tryParse(text);
																folhaPppCatController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Afastamento',
																labelText: 'Data Afastamento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: folhaPppCatController.folhaPppCatModel.dataAfastamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaPppCatController.folhaPppCatModel.dataAfastamento = value;
																	folhaPppCatController.formWasChanged = true;
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
																hintText: 'Informe os dados para o campo Data Registro',
																labelText: 'Data Registro',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: folhaPppCatController.folhaPppCatModel.dataRegistro,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	folhaPppCatController.folhaPppCatModel.dataRegistro = value;
																	folhaPppCatController.formWasChanged = true;
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
