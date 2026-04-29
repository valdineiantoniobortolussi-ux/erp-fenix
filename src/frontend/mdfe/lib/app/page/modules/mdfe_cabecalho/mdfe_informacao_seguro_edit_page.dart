import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:mdfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:mdfe/app/controller/mdfe_informacao_seguro_controller.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/page/shared_widget/input/input_imports.dart';

class MdfeInformacaoSeguroEditPage extends StatelessWidget {
	MdfeInformacaoSeguroEditPage({Key? key}) : super(key: key);
	final mdfeInformacaoSeguroController = Get.find<MdfeInformacaoSeguroController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: mdfeInformacaoSeguroController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Informação Seguro - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: mdfeInformacaoSeguroController.save),
						cancelAndExitButton(onPressed: mdfeInformacaoSeguroController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: mdfeInformacaoSeguroController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: mdfeInformacaoSeguroController.scrollController,
							child: SingleChildScrollView(
								controller: mdfeInformacaoSeguroController.scrollController,
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: mdfeInformacaoSeguroController.responsavelController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Responsavel',
																labelText: 'Responsavel',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeInformacaoSeguroController.mdfeInformacaoSeguroModel.responsavel = int.tryParse(text);
																mdfeInformacaoSeguroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: mdfeInformacaoSeguroController.cnpjCpfController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj Cpf',
																labelText: 'CNPJ/CPF',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeInformacaoSeguroController.mdfeInformacaoSeguroModel.cnpjCpf = text;
																mdfeInformacaoSeguroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 11,
															controller: mdfeInformacaoSeguroController.seguradoraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Seguradora',
																labelText: 'Seguradora',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeInformacaoSeguroController.mdfeInformacaoSeguroModel.seguradora = text;
																mdfeInformacaoSeguroController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: mdfeInformacaoSeguroController.cnpjSeguradoraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Cnpj Seguradora',
																labelText: 'CNPJ Seguradora',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeInformacaoSeguroController.mdfeInformacaoSeguroModel.cnpjSeguradora = text;
																mdfeInformacaoSeguroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 20,
															controller: mdfeInformacaoSeguroController.apoliceController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Apolice',
																labelText: 'Apolice',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeInformacaoSeguroController.mdfeInformacaoSeguroModel.apolice = text;
																mdfeInformacaoSeguroController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 40,
															controller: mdfeInformacaoSeguroController.averbacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Averbacao',
																labelText: 'Averbacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																mdfeInformacaoSeguroController.mdfeInformacaoSeguroModel.averbacao = text;
																mdfeInformacaoSeguroController.formWasChanged = true;
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
