import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:patrimonio/app/page/shared_widget/shared_widget_imports.dart';
import 'package:patrimonio/app/controller/patrim_movimentacao_bem_controller.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/page/shared_widget/input/input_imports.dart';

class PatrimMovimentacaoBemEditPage extends StatelessWidget {
	PatrimMovimentacaoBemEditPage({Key? key}) : super(key: key);
	final patrimMovimentacaoBemController = Get.find<PatrimMovimentacaoBemController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: patrimMovimentacaoBemController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Movimentação - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: patrimMovimentacaoBemController.save),
						cancelAndExitButton(onPressed: patrimMovimentacaoBemController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: patrimMovimentacaoBemController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: patrimMovimentacaoBemController.scrollController,
							child: SingleChildScrollView(
								controller: patrimMovimentacaoBemController.scrollController,
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
																		controller: patrimMovimentacaoBemController.patrimTipoMovimentacaoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Tipo Movimentacao',
																			labelText: 'Tipo Movimentacao *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: patrimMovimentacaoBemController.callPatrimTipoMovimentacaoLookup),
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Movimentacao',
																labelText: 'Data Movimentacao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: patrimMovimentacaoBemController.patrimMovimentacaoBemModel.dataMovimentacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	patrimMovimentacaoBemController.patrimMovimentacaoBemModel.dataMovimentacao = value;
																	patrimMovimentacaoBemController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: patrimMovimentacaoBemController.responsavelController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Responsavel',
																labelText: 'Responsavel',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																patrimMovimentacaoBemController.patrimMovimentacaoBemModel.responsavel = text;
																patrimMovimentacaoBemController.formWasChanged = true;
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
