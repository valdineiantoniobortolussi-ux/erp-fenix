import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/controller/cte_multimodal_controller.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/page/shared_widget/input/input_imports.dart';

class CteMultimodalEditPage extends StatelessWidget {
	CteMultimodalEditPage({Key? key}) : super(key: key);
	final cteMultimodalController = Get.find<CteMultimodalController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: cteMultimodalController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Multimodal - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: cteMultimodalController.save),
						cancelAndExitButton(onPressed: cteMultimodalController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: cteMultimodalController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: cteMultimodalController.scrollController,
							child: SingleChildScrollView(
								controller: cteMultimodalController.scrollController,
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
															maxLength: 20,
															controller: cteMultimodalController.cotmController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cotm',
																labelText: 'Cotm',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																cteMultimodalController.cteMultimodalModel.cotm = text;
																cteMultimodalController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: cteMultimodalController.cteMultimodalModel.indicadorNegociavel ?? 'AAA',
															labelText: 'Indicador Negociavel',
															hintText: 'Informe os dados para o campo Indicador Negociavel',
															items: const ['AAA','BBB','CCC'],
															onChanged: (dynamic newValue) {
																cteMultimodalController.cteMultimodalModel.indicadorNegociavel = newValue;
																cteMultimodalController.formWasChanged = true;
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
