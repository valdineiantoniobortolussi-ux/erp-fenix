import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:frotas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:frotas/app/controller/frota_veiculo_tipo_controller.dart';
import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/page/shared_widget/input/input_imports.dart';

class FrotaVeiculoTipoEditPage extends StatelessWidget {
	FrotaVeiculoTipoEditPage({Key? key}) : super(key: key);
	final frotaVeiculoTipoController = Get.find<FrotaVeiculoTipoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					frotaVeiculoTipoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: frotaVeiculoTipoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Tipo Veiculo - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: frotaVeiculoTipoController.save),
						cancelAndExitButton(onPressed: frotaVeiculoTipoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: frotaVeiculoTipoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: frotaVeiculoTipoController.scrollController,
							child: SingleChildScrollView(
								controller: frotaVeiculoTipoController.scrollController,
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 2,
															controller: frotaVeiculoTipoController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Codigo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoTipoController.frotaVeiculoTipoModel.codigo = text;
																frotaVeiculoTipoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-9',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 100,
															controller: frotaVeiculoTipoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaVeiculoTipoController.frotaVeiculoTipoModel.nome = text;
																frotaVeiculoTipoController.formWasChanged = true;
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
