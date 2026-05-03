import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:gondolas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:gondolas/app/controller/gondola_armazenamento_controller.dart';
import 'package:gondolas/app/infra/infra_imports.dart';
import 'package:gondolas/app/page/shared_widget/input/input_imports.dart';

class GondolaArmazenamentoEditPage extends StatelessWidget {
	GondolaArmazenamentoEditPage({Key? key}) : super(key: key);
	final gondolaArmazenamentoController = Get.find<GondolaArmazenamentoController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: gondolaArmazenamentoController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Armazenamento - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: gondolaArmazenamentoController.save),
						cancelAndExitButton(onPressed: gondolaArmazenamentoController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: gondolaArmazenamentoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: gondolaArmazenamentoController.scrollController,
							child: SingleChildScrollView(
								controller: gondolaArmazenamentoController.scrollController,
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
													sizes: 'col-12 col-md-9',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: gondolaArmazenamentoController.produtoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Produto',
																			labelText: 'Produto *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: gondolaArmazenamentoController.callProdutoLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: gondolaArmazenamentoController.quantidadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade',
																labelText: 'Quantidade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																gondolaArmazenamentoController.gondolaArmazenamentoModel.quantidade = int.tryParse(text);
																gondolaArmazenamentoController.formWasChanged = true;
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
