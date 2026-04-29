import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:sped/app/page/shared_widget/shared_widget_imports.dart';
import 'package:sped/app/controller/sintegra_controller.dart';
import 'package:sped/app/infra/infra_imports.dart';
import 'package:sped/app/page/shared_widget/input/input_imports.dart';

class SintegraEditPage extends StatelessWidget {
	SintegraEditPage({Key? key}) : super(key: key);
	final sintegraController = Get.find<SintegraController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					sintegraController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: sintegraController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Sintegra - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: sintegraController.save),
						cancelAndExitButton(onPressed: sintegraController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: sintegraController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: sintegraController.scrollController,
							child: SingleChildScrollView(
								controller: sintegraController.scrollController,
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
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Emissao',
																labelText: 'Data Emissao',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: sintegraController.sintegraModel.dataEmissao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	sintegraController.sintegraModel.dataEmissao = value;
																	sintegraController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Periodo Inicial',
																labelText: 'Periodo Inicial',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: sintegraController.sintegraModel.periodoInicial,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	sintegraController.sintegraModel.periodoInicial = value;
																	sintegraController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Periodo Final',
																labelText: 'Periodo Final',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: sintegraController.sintegraModel.periodoFinal,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	sintegraController.sintegraModel.periodoFinal = value;
																	sintegraController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: sintegraController.sintegraModel.codigoConvenio ?? '57/95',
															labelText: 'Codigo Convenio',
															hintText: 'Informe os dados para o campo Codigo Convenio',
															items: const ['57/95'],
															onChanged: (dynamic newValue) {
																sintegraController.sintegraModel.codigoConvenio = newValue;
																sintegraController.formWasChanged = true;
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
															maxLength: 100,
															controller: sintegraController.finalidadeArquivoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Finalidade Arquivo',
																labelText: 'Finalidade Arquivo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																sintegraController.sintegraModel.finalidadeArquivo = text;
																sintegraController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: sintegraController.sintegraModel.inventario ?? '00-Sem Inventário',
															labelText: 'Inventario',
															hintText: 'Informe os dados para o campo Inventario',
															items: const ['00-Sem Inventário','01-No final do período','02-Na mudança da forma de tributação da mercadoria (ICMS)','03-Na solicitação da baixa cadastral paralisação temporária e outras situações','04-Na alteração do regime de pagamento - condição do contribuite','05-Por determinação dos fiscos'],
															onChanged: (dynamic newValue) {
																sintegraController.sintegraModel.inventario = newValue;
																sintegraController.formWasChanged = true;
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
