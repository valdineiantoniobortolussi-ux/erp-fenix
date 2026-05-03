import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'nfe_cana_deducoes_safra_dao.g.dart';

@DriftAccessor(tables: [
	NfeCanaDeducoesSafras,
	NfeCanas,
])
class NfeCanaDeducoesSafraDao extends DatabaseAccessor<AppDatabase> with _$NfeCanaDeducoesSafraDaoMixin {
	final AppDatabase db;

	List<NfeCanaDeducoesSafra> nfeCanaDeducoesSafraList = []; 
	List<NfeCanaDeducoesSafraGrouped> nfeCanaDeducoesSafraGroupedList = []; 

	NfeCanaDeducoesSafraDao(this.db) : super(db);

	Future<List<NfeCanaDeducoesSafra>> getList() async {
		nfeCanaDeducoesSafraList = await select(nfeCanaDeducoesSafras).get();
		return nfeCanaDeducoesSafraList;
	}

	Future<List<NfeCanaDeducoesSafra>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfeCanaDeducoesSafraList = await (select(nfeCanaDeducoesSafras)..where((t) => expression)).get();
		return nfeCanaDeducoesSafraList;	 
	}

	Future<List<NfeCanaDeducoesSafraGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfeCanaDeducoesSafras)
			.join([ 
				leftOuterJoin(nfeCanas, nfeCanas.id.equalsExp(nfeCanaDeducoesSafras.idNfeCana)), 
			]);

		if (field != null && field != '') { 
			final column = nfeCanaDeducoesSafras.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfeCanaDeducoesSafraGroupedList = await query.map((row) {
			final nfeCanaDeducoesSafra = row.readTableOrNull(nfeCanaDeducoesSafras); 
			final nfeCana = row.readTableOrNull(nfeCanas); 

			return NfeCanaDeducoesSafraGrouped(
				nfeCanaDeducoesSafra: nfeCanaDeducoesSafra, 
				nfeCana: nfeCana, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var nfeCanaDeducoesSafraGrouped in nfeCanaDeducoesSafraGroupedList) {
		//}		

		return nfeCanaDeducoesSafraGroupedList;	
	}

	Future<NfeCanaDeducoesSafra?> getObject(dynamic pk) async {
		return await (select(nfeCanaDeducoesSafras)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfeCanaDeducoesSafra?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfe_cana_deducoes_safra WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfeCanaDeducoesSafra;		 
	} 

	Future<NfeCanaDeducoesSafraGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfeCanaDeducoesSafraGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfeCanaDeducoesSafra = object.nfeCanaDeducoesSafra!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfeCanaDeducoesSafras).insert(object.nfeCanaDeducoesSafra!);
			object.nfeCanaDeducoesSafra = object.nfeCanaDeducoesSafra!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfeCanaDeducoesSafraGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfeCanaDeducoesSafras).replace(object.nfeCanaDeducoesSafra!);
		});	 
	} 

	Future<int> deleteObject(NfeCanaDeducoesSafraGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfeCanaDeducoesSafras).delete(object.nfeCanaDeducoesSafra!);
		});		
	}

	Future<void> insertChildren(NfeCanaDeducoesSafraGrouped object) async {
	}
	
	Future<void> deleteChildren(NfeCanaDeducoesSafraGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfe_cana_deducoes_safra").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}