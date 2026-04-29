import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:mdfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:mdfe/app/controller/mdfe_informacao_nfe_controller.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/page/shared_widget/input/input_imports.dart';

class MdfeInformacaoNfeEditPage extends StatelessWidget {
	MdfeInformacaoNfeEditPage({Key? key}) : super(key: key);
	final mdfeInformacaoNfeController = Get.find<MdfeInformacaoNfeController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					mdfeInformacaoNfeController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: mdfeInformacaoNfeController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Informacao NFe - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: mdfeInformacaoNfeController.save),
						cancelAndExitButton(onPressed: mdfeInformacaoNfeController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: mdfeInformacaoNfeController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: mdfeInformacaoNfeController.scrollController,
							child: SingleChildScrollView(
								controller: mdfeInformacaoNfeController.scrollController,
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
																		controller: mdfeInformacaoNfeController.mdfeMunicipioDescarregaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Mdfe Municipio Descarrega',
																			labelText: 'Id Mdfe Municipio Descarrega *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: mdfeInformacaoNfeController.callMdfeMunicipioDescarregaLookup),
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
															maxLength: 44,
															controller: mdfeInformacaoNfeController.chaveNfeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Chave Nfe',
																labelText: 'Chave Nfe',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeInformacaoNfeController.mdfeInformacaoNfeModel.chaveNfe = text;
																mdfeInformacaoNfeController.formWasChanged = true;
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
															maxLength: 36,
															controller: mdfeInformacaoNfeController.segundoCodigoBarraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Segundo Codigo Barra',
																labelText: 'Segundo Codigo Barra',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeInformacaoNfeController.mdfeInformacaoNfeModel.segundoCodigoBarra = text;
																mdfeInformacaoNfeController.formWasChanged = true;
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
															controller: mdfeInformacaoNfeController.indicadorReentregaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Indicador Reentrega',
																labelText: 'Indicador Reentrega',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeInformacaoNfeController.mdfeInformacaoNfeModel.indicadorReentrega = int.tryParse(text);
																mdfeInformacaoNfeController.formWasChanged = true;
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
			),
		);
	}
}
