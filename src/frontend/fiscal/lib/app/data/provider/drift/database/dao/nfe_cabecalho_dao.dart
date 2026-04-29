import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';

part 'nfe_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	NfeCabecalhos,
])
class NfeCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$NfeCabecalhoDaoMixin {
	final AppDatabase db;

	List<NfeCabecalho> nfeCabecalhoList = []; 
	List<NfeCabecalhoGrouped> nfeCabecalhoGroupedList = []; 

	NfeCabecalhoDao(this.db) : super(db);

	Future<List<NfeCabecalho>> getList() async {
		nfeCabecalhoList = await select(nfeCabecalhos).get();
		return nfeCabecalhoList;
	}

	Future<List<NfeCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfeCabecalhoList = await (select(nfeCabecalhos)..where((t) => expression)).get();
		return nfeCabecalhoList;	 
	}

	Future<List<NfeCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfeCabecalhos)
			.join([]);

		if (field != null && field != '') { 
			final column = nfeCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfeCabecalhoGroupedList = await query.map((row) {
			final nfeCabecalho = row.readTableOrNull(nfeCabecalhos); 

			return NfeCabecalhoGrouped(
				nfeCabecalho: nfeCabecalho, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var nfeCabecalhoGrouped in nfeCabecalhoGroupedList) {
		//}		

		return nfeCabecalhoGroupedList;	
	}

	Future<NfeCabecalho?> getObject(dynamic pk) async {
		return await (select(nfeCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfeCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfe_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfeCabecalho;		 
	} 

	Future<NfeCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfeCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfeCabecalho = object.nfeCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfeCabecalhos).insert(object.nfeCabecalho!);
			object.nfeCabecalho = object.nfeCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfeCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfeCabecalhos).replace(object.nfeCabecalho!);
		});	 
	} 

	Future<int> deleteObject(NfeCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfeCabecalhos).delete(object.nfeCabecalho!);
		});		
	}

	Future<void> insertChildren(NfeCabecalhoGrouped object) async {
	}
	
	Future<void> deleteChildren(NfeCabecalhoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfe_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}