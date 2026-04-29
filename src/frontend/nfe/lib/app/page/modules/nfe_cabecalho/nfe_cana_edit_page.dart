import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_cana_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeCanaEditPage extends StatelessWidget {
	NfeCanaEditPage({Key? key}) : super(key: key);
	final nfeCanaController = Get.find<NfeCanaController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeCanaController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Cana - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeCanaController.save),
						cancelAndExitButton(onPressed: nfeCanaController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeCanaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeCanaController.scrollController,
							child: SingleChildScrollView(
								controller: nfeCanaController.scrollController,
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
															maxLength: 9,
															controller: nfeCanaController.safraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Safra',
																labelText: 'Safra',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCanaController.nfeCanaModel.safra = text;
																nfeCanaController.formWasChanged = true;
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 7,
															controller: nfeCanaController.mesAnoReferenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Mes Ano Referencia',
																labelText: 'Mes Ano Referencia',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeCanaController.nfeCanaModel.mesAnoReferencia = text;
																nfeCanaController.formWasChanged = true;
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
