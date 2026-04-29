import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'nfe_transporte_volume_lacre_dao.g.dart';

@DriftAccessor(tables: [
	NfeTransporteVolumeLacres,
	NfeTransporteVolumes,
])
class NfeTransporteVolumeLacreDao extends DatabaseAccessor<AppDatabase> with _$NfeTransporteVolumeLacreDaoMixin {
	final AppDatabase db;

	List<NfeTransporteVolumeLacre> nfeTransporteVolumeLacreList = []; 
	List<NfeTransporteVolumeLacreGrouped> nfeTransporteVolumeLacreGroupedList = []; 

	NfeTransporteVolumeLacreDao(this.db) : super(db);

	Future<List<NfeTransporteVolumeLacre>> getList() async {
		nfeTransporteVolumeLacreList = await select(nfeTransporteVolumeLacres).get();
		return nfeTransporteVolumeLacreList;
	}

	Future<List<NfeTransporteVolumeLacre>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfeTransporteVolumeLacreList = await (select(nfeTransporteVolumeLacres)..where((t) => expression)).get();
		return nfeTransporteVolumeLacreList;	 
	}

	Future<List<NfeTransporteVolumeLacreGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfeTransporteVolumeLacres)
			.join([ 
				leftOuterJoin(nfeTransporteVolumes, nfeTransporteVolumes.id.equalsExp(nfeTransporteVolumeLacres.idNfeTransporteVolume)), 
			]);

		if (field != null && field != '') { 
			final column = nfeTransporteVolumeLacres.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfeTransporteVolumeLacreGroupedList = await query.map((row) {
			final nfeTransporteVolumeLacre = row.readTableOrNull(nfeTransporteVolumeLacres); 
			final nfeTransporteVolume = row.readTableOrNull(nfeTransporteVolumes); 

			return NfeTransporteVolumeLacreGrouped(
				nfeTransporteVolumeLacre: nfeTransporteVolumeLacre, 
				nfeTransporteVolume: nfeTransporteVolume, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var nfeTransporteVolumeLacreGrouped in nfeTransporteVolumeLacreGroupedList) {
		//}		

		return nfeTransporteVolumeLacreGroupedList;	
	}

	Future<NfeTransporteVolumeLacre?> getObject(dynamic pk) async {
		return await (select(nfeTransporteVolumeLacres)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfeTransporteVolumeLacre?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfe_transporte_volume_lacre WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfeTransporteVolumeLacre;		 
	} 

	Future<NfeTransporteVolumeLacreGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfeTransporteVolumeLacreGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfeTransporteVolumeLacre = object.nfeTransporteVolumeLacre!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfeTransporteVolumeLacres).insert(object.nfeTransporteVolumeLacre!);
			object.nfeTransporteVolumeLacre = object.nfeTransporteVolumeLacre!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfeTransporteVolumeLacreGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfeTransporteVolumeLacres).replace(object.nfeTransporteVolumeLacre!);
		});	 
	} 

	Future<int> deleteObject(NfeTransporteVolumeLacreGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfeTransporteVolumeLacres).delete(object.nfeTransporteVolumeLacre!);
		});		
	}

	Future<void> insertChildren(NfeTransporteVolumeLacreGrouped object) async {
	}
	
	Future<void> deleteChildren(NfeTransporteVolumeLacreGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfe_transporte_volume_lacre").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}