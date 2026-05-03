import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/provider/drift/database/database_imports.dart';

part 'wms_ordem_separacao_cab_dao.g.dart';

@DriftAccessor(tables: [
	WmsOrdemSeparacaoCabs,
	WmsOrdemSeparacaoDets,
	Produtos,
])
class WmsOrdemSeparacaoCabDao extends DatabaseAccessor<AppDatabase> with _$WmsOrdemSeparacaoCabDaoMixin {
	final AppDatabase db;

	List<WmsOrdemSeparacaoCab> wmsOrdemSeparacaoCabList = []; 
	List<WmsOrdemSeparacaoCabGrouped> wmsOrdemSeparacaoCabGroupedList = []; 

	WmsOrdemSeparacaoCabDao(this.db) : super(db);

	Future<List<WmsOrdemSeparacaoCab>> getList() async {
		wmsOrdemSeparacaoCabList = await select(wmsOrdemSeparacaoCabs).get();
		return wmsOrdemSeparacaoCabList;
	}

	Future<List<WmsOrdemSeparacaoCab>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		wmsOrdemSeparacaoCabList = await (select(wmsOrdemSeparacaoCabs)..where((t) => expression)).get();
		return wmsOrdemSeparacaoCabList;	 
	}

	Future<List<WmsOrdemSeparacaoCabGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(wmsOrdemSeparacaoCabs)
			.join([]);

		if (field != null && field != '') { 
			final column = wmsOrdemSeparacaoCabs.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		wmsOrdemSeparacaoCabGroupedList = await query.map((row) {
			final wmsOrdemSeparacaoCab = row.readTableOrNull(wmsOrdemSeparacaoCabs); 

			return WmsOrdemSeparacaoCabGrouped(
				wmsOrdemSeparacaoCab: wmsOrdemSeparacaoCab, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var wmsOrdemSeparacaoCabGrouped in wmsOrdemSeparacaoCabGroupedList) {
			wmsOrdemSeparacaoCabGrouped.wmsOrdemSeparacaoDetGroupedList = [];
			final queryWmsOrdemSeparacaoDet = ' id_wms_ordem_separacao_cab = ${wmsOrdemSeparacaoCabGrouped.wmsOrdemSeparacaoCab!.id}';
			expression = CustomExpression<bool>(queryWmsOrdemSeparacaoDet);
			final wmsOrdemSeparacaoDetList = await (select(wmsOrdemSeparacaoDets)..where((t) => expression)).get();
			for (var wmsOrdemSeparacaoDet in wmsOrdemSeparacaoDetList) {
				WmsOrdemSeparacaoDetGrouped wmsOrdemSeparacaoDetGrouped = WmsOrdemSeparacaoDetGrouped(
					wmsOrdemSeparacaoDet: wmsOrdemSeparacaoDet,
					produto: await (select(produtos)..where((t) => t.id.equals(wmsOrdemSeparacaoDet.idProduto!))).getSingleOrNull(),
				);
				wmsOrdemSeparacaoCabGrouped.wmsOrdemSeparacaoDetGroupedList!.add(wmsOrdemSeparacaoDetGrouped);
			}

		}		

		return wmsOrdemSeparacaoCabGroupedList;	
	}

	Future<WmsOrdemSeparacaoCab?> getObject(dynamic pk) async {
		return await (select(wmsOrdemSeparacaoCabs)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<WmsOrdemSeparacaoCab?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM wms_ordem_separacao_cab WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as WmsOrdemSeparacaoCab;		 
	} 

	Future<WmsOrdemSeparacaoCabGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(WmsOrdemSeparacaoCabGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.wmsOrdemSeparacaoCab = object.wmsOrdemSeparacaoCab!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(wmsOrdemSeparacaoCabs).insert(object.wmsOrdemSeparacaoCab!);
			object.wmsOrdemSeparacaoCab = object.wmsOrdemSeparacaoCab!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(WmsOrdemSeparacaoCabGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(wmsOrdemSeparacaoCabs).replace(object.wmsOrdemSeparacaoCab!);
		});	 
	} 

	Future<int> deleteObject(WmsOrdemSeparacaoCabGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(wmsOrdemSeparacaoCabs).delete(object.wmsOrdemSeparacaoCab!);
		});		
	}

	Future<void> insertChildren(WmsOrdemSeparacaoCabGrouped object) async {
		for (var wmsOrdemSeparacaoDetGrouped in object.wmsOrdemSeparacaoDetGroupedList!) {
			wmsOrdemSeparacaoDetGrouped.wmsOrdemSeparacaoDet = wmsOrdemSeparacaoDetGrouped.wmsOrdemSeparacaoDet?.copyWith(
				id: const Value(null),
				idWmsOrdemSeparacaoCab: Value(object.wmsOrdemSeparacaoCab!.id),
			);
			await into(wmsOrdemSeparacaoDets).insert(wmsOrdemSeparacaoDetGrouped.wmsOrdemSeparacaoDet!);
		}
	}
	
	Future<void> deleteChildren(WmsOrdemSeparacaoCabGrouped object) async {
		await (delete(wmsOrdemSeparacaoDets)..where((t) => t.idWmsOrdemSeparacaoCab.equals(object.wmsOrdemSeparacaoCab!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from wms_ordem_separacao_cab").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}