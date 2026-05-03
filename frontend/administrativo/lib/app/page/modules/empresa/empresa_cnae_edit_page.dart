import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:administrativo/app/page/shared_widget/shared_widget_imports.dart';
import 'package:administrativo/app/controller/empresa_cnae_controller.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/page/shared_widget/input/input_imports.dart';

class EmpresaCnaeEditPage extends StatelessWidget {
	EmpresaCnaeEditPage({Key? key}) : super(key: key);
	final empresaCnaeController = Get.find<EmpresaCnaeController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: empresaCnaeController.empresaCnaeScaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('${ empresaCnaeController.screenTitle } - ${ empresaCnaeController.isNewRecord ? 'inserting'.tr : 'editing'.tr }',),
					actions: [
						saveButton(onPressed: empresaCnaeController.save),
						cancelAndExitButton(onPressed: empresaCnaeController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: empresaCnaeController.empresaCnaeFormKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: empresaCnaeController.scrollController,
							child: SingleChildScrollView(
								controller: empresaCnaeController.scrollController,
								child: BootstrapContainer(
									fluid: true,
									padding: const EdgeInsets.all(10.0),
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
																		controller: empresaCnaeController.cnaeModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Id Cnae',
																			labelText: 'CNAE *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: empresaCnaeController.callCnaeLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButton(
															value: empresaCnaeController.empresaCnaeModel.principal ?? 'Sim',
															labelText: 'Principal',
															hintText: 'Informe os dados para o campo Principal',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																empresaCnaeController.empresaCnaeModel.principal = newValue;
																empresaCnaeController.formWasChangedDetail = true;
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
															maxLength: 50,
															controller: empresaCnaeController.ramoAtividadeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ramo Atividade',
																labelText: 'Ramo Atividade',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaCnaeController.empresaCnaeModel.ramoAtividade = text;
																empresaCnaeController.formWasChangedDetail = true;
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
															maxLength: 250,
															maxLines: 3,
															controller: empresaCnaeController.objetoSocialController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Objeto Social',
																labelText: 'Objeto Social',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																empresaCnaeController.empresaCnaeModel.objetoSocial = text;
																empresaCnaeController.formWasChangedDetail = true;
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
