import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cadastros/app/controller/produto_controller.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/page/shared_widget/input/input_imports.dart';

class ProdutoEditPage extends StatelessWidget {
	ProdutoEditPage({Key? key}) : super(key: key);
	final produtoController = Get.find<ProdutoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					produtoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: produtoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Produto - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: produtoController.save),
						cancelAndExitButton(onPressed: produtoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: produtoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: produtoController.scrollController,
							child: SingleChildScrollView(
								controller: produtoController.scrollController,
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: produtoController.produtoSubgrupoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Subgrupo',
																			labelText: 'Subgrupo *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: produtoController.callProdutoSubgrupoLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: produtoController.produtoMarcaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Marca',
																			labelText: 'Marca *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: produtoController.callProdutoMarcaLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: produtoController.produtoUnidadeModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Unidade',
																			labelText: 'Unidade *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: produtoController.callProdutoUnidadeLookup),
															),
														],
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
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: produtoController.tributIcmsCustomCabModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Informe os dados para o campo Tributação Customizada',
																			labelText: 'Tributação Customizada',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: produtoController.callTributIcmsCustomCabLookup),
															),
														],
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: produtoController.tributGrupoTributarioModelController,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Lookup for Grupo Tributário',
																			labelText: 'Grupo Tributário',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: produtoController.callTributGrupoTributarioLookup),
															),
														],
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
															controller: produtoController.nomeController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Nome',
																labelText: 'Nome',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																produtoController.produtoModel.nome = text;
																produtoController.formWasChanged = true;
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
															controller: produtoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descricao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																produtoController.produtoModel.descricao = text;
																produtoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 14,
															controller: produtoController.gtinController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo GTIN',
																labelText: 'GTIN',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																produtoController.produtoModel.gtin = text;
																produtoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 50,
															controller: produtoController.codigoInternoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Interno',
																labelText: 'Codigo Interno',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																produtoController.produtoModel.codigoInterno = text;
																produtoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: produtoController.valorCompraController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Compra',
																labelText: 'Valor Compra',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																produtoController.produtoModel.valorCompra = produtoController.valorCompraController.numberValue;
																produtoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-3',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: produtoController.valorVendaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Venda',
																labelText: 'Valor Venda',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																produtoController.produtoModel.valorVenda = produtoController.valorVendaController.numberValue;
																produtoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 8,
															controller: produtoController.codigoNcmController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo Ncm',
																labelText: 'Codigo Ncm',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																produtoController.produtoModel.codigoNcm = text;
																produtoController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-6',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Cadastro',
																labelText: 'Data Cadastro',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: produtoController.produtoModel.dataCadastro,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	produtoController.produtoModel.dataCadastro = value;
																	produtoController.formWasChanged = true;
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
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: produtoController.estoqueMinimoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Estoque Minimo',
																labelText: 'Estoque Minimo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																produtoController.produtoModel.estoqueMinimo = produtoController.estoqueMinimoController.numberValue;
																produtoController.formWasChanged = true;
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
															controller: produtoController.estoqueMaximoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Estoque Maximo',
																labelText: 'Estoque Maximo',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																produtoController.produtoModel.estoqueMaximo = produtoController.estoqueMaximoController.numberValue;
																produtoController.formWasChanged = true;
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
															controller: produtoController.quantidadeEstoqueController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Quantidade Estoque',
																labelText: 'Quantidade Estoque',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																produtoController.produtoModel.quantidadeEstoque = produtoController.quantidadeEstoqueController.numberValue;
																produtoController.formWasChanged = true;
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
