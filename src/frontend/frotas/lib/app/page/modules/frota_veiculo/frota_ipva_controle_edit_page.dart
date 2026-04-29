import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:frotas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:frotas/app/controller/frota_ipva_controle_controller.dart';
import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/page/shared_widget/input/input_imports.dart';

class FrotaIpvaControleEditPage extends StatelessWidget {
	FrotaIpvaControleEditPage({Key? key}) : super(key: key);
	final frotaIpvaControleController = Get.find<FrotaIpvaControleController>();

	@override
	Widget build(BuildContext context) {
			return Scaffold(
				key: frotaIpvaControleController.scaffoldKey,	
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('IPVA - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: frotaIpvaControleController.save),
						cancelAndExitButton(onPressed: frotaIpvaControleController.preventDataLoss),
					]
				),				
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: frotaIpvaControleController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: frotaIpvaControleController.scrollController,
							child: SingleChildScrollView(
								controller: frotaIpvaControleController.scrollController,
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
															controller: frotaIpvaControleController.anoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Ano',
																labelText: 'Ano',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaIpvaControleController.frotaIpvaControleModel.ano = text;
																frotaIpvaControleController.formWasChanged = true;
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
															controller: frotaIpvaControleController.parcelaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Parcela',
																labelText: 'Parcela',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaIpvaControleController.frotaIpvaControleModel.parcela = text;
																frotaIpvaControleController.formWasChanged = true;
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
																dateTime: frotaIpvaControleController.frotaIpvaControleModel.dataVencimento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	frotaIpvaControleController.frotaIpvaControleModel.dataVencimento = value;
																	frotaIpvaControleController.formWasChanged = true;
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
																dateTime: frotaIpvaControleController.frotaIpvaControleModel.dataPagamento,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	frotaIpvaControleController.frotaIpvaControleModel.dataPagamento = value;
																	frotaIpvaControleController.formWasChanged = true;
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
															controller: frotaIpvaControleController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																frotaIpvaControleController.frotaIpvaControleModel.valor = frotaIpvaControleController.valorController.numberValue;
																frotaIpvaControleController.formWasChanged = true;
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
