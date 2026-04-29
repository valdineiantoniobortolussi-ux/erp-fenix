import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:mdfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:mdfe/app/controller/mdfe_rodoviario_controller.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/page/shared_widget/input/input_imports.dart';

class MdfeRodoviarioEditPage extends StatelessWidget {
	MdfeRodoviarioEditPage({Key? key}) : super(key: key);
	final mdfeRodoviarioController = Get.find<MdfeRodoviarioController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: mdfeRodoviarioController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Rodoviário - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: mdfeRodoviarioController.save),
						cancelAndExitButton(onPressed: mdfeRodoviarioController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: mdfeRodoviarioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: mdfeRodoviarioController.scrollController,
							child: SingleChildScrollView(
								controller: mdfeRodoviarioController.scrollController,
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 8,
															controller: mdfeRodoviarioController.rntrcController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo RNTRC',
																labelText: 'RNTRC',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioController.mdfeRodoviarioModel.rntrc = text;
																mdfeRodoviarioController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 16,
															controller: mdfeRodoviarioController.codigoAgendamentoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Agendamento',
																labelText: 'Codigo Agendamento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeRodoviarioController.mdfeRodoviarioModel.codigoAgendamento = text;
																mdfeRodoviarioController.formWasChanged = true;
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
