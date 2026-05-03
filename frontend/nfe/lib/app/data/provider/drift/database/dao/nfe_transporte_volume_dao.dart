import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'nfe_transporte_volume_dao.g.dart';

@DriftAccessor(tables: [
	NfeTransporteVolumes,
	NfeTransportes,
])
class NfeTransporteVolumeDao extends DatabaseAccessor<AppDatabase> with _$NfeTransporteVolumeDaoMixin {
	final AppDatabase db;

	List<NfeTransporteVolume> nfeTransporteVolumeList = []; 
	List<NfeTransporteVolumeGrouped> nfeTransporteVolumeGroupedList = []; 

	NfeTransporteVolumeDao(this.db) : super(db);

	Future<List<NfeTransporteVolume>> getList() async {
		nfeTransporteVolumeList = await select(nfeTransporteVolumes).get();
		return nfeTransporteVolumeList;
	}

	Future<List<NfeTransporteVolume>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfeTransporteVolumeList = await (select(nfeTransporteVolumes)..where((t) => expression)).get();
		return nfeTransporteVolumeList;	 
	}

	Future<List<NfeTransporteVolumeGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfeTransporteVolumes)
			.join([ 
				leftOuterJoin(nfeTransportes, nfeTransportes.id.equalsExp(nfeTransporteVolumes.idNfeTransporte)), 
			]);

		if (field != null && field != '') { 
			final column = nfeTransporteVolumes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfeTransporteVolumeGroupedList = await query.map((row) {
			final nfeTransporteVolume = row.readTableOrNull(nfeTransporteVolumes); 
			final nfeTransporte = row.readTableOrNull(nfeTransportes); 

			return NfeTransporteVolumeGrouped(
				nfeTransporteVolume: nfeTransporteVolume, 
				nfeTransporte: nfeTransporte, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var nfeTransporteVolumeGrouped in nfeTransporteVolumeGroupedList) {
		//}		

		return nfeTransporteVolumeGroupedList;	
	}

	Future<NfeTransporteVolume?> getObject(dynamic pk) async {
		return await (select(nfeTransporteVolumes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfeTransporteVolume?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfe_transporte_volume WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfeTransporteVolume;		 
	} 

	Future<NfeTransporteVolumeGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfeTransporteVolumeGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfeTransporteVolume = object.nfeTransporteVolume!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfeTransporteVolumes).insert(object.nfeTransporteVolume!);
			object.nfeTransporteVolume = object.nfeTransporteVolume!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfeTransporteVolumeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfeTransporteVolumes).replace(object.nfeTransporteVolume!);
		});	 
	} 

	Future<int> deleteObject(NfeTransporteVolumeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfeTransporteVolumes).delete(object.nfeTransporteVolume!);
		});		
	}

	Future<void> insertChildren(NfeTransporteVolumeGrouped object) async {
	}
	
	Future<void> deleteChildren(NfeTransporteVolumeGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfe_transporte_volume").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}