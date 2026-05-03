import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/controller/nfe_detalhe_imposto_icms_ufdest_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/shared_widget/input/input_imports.dart';

class NfeDetalheImpostoIcmsUfdestEditPage extends StatelessWidget {
	NfeDetalheImpostoIcmsUfdestEditPage({Key? key}) : super(key: key);
	final nfeDetalheImpostoIcmsUfdestController = Get.find<NfeDetalheImpostoIcmsUfdestController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: nfeDetalheImpostoIcmsUfdestController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('ICMS UF Destinatário - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: nfeDetalheImpostoIcmsUfdestController.save),
						cancelAndExitButton(onPressed: nfeDetalheImpostoIcmsUfdestController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: nfeDetalheImpostoIcmsUfdestController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: nfeDetalheImpostoIcmsUfdestController.scrollController,
							child: SingleChildScrollView(
								controller: nfeDetalheImpostoIcmsUfdestController.scrollController,
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
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: nfeDetalheImpostoIcmsUfdestController.valorBcIcmsUfDestinoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Icms Uf Destino',
																labelText: 'Valor Bc Icms Uf Destino',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsUfdestController.nfeDetalheImpostoIcmsUfdestModel.valorBcIcmsUfDestino = nfeDetalheImpostoIcmsUfdestController.valorBcIcmsUfDestinoController.numberValue;
																nfeDetalheImpostoIcmsUfdestController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsUfdestController.valorBcFcpUfDestinoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Bc Fcp Uf Destino',
																labelText: 'Valor Bc Fcp Uf Destino',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsUfdestController.nfeDetalheImpostoIcmsUfdestModel.valorBcFcpUfDestino = nfeDetalheImpostoIcmsUfdestController.valorBcFcpUfDestinoController.numberValue;
																nfeDetalheImpostoIcmsUfdestController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsUfdestController.percentualFcpUfDestinoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Fcp Uf Destino',
																labelText: 'Percentual Fcp Uf Destino',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsUfdestController.nfeDetalheImpostoIcmsUfdestModel.percentualFcpUfDestino = nfeDetalheImpostoIcmsUfdestController.percentualFcpUfDestinoController.numberValue;
																nfeDetalheImpostoIcmsUfdestController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsUfdestController.aliquotaInternaUfDestinoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Interna Uf Destino',
																labelText: 'Aliquota Interna Uf Destino',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsUfdestController.nfeDetalheImpostoIcmsUfdestModel.aliquotaInternaUfDestino = nfeDetalheImpostoIcmsUfdestController.aliquotaInternaUfDestinoController.numberValue;
																nfeDetalheImpostoIcmsUfdestController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsUfdestController.aliquotaInteresdatualUfEnvolvidasController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Aliquota Interesdatual Uf Envolvidas',
																labelText: 'Aliquota Interesdatual Uf Envolvidas',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsUfdestController.nfeDetalheImpostoIcmsUfdestModel.aliquotaInteresdatualUfEnvolvidas = nfeDetalheImpostoIcmsUfdestController.aliquotaInteresdatualUfEnvolvidasController.numberValue;
																nfeDetalheImpostoIcmsUfdestController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsUfdestController.percentualProvisorioPartilhaIcmsController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Percentual Provisorio Partilha Icms',
																labelText: 'Percentual Provisorio Partilha Icms',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsUfdestController.nfeDetalheImpostoIcmsUfdestModel.percentualProvisorioPartilhaIcms = nfeDetalheImpostoIcmsUfdestController.percentualProvisorioPartilhaIcmsController.numberValue;
																nfeDetalheImpostoIcmsUfdestController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsUfdestController.valorIcmsFcpUfDestinoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Icms Fcp Uf Destino',
																labelText: 'Valor Icms Fcp Uf Destino',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsUfdestController.nfeDetalheImpostoIcmsUfdestModel.valorIcmsFcpUfDestino = nfeDetalheImpostoIcmsUfdestController.valorIcmsFcpUfDestinoController.numberValue;
																nfeDetalheImpostoIcmsUfdestController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsUfdestController.valorInterestadualUfDestinoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Interestadual Uf Destino',
																labelText: 'Valor Interestadual Uf Destino',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsUfdestController.nfeDetalheImpostoIcmsUfdestModel.valorInterestadualUfDestino = nfeDetalheImpostoIcmsUfdestController.valorInterestadualUfDestinoController.numberValue;
																nfeDetalheImpostoIcmsUfdestController.formWasChanged = true;
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
															controller: nfeDetalheImpostoIcmsUfdestController.valorInterestadualUfRemetenteController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Interestadual Uf Remetente',
																labelText: 'Valor Interestadual Uf Remetente',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																nfeDetalheImpostoIcmsUfdestController.nfeDetalheImpostoIcmsUfdestModel.valorInterestadualUfRemetente = nfeDetalheImpostoIcmsUfdestController.valorInterestadualUfRemetenteController.numberValue;
																nfeDetalheImpostoIcmsUfdestController.formWasChanged = true;
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
