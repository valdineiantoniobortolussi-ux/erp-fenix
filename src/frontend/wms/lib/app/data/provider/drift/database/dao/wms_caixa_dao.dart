import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/provider/drift/database/database_imports.dart';

part 'wms_caixa_dao.g.dart';

@DriftAccessor(tables: [
	WmsCaixas,
	WmsArmazenamentos,
	WmsRecebimentoDetalhes,
	WmsEstantes,
])
class WmsCaixaDao extends DatabaseAccessor<AppDatabase> with _$WmsCaixaDaoMixin {
	final AppDatabase db;

	List<WmsCaixa> wmsCaixaList = []; 
	List<WmsCaixaGrouped> wmsCaixaGroupedList = []; 

	WmsCaixaDao(this.db) : super(db);

	Future<List<WmsCaixa>> getList() async {
		wmsCaixaList = await select(wmsCaixas).get();
		return wmsCaixaList;
	}

	Future<List<WmsCaixa>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		wmsCaixaList = await (select(wmsCaixas)..where((t) => expression)).get();
		return wmsCaixaList;	 
	}

	Future<List<WmsCaixaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(wmsCaixas)
			.join([ 
				leftOuterJoin(wmsEstantes, wmsEstantes.id.equalsExp(wmsCaixas.idWmsEstante)), 
			]);

		if (field != null && field != '') { 
			final column = wmsCaixas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		wmsCaixaGroupedList = await query.map((row) {
			final wmsCaixa = row.readTableOrNull(wmsCaixas); 
			final wmsEstante = row.readTableOrNull(wmsEstantes); 

			return WmsCaixaGrouped(
				wmsCaixa: wmsCaixa, 
				wmsEstante: wmsEstante, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var wmsCaixaGrouped in wmsCaixaGroupedList) {
			wmsCaixaGrouped.wmsArmazenamentoGroupedList = [];
			final queryWmsArmazenamento = ' id_wms_caixa = ${wmsCaixaGrouped.wmsCaixa!.id}';
			expression = CustomExpression<bool>(queryWmsArmazenamento);
			final wmsArmazenamentoList = await (select(wmsArmazenamentos)..where((t) => expression)).get();
			for (var wmsArmazenamento in wmsArmazenamentoList) {
				WmsArmazenamentoGrouped wmsArmazenamentoGrouped = WmsArmazenamentoGrouped(
					wmsArmazenamento: wmsArmazenamento,
					wmsRecebimentoDetalhe: await (select(wmsRecebimentoDetalhes)..where((t) => t.id.equals(wmsArmazenamento.idWmsRecebimentoDetalhe!))).getSingleOrNull(),
				);
				wmsCaixaGrouped.wmsArmazenamentoGroupedList!.add(wmsArmazenamentoGrouped);
			}

		}		

		return wmsCaixaGroupedList;	
	}

	Future<WmsCaixa?> getObject(dynamic pk) async {
		return await (select(wmsCaixas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<WmsCaixa?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM wms_caixa WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as WmsCaixa;		 
	} 

	Future<WmsCaixaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(WmsCaixaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.wmsCaixa = object.wmsCaixa!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(wmsCaixas).insert(object.wmsCaixa!);
			object.wmsCaixa = object.wmsCaixa!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(WmsCaixaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(wmsCaixas).replace(object.wmsCaixa!);
		});	 
	} 

	Future<int> deleteObject(WmsCaixaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(wmsCaixas).delete(object.wmsCaixa!);
		});		
	}

	Future<void> insertChildren(WmsCaixaGrouped object) async {
		for (var wmsArmazenamentoGrouped in object.wmsArmazenamentoGroupedList!) {
			wmsArmazenamentoGrouped.wmsArmazenamento = wmsArmazenamentoGrouped.wmsArmazenamento?.copyWith(
				id: const Value(null),
				idWmsCaixa: Value(object.wmsCaixa!.id),
			);
			await into(wmsArmazenamentos).insert(wmsArmazenamentoGrouped.wmsArmazenamento!);
		}
	}
	
	Future<void> deleteChildren(WmsCaixaGrouped object) async {
		await (delete(wmsArmazenamentos)..where((t) => t.idWmsCaixa.equals(object.wmsCaixa!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from wms_caixa").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}