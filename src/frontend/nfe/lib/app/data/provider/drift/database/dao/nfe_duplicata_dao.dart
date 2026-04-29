import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'nfe_duplicata_dao.g.dart';

@DriftAccessor(tables: [
	NfeDuplicatas,
	NfeFaturas,
])
class NfeDuplicataDao extends DatabaseAccessor<AppDatabase> with _$NfeDuplicataDaoMixin {
	final AppDatabase db;

	List<NfeDuplicata> nfeDuplicataList = []; 
	List<NfeDuplicataGrouped> nfeDuplicataGroupedList = []; 

	NfeDuplicataDao(this.db) : super(db);

	Future<List<NfeDuplicata>> getList() async {
		nfeDuplicataList = await select(nfeDuplicatas).get();
		return nfeDuplicataList;
	}

	Future<List<NfeDuplicata>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfeDuplicataList = await (select(nfeDuplicatas)..where((t) => expression)).get();
		return nfeDuplicataList;	 
	}

	Future<List<NfeDuplicataGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfeDuplicatas)
			.join([ 
				leftOuterJoin(nfeFaturas, nfeFaturas.id.equalsExp(nfeDuplicatas.idNfeFatura)), 
			]);

		if (field != null && field != '') { 
			final column = nfeDuplicatas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfeDuplicataGroupedList = await query.map((row) {
			final nfeDuplicata = row.readTableOrNull(nfeDuplicatas); 
			final nfeFatura = row.readTableOrNull(nfeFaturas); 

			return NfeDuplicataGrouped(
				nfeDuplicata: nfeDuplicata, 
				nfeFatura: nfeFatura, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var nfeDuplicataGrouped in nfeDuplicataGroupedList) {
		//}		

		return nfeDuplicataGroupedList;	
	}

	Future<NfeDuplicata?> getObject(dynamic pk) async {
		return await (select(nfeDuplicatas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfeDuplicata?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfe_duplicata WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfeDuplicata;		 
	} 

	Future<NfeDuplicataGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfeDuplicataGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfeDuplicata = object.nfeDuplicata!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfeDuplicatas).insert(object.nfeDuplicata!);
			object.nfeDuplicata = object.nfeDuplicata!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfeDuplicataGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfeDuplicatas).replace(object.nfeDuplicata!);
		});	 
	} 

	Future<int> deleteObject(NfeDuplicataGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfeDuplicatas).delete(object.nfeDuplicata!);
		});		
	}

	Future<void> insertChildren(NfeDuplicataGrouped object) async {
	}
	
	Future<void> deleteChildren(NfeDuplicataGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfe_duplicata").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}