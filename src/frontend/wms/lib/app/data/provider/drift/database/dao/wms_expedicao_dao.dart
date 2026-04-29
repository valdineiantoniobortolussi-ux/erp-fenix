import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/provider/drift/database/database_imports.dart';

part 'wms_expedicao_dao.g.dart';

@DriftAccessor(tables: [
	WmsExpedicaos,
	WmsOrdemSeparacaoDets,
	WmsArmazenamentos,
])
class WmsExpedicaoDao extends DatabaseAccessor<AppDatabase> with _$WmsExpedicaoDaoMixin {
	final AppDatabase db;

	List<WmsExpedicao> wmsExpedicaoList = []; 
	List<WmsExpedicaoGrouped> wmsExpedicaoGroupedList = []; 

	WmsExpedicaoDao(this.db) : super(db);

	Future<List<WmsExpedicao>> getList() async {
		wmsExpedicaoList = await select(wmsExpedicaos).get();
		return wmsExpedicaoList;
	}

	Future<List<WmsExpedicao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		wmsExpedicaoList = await (select(wmsExpedicaos)..where((t) => expression)).get();
		return wmsExpedicaoList;	 
	}

	Future<List<WmsExpedicaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(wmsExpedicaos)
			.join([ 
				leftOuterJoin(wmsOrdemSeparacaoDets, wmsOrdemSeparacaoDets.id.equalsExp(wmsExpedicaos.idWmsOrdemSeparacaoDet)), 
			]).join([ 
				leftOuterJoin(wmsArmazenamentos, wmsArmazenamentos.id.equalsExp(wmsExpedicaos.idWmsArmazenamento)), 
			]);

		if (field != null && field != '') { 
			final column = wmsExpedicaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		wmsExpedicaoGroupedList = await query.map((row) {
			final wmsExpedicao = row.readTableOrNull(wmsExpedicaos); 
			final wmsOrdemSeparacaoDet = row.readTableOrNull(wmsOrdemSeparacaoDets); 
			final wmsArmazenamento = row.readTableOrNull(wmsArmazenamentos); 

			return WmsExpedicaoGrouped(
				wmsExpedicao: wmsExpedicao, 
				wmsOrdemSeparacaoDet: wmsOrdemSeparacaoDet, 
				wmsArmazenamento: wmsArmazenamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var wmsExpedicaoGrouped in wmsExpedicaoGroupedList) {
		//}		

		return wmsExpedicaoGroupedList;	
	}

	Future<WmsExpedicao?> getObject(dynamic pk) async {
		return await (select(wmsExpedicaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<WmsExpedicao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM wms_expedicao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as WmsExpedicao;		 
	} 

	Future<WmsExpedicaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(WmsExpedicaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.wmsExpedicao = object.wmsExpedicao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(wmsExpedicaos).insert(object.wmsExpedicao!);
			object.wmsExpedicao = object.wmsExpedicao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(WmsExpedicaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(wmsExpedicaos).replace(object.wmsExpedicao!);
		});	 
	} 

	Future<int> deleteObject(WmsExpedicaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(wmsExpedicaos).delete(object.wmsExpedicao!);
		});		
	}

	Future<void> insertChildren(WmsExpedicaoGrouped object) async {
	}
	
	Future<void> deleteChildren(WmsExpedicaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from wms_expedicao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}