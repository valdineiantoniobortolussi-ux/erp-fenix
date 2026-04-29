import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/controller/ct_resultado_nt_financeira_controller.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/page/shared_widget/input/input_imports.dart';

class CtResultadoNtFinanceiraEditPage extends StatelessWidget {
	CtResultadoNtFinanceiraEditPage({Key? key}) : super(key: key);
	final ctResultadoNtFinanceiraController = Get.find<CtResultadoNtFinanceiraController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: ctResultadoNtFinanceiraController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Natureza Financeira Vinculada - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: ctResultadoNtFinanceiraController.save),
						cancelAndExitButton(onPressed: ctResultadoNtFinanceiraController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: ctResultadoNtFinanceiraController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: ctResultadoNtFinanceiraController.scrollController,
							child: SingleChildScrollView(
								controller: ctResultadoNtFinanceiraController.scrollController,
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
																		controller: ctResultadoNtFinanceiraController.finNaturezaFinanceiraModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Natureza Financeira',
																			labelText: 'Natureza Financeira *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: ctResultadoNtFinanceiraController.callFinNaturezaFinanceiraLookup),
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
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: ctResultadoNtFinanceiraController.percentualRateioController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Rateio',
																labelText: 'Percentual Rateio',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																ctResultadoNtFinanceiraController.ctResultadoNtFinanceiraModel.percentualRateio = ctResultadoNtFinanceiraController.percentualRateioController.numberValue;
																ctResultadoNtFinanceiraController.formWasChanged = true;
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
