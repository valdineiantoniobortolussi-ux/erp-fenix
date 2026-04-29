import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfse/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfse/app/controller/nfse_intermediario_controller.dart';
import 'package:nfse/app/infra/infra_imports.dart';
import 'package:nfse/app/page/shared_widget/input/input_imports.dart';

class NfseIntermediarioEditPage extends StatelessWidget {
	NfseIntermediarioEditPage({Key? key}) : super(key: key);
	final nfseIntermediarioController = Get.find<NfseIntermediarioController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfseIntermediarioController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Intermediários - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfseIntermediarioController.save),
						cancelAndExitButton(onPressed: nfseIntermediarioController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfseIntermediarioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfseIntermediarioController.scrollController,
							child: SingleChildScrollView(
								controller: nfseIntermediarioController.scrollController,
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
															controller: nfseIntermediarioController.cnpjController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo CNPJ',
																labelText: 'CNPJ',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseIntermediarioController.nfseIntermediarioModel.cnpj = text;
																nfseIntermediarioController.formWasChanged = true;
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
															maxLength: 15,
															controller: nfseIntermediarioController.inscricaoMunicipalController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Inscricao Municipal',
																labelText: 'Inscricao Municipal',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseIntermediarioController.nfseIntermediarioModel.inscricaoMunicipal = text;
																nfseIntermediarioController.formWasChanged = true;
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
															maxLength: 150,
															controller: nfseIntermediarioController.razaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Razao',
																labelText: 'Razão',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfseIntermediarioController.nfseIntermediarioModel.razao = text;
																nfseIntermediarioController.formWasChanged = true;
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
