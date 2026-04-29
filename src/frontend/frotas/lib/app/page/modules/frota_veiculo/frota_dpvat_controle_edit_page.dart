import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:frotas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:frotas/app/controller/frota_dpvat_controle_controller.dart';
import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/page/shared_widget/input/input_imports.dart';

class FrotaDpvatControleEditPage extends StatelessWidget {
	FrotaDpvatControleEditPage({Key? key}) : super(key: key);
	final frotaDpvatControleController = Get.find<FrotaDpvatControleController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: frotaDpvatControleController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('DPVAT - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: frotaDpvatControleController.save),
						cancelAndExitButton(onPressed: frotaDpvatControleController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: frotaDpvatControleController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: frotaDpvatControleController.scrollController,
							child: SingleChildScrollView(
								controller: frotaDpvatControleController.scrollController,
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
															maxLength: 4,
															controller: frotaDpvatControleController.anoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ano',
																labelText: 'Ano',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaDpvatControleController.frotaDpvatControleModel.ano = text;
																frotaDpvatControleController.formWasChanged = true;
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
															maxLength: 2,
															controller: frotaDpvatControleController.parcelaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Parcela',
																labelText: 'Parcela',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaDpvatControleController.frotaDpvatControleModel.parcela = text;
																frotaDpvatControleController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Vencimento',
																labelText: 'Data Vencimento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: frotaDpvatControleController.frotaDpvatControleModel.dataVencimento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	frotaDpvatControleController.frotaDpvatControleModel.dataVencimento = value;
																	frotaDpvatControleController.formWasChanged = true;
																},
															),
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Pagamento',
																labelText: 'Data Pagamento',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: frotaDpvatControleController.frotaDpvatControleModel.dataPagamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	frotaDpvatControleController.frotaDpvatControleModel.dataPagamento = value;
																	frotaDpvatControleController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: frotaDpvatControleController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaDpvatControleController.frotaDpvatControleModel.valor = frotaDpvatControleController.valorController.numberValue;
																frotaDpvatControleController.formWasChanged = true;
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
