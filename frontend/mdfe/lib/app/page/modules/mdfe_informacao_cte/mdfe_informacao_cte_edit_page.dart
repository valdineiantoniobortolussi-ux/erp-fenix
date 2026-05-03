import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:mdfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:mdfe/app/controller/mdfe_informacao_cte_controller.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/page/shared_widget/input/input_imports.dart';

class MdfeInformacaoCteEditPage extends StatelessWidget {
	MdfeInformacaoCteEditPage({Key? key}) : super(key: key);
	final mdfeInformacaoCteController = Get.find<MdfeInformacaoCteController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					mdfeInformacaoCteController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: mdfeInformacaoCteController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Informacão CTE - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: mdfeInformacaoCteController.save),
						cancelAndExitButton(onPressed: mdfeInformacaoCteController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: mdfeInformacaoCteController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: mdfeInformacaoCteController.scrollController,
							child: SingleChildScrollView(
								controller: mdfeInformacaoCteController.scrollController,
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
																		controller: mdfeInformacaoCteController.mdfeMunicipioDescarregaModelController,
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
																child: lookupButton(onPressed: mdfeInformacaoCteController.callMdfeMunicipioDescarregaLookup),
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
															controller: mdfeInformacaoCteController.chaveCteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Chave Cte',
																labelText: 'Chave Cte',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeInformacaoCteController.mdfeInformacaoCteModel.chaveCte = text;
																mdfeInformacaoCteController.formWasChanged = true;
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
															controller: mdfeInformacaoCteController.segundoCodigoBarraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Segundo Codigo Barra',
																labelText: 'Segundo Codigo Barra',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeInformacaoCteController.mdfeInformacaoCteModel.segundoCodigoBarra = text;
																mdfeInformacaoCteController.formWasChanged = true;
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
															controller: mdfeInformacaoCteController.indicadorReentregaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Indicador Reentrega',
																labelText: 'Indicador Reentrega',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeInformacaoCteController.mdfeInformacaoCteModel.indicadorReentrega = int.tryParse(text);
																mdfeInformacaoCteController.formWasChanged = true;
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
