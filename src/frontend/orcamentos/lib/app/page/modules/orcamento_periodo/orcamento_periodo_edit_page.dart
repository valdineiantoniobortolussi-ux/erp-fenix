import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:orcamentos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:orcamentos/app/controller/orcamento_periodo_controller.dart';
import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/page/shared_widget/input/input_imports.dart';

class OrcamentoPeriodoEditPage extends StatelessWidget {
	OrcamentoPeriodoEditPage({Key? key}) : super(key: key);
	final orcamentoPeriodoController = Get.find<OrcamentoPeriodoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					orcamentoPeriodoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: orcamentoPeriodoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Períodos do Orçamento - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: orcamentoPeriodoController.save),
						cancelAndExitButton(onPressed: orcamentoPeriodoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: orcamentoPeriodoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: orcamentoPeriodoController.scrollController,
							child: SingleChildScrollView(
								controller: orcamentoPeriodoController.scrollController,
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
														child: CustomDropdownButtonFormField(
															value: orcamentoPeriodoController.orcamentoPeriodoModel.periodo ?? '01=Diário',
															labelText: 'Periodo',
															hintText: 'Informe os dados para o campo Periodo',
															items: const ['01=Diário','02=Semanal','03=Mensal','04=Bimestral','05=Trimestral','06=Semestral','07=Anual'],
															onChanged: (dynamic newValue) {
																orcamentoPeriodoController.orcamentoPeriodoModel.periodo = newValue;
																orcamentoPeriodoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-8',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 30,
															controller: orcamentoPeriodoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																orcamentoPeriodoController.orcamentoPeriodoModel.nome = text;
																orcamentoPeriodoController.formWasChanged = true;
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
