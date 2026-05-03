import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	CteCabecalhos,
	CteEmitentes,
	CteLocalColetas,
	CteTomadors,
	CtePassagems,
	CteRemetentes,
	CteExpedidors,
	CteRecebedors,
	CteDestinatarios,
	CteLocalEntregas,
	CteComponentes,
	CteCargas,
	CteInformacaoNfOutross,
	CteSeguros,
	CtePerigosos,
	CteVeiculoNovos,
	CteFaturas,
	CteDuplicatas,
	CteRodoviarios,
	CteAereos,
	CteAquaviarios,
	CteFerroviarios,
	CteDutoviarios,
	CteMultimodals,
])
class CteCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$CteCabecalhoDaoMixin {
	final AppDatabase db;

	List<CteCabecalho> cteCabecalhoList = []; 
	List<CteCabecalhoGrouped> cteCabecalhoGroupedList = []; 

	CteCabecalhoDao(this.db) : super(db);

	Future<List<CteCabecalho>> getList() async {
		cteCabecalhoList = await select(cteCabecalhos).get();
		return cteCabecalhoList;
	}

	Future<List<CteCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteCabecalhoList = await (select(cteCabecalhos)..where((t) => expression)).get();
		return cteCabecalhoList;	 
	}

	Future<List<CteCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteCabecalhos)
			.join([]);

		if (field != null && field != '') { 
			final column = cteCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteCabecalhoGroupedList = await query.map((row) {
			final cteCabecalho = row.readTableOrNull(cteCabecalhos); 

			return CteCabecalhoGrouped(
				cteCabecalho: cteCabecalho, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var cteCabecalhoGrouped in cteCabecalhoGroupedList) {
			cteCabecalhoGrouped.cteEmitenteGroupedList = [];
			final queryCteEmitente = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteEmitente);
			final cteEmitenteList = await (select(cteEmitentes)..where((t) => expression)).get();
			for (var cteEmitente in cteEmitenteList) {
				CteEmitenteGrouped cteEmitenteGrouped = CteEmitenteGrouped(
					cteEmitente: cteEmitente,
				);
				cteCabecalhoGrouped.cteEmitenteGroupedList!.add(cteEmitenteGrouped);
			}

			cteCabecalhoGrouped.cteLocalColetaGroupedList = [];
			final queryCteLocalColeta = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteLocalColeta);
			final cteLocalColetaList = await (select(cteLocalColetas)..where((t) => expression)).get();
			for (var cteLocalColeta in cteLocalColetaList) {
				CteLocalColetaGrouped cteLocalColetaGrouped = CteLocalColetaGrouped(
					cteLocalColeta: cteLocalColeta,
				);
				cteCabecalhoGrouped.cteLocalColetaGroupedList!.add(cteLocalColetaGrouped);
			}

			cteCabecalhoGrouped.cteTomadorGroupedList = [];
			final queryCteTomador = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteTomador);
			final cteTomadorList = await (select(cteTomadors)..where((t) => expression)).get();
			for (var cteTomador in cteTomadorList) {
				CteTomadorGrouped cteTomadorGrouped = CteTomadorGrouped(
					cteTomador: cteTomador,
				);
				cteCabecalhoGrouped.cteTomadorGroupedList!.add(cteTomadorGrouped);
			}

			cteCabecalhoGrouped.ctePassagemGroupedList = [];
			final queryCtePassagem = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCtePassagem);
			final ctePassagemList = await (select(ctePassagems)..where((t) => expression)).get();
			for (var ctePassagem in ctePassagemList) {
				CtePassagemGrouped ctePassagemGrouped = CtePassagemGrouped(
					ctePassagem: ctePassagem,
				);
				cteCabecalhoGrouped.ctePassagemGroupedList!.add(ctePassagemGrouped);
			}

			cteCabecalhoGrouped.cteRemetenteGroupedList = [];
			final queryCteRemetente = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteRemetente);
			final cteRemetenteList = await (select(cteRemetentes)..where((t) => expression)).get();
			for (var cteRemetente in cteRemetenteList) {
				CteRemetenteGrouped cteRemetenteGrouped = CteRemetenteGrouped(
					cteRemetente: cteRemetente,
				);
				cteCabecalhoGrouped.cteRemetenteGroupedList!.add(cteRemetenteGrouped);
			}

			cteCabecalhoGrouped.cteExpedidorGroupedList = [];
			final queryCteExpedidor = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteExpedidor);
			final cteExpedidorList = await (select(cteExpedidors)..where((t) => expression)).get();
			for (var cteExpedidor in cteExpedidorList) {
				CteExpedidorGrouped cteExpedidorGrouped = CteExpedidorGrouped(
					cteExpedidor: cteExpedidor,
				);
				cteCabecalhoGrouped.cteExpedidorGroupedList!.add(cteExpedidorGrouped);
			}

			cteCabecalhoGrouped.cteRecebedorGroupedList = [];
			final queryCteRecebedor = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteRecebedor);
			final cteRecebedorList = await (select(cteRecebedors)..where((t) => expression)).get();
			for (var cteRecebedor in cteRecebedorList) {
				CteRecebedorGrouped cteRecebedorGrouped = CteRecebedorGrouped(
					cteRecebedor: cteRecebedor,
				);
				cteCabecalhoGrouped.cteRecebedorGroupedList!.add(cteRecebedorGrouped);
			}

			cteCabecalhoGrouped.cteDestinatarioGroupedList = [];
			final queryCteDestinatario = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteDestinatario);
			final cteDestinatarioList = await (select(cteDestinatarios)..where((t) => expression)).get();
			for (var cteDestinatario in cteDestinatarioList) {
				CteDestinatarioGrouped cteDestinatarioGrouped = CteDestinatarioGrouped(
					cteDestinatario: cteDestinatario,
				);
				cteCabecalhoGrouped.cteDestinatarioGroupedList!.add(cteDestinatarioGrouped);
			}

			cteCabecalhoGrouped.cteLocalEntregaGroupedList = [];
			final queryCteLocalEntrega = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteLocalEntrega);
			final cteLocalEntregaList = await (select(cteLocalEntregas)..where((t) => expression)).get();
			for (var cteLocalEntrega in cteLocalEntregaList) {
				CteLocalEntregaGrouped cteLocalEntregaGrouped = CteLocalEntregaGrouped(
					cteLocalEntrega: cteLocalEntrega,
				);
				cteCabecalhoGrouped.cteLocalEntregaGroupedList!.add(cteLocalEntregaGrouped);
			}

			cteCabecalhoGrouped.cteComponenteGroupedList = [];
			final queryCteComponente = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteComponente);
			final cteComponenteList = await (select(cteComponentes)..where((t) => expression)).get();
			for (var cteComponente in cteComponenteList) {
				CteComponenteGrouped cteComponenteGrouped = CteComponenteGrouped(
					cteComponente: cteComponente,
				);
				cteCabecalhoGrouped.cteComponenteGroupedList!.add(cteComponenteGrouped);
			}

			cteCabecalhoGrouped.cteCargaGroupedList = [];
			final queryCteCarga = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteCarga);
			final cteCargaList = await (select(cteCargas)..where((t) => expression)).get();
			for (var cteCarga in cteCargaList) {
				CteCargaGrouped cteCargaGrouped = CteCargaGrouped(
					cteCarga: cteCarga,
				);
				cteCabecalhoGrouped.cteCargaGroupedList!.add(cteCargaGrouped);
			}

			cteCabecalhoGrouped.cteInformacaoNfOutrosGroupedList = [];
			final queryCteInformacaoNfOutros = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteInformacaoNfOutros);
			final cteInformacaoNfOutrosList = await (select(cteInformacaoNfOutross)..where((t) => expression)).get();
			for (var cteInformacaoNfOutros in cteInformacaoNfOutrosList) {
				CteInformacaoNfOutrosGrouped cteInformacaoNfOutrosGrouped = CteInformacaoNfOutrosGrouped(
					cteInformacaoNfOutros: cteInformacaoNfOutros,
				);
				cteCabecalhoGrouped.cteInformacaoNfOutrosGroupedList!.add(cteInformacaoNfOutrosGrouped);
			}

			cteCabecalhoGrouped.cteSeguroGroupedList = [];
			final queryCteSeguro = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteSeguro);
			final cteSeguroList = await (select(cteSeguros)..where((t) => expression)).get();
			for (var cteSeguro in cteSeguroList) {
				CteSeguroGrouped cteSeguroGrouped = CteSeguroGrouped(
					cteSeguro: cteSeguro,
				);
				cteCabecalhoGrouped.cteSeguroGroupedList!.add(cteSeguroGrouped);
			}

			cteCabecalhoGrouped.ctePerigosoGroupedList = [];
			final queryCtePerigoso = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCtePerigoso);
			final ctePerigosoList = await (select(ctePerigosos)..where((t) => expression)).get();
			for (var ctePerigoso in ctePerigosoList) {
				CtePerigosoGrouped ctePerigosoGrouped = CtePerigosoGrouped(
					ctePerigoso: ctePerigoso,
				);
				cteCabecalhoGrouped.ctePerigosoGroupedList!.add(ctePerigosoGrouped);
			}

			cteCabecalhoGrouped.cteVeiculoNovoGroupedList = [];
			final queryCteVeiculoNovo = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteVeiculoNovo);
			final cteVeiculoNovoList = await (select(cteVeiculoNovos)..where((t) => expression)).get();
			for (var cteVeiculoNovo in cteVeiculoNovoList) {
				CteVeiculoNovoGrouped cteVeiculoNovoGrouped = CteVeiculoNovoGrouped(
					cteVeiculoNovo: cteVeiculoNovo,
				);
				cteCabecalhoGrouped.cteVeiculoNovoGroupedList!.add(cteVeiculoNovoGrouped);
			}

			cteCabecalhoGrouped.cteFaturaGroupedList = [];
			final queryCteFatura = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteFatura);
			final cteFaturaList = await (select(cteFaturas)..where((t) => expression)).get();
			for (var cteFatura in cteFaturaList) {
				CteFaturaGrouped cteFaturaGrouped = CteFaturaGrouped(
					cteFatura: cteFatura,
				);
				cteCabecalhoGrouped.cteFaturaGroupedList!.add(cteFaturaGrouped);
			}

			cteCabecalhoGrouped.cteDuplicataGroupedList = [];
			final queryCteDuplicata = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteDuplicata);
			final cteDuplicataList = await (select(cteDuplicatas)..where((t) => expression)).get();
			for (var cteDuplicata in cteDuplicataList) {
				CteDuplicataGrouped cteDuplicataGrouped = CteDuplicataGrouped(
					cteDuplicata: cteDuplicata,
				);
				cteCabecalhoGrouped.cteDuplicataGroupedList!.add(cteDuplicataGrouped);
			}

			cteCabecalhoGrouped.cteRodoviarioGroupedList = [];
			final queryCteRodoviario = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteRodoviario);
			final cteRodoviarioList = await (select(cteRodoviarios)..where((t) => expression)).get();
			for (var cteRodoviario in cteRodoviarioList) {
				CteRodoviarioGrouped cteRodoviarioGrouped = CteRodoviarioGrouped(
					cteRodoviario: cteRodoviario,
				);
				cteCabecalhoGrouped.cteRodoviarioGroupedList!.add(cteRodoviarioGrouped);
			}

			cteCabecalhoGrouped.cteAereoGroupedList = [];
			final queryCteAereo = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteAereo);
			final cteAereoList = await (select(cteAereos)..where((t) => expression)).get();
			for (var cteAereo in cteAereoList) {
				CteAereoGrouped cteAereoGrouped = CteAereoGrouped(
					cteAereo: cteAereo,
				);
				cteCabecalhoGrouped.cteAereoGroupedList!.add(cteAereoGrouped);
			}

			cteCabecalhoGrouped.cteAquaviarioGroupedList = [];
			final queryCteAquaviario = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteAquaviario);
			final cteAquaviarioList = await (select(cteAquaviarios)..where((t) => expression)).get();
			for (var cteAquaviario in cteAquaviarioList) {
				CteAquaviarioGrouped cteAquaviarioGrouped = CteAquaviarioGrouped(
					cteAquaviario: cteAquaviario,
				);
				cteCabecalhoGrouped.cteAquaviarioGroupedList!.add(cteAquaviarioGrouped);
			}

			cteCabecalhoGrouped.cteFerroviarioGroupedList = [];
			final queryCteFerroviario = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteFerroviario);
			final cteFerroviarioList = await (select(cteFerroviarios)..where((t) => expression)).get();
			for (var cteFerroviario in cteFerroviarioList) {
				CteFerroviarioGrouped cteFerroviarioGrouped = CteFerroviarioGrouped(
					cteFerroviario: cteFerroviario,
				);
				cteCabecalhoGrouped.cteFerroviarioGroupedList!.add(cteFerroviarioGrouped);
			}

			cteCabecalhoGrouped.cteDutoviarioGroupedList = [];
			final queryCteDutoviario = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteDutoviario);
			final cteDutoviarioList = await (select(cteDutoviarios)..where((t) => expression)).get();
			for (var cteDutoviario in cteDutoviarioList) {
				CteDutoviarioGrouped cteDutoviarioGrouped = CteDutoviarioGrouped(
					cteDutoviario: cteDutoviario,
				);
				cteCabecalhoGrouped.cteDutoviarioGroupedList!.add(cteDutoviarioGrouped);
			}

			cteCabecalhoGrouped.cteMultimodalGroupedList = [];
			final queryCteMultimodal = ' id_cte_cabecalho = ${cteCabecalhoGrouped.cteCabecalho!.id}';
			expression = CustomExpression<bool>(queryCteMultimodal);
			final cteMultimodalList = await (select(cteMultimodals)..where((t) => expression)).get();
			for (var cteMultimodal in cteMultimodalList) {
				CteMultimodalGrouped cteMultimodalGrouped = CteMultimodalGrouped(
					cteMultimodal: cteMultimodal,
				);
				cteCabecalhoGrouped.cteMultimodalGroupedList!.add(cteMultimodalGrouped);
			}

		}		

		return cteCabecalhoGroupedList;	
	}

	Future<CteCabecalho?> getObject(dynamic pk) async {
		return await (select(cteCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteCabecalho;		 
	} 

	Future<CteCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteCabecalho = object.cteCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteCabecalhos).insert(object.cteCabecalho!);
			object.cteCabecalho = object.cteCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteCabecalhos).replace(object.cteCabecalho!);
		});	 
	} 

	Future<int> deleteObject(CteCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteCabecalhos).delete(object.cteCabecalho!);
		});		
	}

	Future<void> insertChildren(CteCabecalhoGrouped object) async {
		for (var cteEmitenteGrouped in object.cteEmitenteGroupedList!) {
			cteEmitenteGrouped.cteEmitente = cteEmitenteGrouped.cteEmitente?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteEmitentes).insert(cteEmitenteGrouped.cteEmitente!);
		}
		for (var cteLocalColetaGrouped in object.cteLocalColetaGroupedList!) {
			cteLocalColetaGrouped.cteLocalColeta = cteLocalColetaGrouped.cteLocalColeta?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteLocalColetas).insert(cteLocalColetaGrouped.cteLocalColeta!);
		}
		for (var cteTomadorGrouped in object.cteTomadorGroupedList!) {
			cteTomadorGrouped.cteTomador = cteTomadorGrouped.cteTomador?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteTomadors).insert(cteTomadorGrouped.cteTomador!);
		}
		for (var ctePassagemGrouped in object.ctePassagemGroupedList!) {
			ctePassagemGrouped.ctePassagem = ctePassagemGrouped.ctePassagem?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(ctePassagems).insert(ctePassagemGrouped.ctePassagem!);
		}
		for (var cteRemetenteGrouped in object.cteRemetenteGroupedList!) {
			cteRemetenteGrouped.cteRemetente = cteRemetenteGrouped.cteRemetente?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteRemetentes).insert(cteRemetenteGrouped.cteRemetente!);
		}
		for (var cteExpedidorGrouped in object.cteExpedidorGroupedList!) {
			cteExpedidorGrouped.cteExpedidor = cteExpedidorGrouped.cteExpedidor?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteExpedidors).insert(cteExpedidorGrouped.cteExpedidor!);
		}
		for (var cteRecebedorGrouped in object.cteRecebedorGroupedList!) {
			cteRecebedorGrouped.cteRecebedor = cteRecebedorGrouped.cteRecebedor?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteRecebedors).insert(cteRecebedorGrouped.cteRecebedor!);
		}
		for (var cteDestinatarioGrouped in object.cteDestinatarioGroupedList!) {
			cteDestinatarioGrouped.cteDestinatario = cteDestinatarioGrouped.cteDestinatario?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteDestinatarios).insert(cteDestinatarioGrouped.cteDestinatario!);
		}
		for (var cteLocalEntregaGrouped in object.cteLocalEntregaGroupedList!) {
			cteLocalEntregaGrouped.cteLocalEntrega = cteLocalEntregaGrouped.cteLocalEntrega?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteLocalEntregas).insert(cteLocalEntregaGrouped.cteLocalEntrega!);
		}
		for (var cteComponenteGrouped in object.cteComponenteGroupedList!) {
			cteComponenteGrouped.cteComponente = cteComponenteGrouped.cteComponente?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteComponentes).insert(cteComponenteGrouped.cteComponente!);
		}
		for (var cteCargaGrouped in object.cteCargaGroupedList!) {
			cteCargaGrouped.cteCarga = cteCargaGrouped.cteCarga?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteCargas).insert(cteCargaGrouped.cteCarga!);
		}
		for (var cteInformacaoNfOutrosGrouped in object.cteInformacaoNfOutrosGroupedList!) {
			cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros = cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteInformacaoNfOutross).insert(cteInformacaoNfOutrosGrouped.cteInformacaoNfOutros!);
		}
		for (var cteSeguroGrouped in object.cteSeguroGroupedList!) {
			cteSeguroGrouped.cteSeguro = cteSeguroGrouped.cteSeguro?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteSeguros).insert(cteSeguroGrouped.cteSeguro!);
		}
		for (var ctePerigosoGrouped in object.ctePerigosoGroupedList!) {
			ctePerigosoGrouped.ctePerigoso = ctePerigosoGrouped.ctePerigoso?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(ctePerigosos).insert(ctePerigosoGrouped.ctePerigoso!);
		}
		for (var cteVeiculoNovoGrouped in object.cteVeiculoNovoGroupedList!) {
			cteVeiculoNovoGrouped.cteVeiculoNovo = cteVeiculoNovoGrouped.cteVeiculoNovo?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteVeiculoNovos).insert(cteVeiculoNovoGrouped.cteVeiculoNovo!);
		}
		for (var cteFaturaGrouped in object.cteFaturaGroupedList!) {
			cteFaturaGrouped.cteFatura = cteFaturaGrouped.cteFatura?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteFaturas).insert(cteFaturaGrouped.cteFatura!);
		}
		for (var cteDuplicataGrouped in object.cteDuplicataGroupedList!) {
			cteDuplicataGrouped.cteDuplicata = cteDuplicataGrouped.cteDuplicata?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteDuplicatas).insert(cteDuplicataGrouped.cteDuplicata!);
		}
		for (var cteRodoviarioGrouped in object.cteRodoviarioGroupedList!) {
			cteRodoviarioGrouped.cteRodoviario = cteRodoviarioGrouped.cteRodoviario?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteRodoviarios).insert(cteRodoviarioGrouped.cteRodoviario!);
		}
		for (var cteAereoGrouped in object.cteAereoGroupedList!) {
			cteAereoGrouped.cteAereo = cteAereoGrouped.cteAereo?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteAereos).insert(cteAereoGrouped.cteAereo!);
		}
		for (var cteAquaviarioGrouped in object.cteAquaviarioGroupedList!) {
			cteAquaviarioGrouped.cteAquaviario = cteAquaviarioGrouped.cteAquaviario?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteAquaviarios).insert(cteAquaviarioGrouped.cteAquaviario!);
		}
		for (var cteFerroviarioGrouped in object.cteFerroviarioGroupedList!) {
			cteFerroviarioGrouped.cteFerroviario = cteFerroviarioGrouped.cteFerroviario?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteFerroviarios).insert(cteFerroviarioGrouped.cteFerroviario!);
		}
		for (var cteDutoviarioGrouped in object.cteDutoviarioGroupedList!) {
			cteDutoviarioGrouped.cteDutoviario = cteDutoviarioGrouped.cteDutoviario?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteDutoviarios).insert(cteDutoviarioGrouped.cteDutoviario!);
		}
		for (var cteMultimodalGrouped in object.cteMultimodalGroupedList!) {
			cteMultimodalGrouped.cteMultimodal = cteMultimodalGrouped.cteMultimodal?.copyWith(
				id: const Value(null),
				idCteCabecalho: Value(object.cteCabecalho!.id),
			);
			await into(cteMultimodals).insert(cteMultimodalGrouped.cteMultimodal!);
		}
	}
	
	Future<void> deleteChildren(CteCabecalhoGrouped object) async {
		await (delete(cteEmitentes)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteLocalColetas)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteTomadors)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(ctePassagems)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteRemetentes)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteExpedidors)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteRecebedors)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteDestinatarios)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteLocalEntregas)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteComponentes)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteCargas)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteInformacaoNfOutross)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteSeguros)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(ctePerigosos)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteVeiculoNovos)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteFaturas)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteDuplicatas)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteRodoviarios)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteAereos)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteAquaviarios)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteFerroviarios)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteDutoviarios)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
		await (delete(cteMultimodals)..where((t) => t.idCteCabecalho.equals(object.cteCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}