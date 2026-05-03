import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/provider/drift/database/database_imports.dart';

part 'wms_recebimento_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	WmsRecebimentoCabecalhos,
	WmsRecebimentoDetalhes,
	Produtos,
	WmsAgendamentos,
])
class WmsRecebimentoCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$WmsRecebimentoCabecalhoDaoMixin {
	final AppDatabase db;

	List<WmsRecebimentoCabecalho> wmsRecebimentoCabecalhoList = []; 
	List<WmsRecebimentoCabecalhoGrouped> wmsRecebimentoCabecalhoGroupedList = []; 

	WmsRecebimentoCabecalhoDao(this.db) : super(db);

	Future<List<WmsRecebimentoCabecalho>> getList() async {
		wmsRecebimentoCabecalhoList = await select(wmsRecebimentoCabecalhos).get();
		return wmsRecebimentoCabecalhoList;
	}

	Future<List<WmsRecebimentoCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		wmsRecebimentoCabecalhoList = await (select(wmsRecebimentoCabecalhos)..where((t) => expression)).get();
		return wmsRecebimentoCabecalhoList;	 
	}

	Future<List<WmsRecebimentoCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(wmsRecebimentoCabecalhos)
			.join([ 
				leftOuterJoin(wmsAgendamentos, wmsAgendamentos.id.equalsExp(wmsRecebimentoCabecalhos.idWmsAgendamento)), 
			]);

		if (field != null && field != '') { 
			final column = wmsRecebimentoCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		wmsRecebimentoCabecalhoGroupedList = await query.map((row) {
			final wmsRecebimentoCabecalho = row.readTableOrNull(wmsRecebimentoCabecalhos); 
			final wmsAgendamento = row.readTableOrNull(wmsAgendamentos); 

			return WmsRecebimentoCabecalhoGrouped(
				wmsRecebimentoCabecalho: wmsRecebimentoCabecalho, 
				wmsAgendamento: wmsAgendamento, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var wmsRecebimentoCabecalhoGrouped in wmsRecebimentoCabecalhoGroupedList) {
			wmsRecebimentoCabecalhoGrouped.wmsRecebimentoDetalheGroupedList = [];
			final queryWmsRecebimentoDetalhe = ' id_wms_recebimento_cabecalho = ${wmsRecebimentoCabecalhoGrouped.wmsRecebimentoCabecalho!.id}';
			expression = CustomExpression<bool>(queryWmsRecebimentoDetalhe);
			final wmsRecebimentoDetalheList = await (select(wmsRecebimentoDetalhes)..where((t) => expression)).get();
			for (var wmsRecebimentoDetalhe in wmsRecebimentoDetalheList) {
				WmsRecebimentoDetalheGrouped wmsRecebimentoDetalheGrouped = WmsRecebimentoDetalheGrouped(
					wmsRecebimentoDetalhe: wmsRecebimentoDetalhe,
					produto: await (select(produtos)..where((t) => t.id.equals(wmsRecebimentoDetalhe.idProduto!))).getSingleOrNull(),
				);
				wmsRecebimentoCabecalhoGrouped.wmsRecebimentoDetalheGroupedList!.add(wmsRecebimentoDetalheGrouped);
			}

		}		

		return wmsRecebimentoCabecalhoGroupedList;	
	}

	Future<WmsRecebimentoCabecalho?> getObject(dynamic pk) async {
		return await (select(wmsRecebimentoCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<WmsRecebimentoCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM wms_recebimento_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as WmsRecebimentoCabecalho;		 
	} 

	Future<WmsRecebimentoCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(WmsRecebimentoCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.wmsRecebimentoCabecalho = object.wmsRecebimentoCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(wmsRecebimentoCabecalhos).insert(object.wmsRecebimentoCabecalho!);
			object.wmsRecebimentoCabecalho = object.wmsRecebimentoCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(WmsRecebimentoCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(wmsRecebimentoCabecalhos).replace(object.wmsRecebimentoCabecalho!);
		});	 
	} 

	Future<int> deleteObject(WmsRecebimentoCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(wmsRecebimentoCabecalhos).delete(object.wmsRecebimentoCabecalho!);
		});		
	}

	Future<void> insertChildren(WmsRecebimentoCabecalhoGrouped object) async {
		for (var wmsRecebimentoDetalheGrouped in object.wmsRecebimentoDetalheGroupedList!) {
			wmsRecebimentoDetalheGrouped.wmsRecebimentoDetalhe = wmsRecebimentoDetalheGrouped.wmsRecebimentoDetalhe?.copyWith(
				id: const Value(null),
				idWmsRecebimentoCabecalho: Value(object.wmsRecebimentoCabecalho!.id),
			);
			await into(wmsRecebimentoDetalhes).insert(wmsRecebimentoDetalheGrouped.wmsRecebimentoDetalhe!);
		}
	}
	
	Future<void> deleteChildren(WmsRecebimentoCabecalhoGrouped object) async {
		await (delete(wmsRecebimentoDetalhes)..where((t) => t.idWmsRecebimentoCabecalho.equals(object.wmsRecebimentoCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from wms_recebimento_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}