import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'nfe_transporte_reboque_dao.g.dart';

@DriftAccessor(tables: [
	NfeTransporteReboques,
	NfeTransportes,
])
class NfeTransporteReboqueDao extends DatabaseAccessor<AppDatabase> with _$NfeTransporteReboqueDaoMixin {
	final AppDatabase db;

	List<NfeTransporteReboque> nfeTransporteReboqueList = []; 
	List<NfeTransporteReboqueGrouped> nfeTransporteReboqueGroupedList = []; 

	NfeTransporteReboqueDao(this.db) : super(db);

	Future<List<NfeTransporteReboque>> getList() async {
		nfeTransporteReboqueList = await select(nfeTransporteReboques).get();
		return nfeTransporteReboqueList;
	}

	Future<List<NfeTransporteReboque>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfeTransporteReboqueList = await (select(nfeTransporteReboques)..where((t) => expression)).get();
		return nfeTransporteReboqueList;	 
	}

	Future<List<NfeTransporteReboqueGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfeTransporteReboques)
			.join([ 
				leftOuterJoin(nfeTransportes, nfeTransportes.id.equalsExp(nfeTransporteReboques.idNfeTransporte)), 
			]);

		if (field != null && field != '') { 
			final column = nfeTransporteReboques.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfeTransporteReboqueGroupedList = await query.map((row) {
			final nfeTransporteReboque = row.readTableOrNull(nfeTransporteReboques); 
			final nfeTransporte = row.readTableOrNull(nfeTransportes); 

			return NfeTransporteReboqueGrouped(
				nfeTransporteReboque: nfeTransporteReboque, 
				nfeTransporte: nfeTransporte, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var nfeTransporteReboqueGrouped in nfeTransporteReboqueGroupedList) {
		//}		

		return nfeTransporteReboqueGroupedList;	
	}

	Future<NfeTransporteReboque?> getObject(dynamic pk) async {
		return await (select(nfeTransporteReboques)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfeTransporteReboque?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfe_transporte_reboque WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfeTransporteReboque;		 
	} 

	Future<NfeTransporteReboqueGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfeTransporteReboqueGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfeTransporteReboque = object.nfeTransporteReboque!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfeTransporteReboques).insert(object.nfeTransporteReboque!);
			object.nfeTransporteReboque = object.nfeTransporteReboque!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfeTransporteReboqueGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfeTransporteReboques).replace(object.nfeTransporteReboque!);
		});	 
	} 

	Future<int> deleteObject(NfeTransporteReboqueGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfeTransporteReboques).delete(object.nfeTransporteReboque!);
		});		
	}

	Future<void> insertChildren(NfeTransporteReboqueGrouped object) async {
	}
	
	Future<void> deleteChildren(NfeTransporteReboqueGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfe_transporte_reboque").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}