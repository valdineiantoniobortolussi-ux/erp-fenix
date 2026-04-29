import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_informacao_nf_carga_dao.g.dart';

@DriftAccessor(tables: [
	CteInformacaoNfCargas,
	CteInformacaoNfOutross,
])
class CteInformacaoNfCargaDao extends DatabaseAccessor<AppDatabase> with _$CteInformacaoNfCargaDaoMixin {
	final AppDatabase db;

	List<CteInformacaoNfCarga> cteInformacaoNfCargaList = []; 
	List<CteInformacaoNfCargaGrouped> cteInformacaoNfCargaGroupedList = []; 

	CteInformacaoNfCargaDao(this.db) : super(db);

	Future<List<CteInformacaoNfCarga>> getList() async {
		cteInformacaoNfCargaList = await select(cteInformacaoNfCargas).get();
		return cteInformacaoNfCargaList;
	}

	Future<List<CteInformacaoNfCarga>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteInformacaoNfCargaList = await (select(cteInformacaoNfCargas)..where((t) => expression)).get();
		return cteInformacaoNfCargaList;	 
	}

	Future<List<CteInformacaoNfCargaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteInformacaoNfCargas)
			.join([ 
				leftOuterJoin(cteInformacaoNfOutross, cteInformacaoNfOutross.id.equalsExp(cteInformacaoNfCargas.idCteInformacaoNf)), 
			]);

		if (field != null && field != '') { 
			final column = cteInformacaoNfCargas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteInformacaoNfCargaGroupedList = await query.map((row) {
			final cteInformacaoNfCarga = row.readTableOrNull(cteInformacaoNfCargas); 
			final cteInformacaoNfOutros = row.readTableOrNull(cteInformacaoNfOutross); 

			return CteInformacaoNfCargaGrouped(
				cteInformacaoNfCarga: cteInformacaoNfCarga, 
				cteInformacaoNfOutros: cteInformacaoNfOutros, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cteInformacaoNfCargaGrouped in cteInformacaoNfCargaGroupedList) {
		//}		

		return cteInformacaoNfCargaGroupedList;	
	}

	Future<CteInformacaoNfCarga?> getObject(dynamic pk) async {
		return await (select(cteInformacaoNfCargas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteInformacaoNfCarga?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_informacao_nf_carga WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteInformacaoNfCarga;		 
	} 

	Future<CteInformacaoNfCargaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteInformacaoNfCargaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteInformacaoNfCarga = object.cteInformacaoNfCarga!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteInformacaoNfCargas).insert(object.cteInformacaoNfCarga!);
			object.cteInformacaoNfCarga = object.cteInformacaoNfCarga!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteInformacaoNfCargaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteInformacaoNfCargas).replace(object.cteInformacaoNfCarga!);
		});	 
	} 

	Future<int> deleteObject(CteInformacaoNfCargaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteInformacaoNfCargas).delete(object.cteInformacaoNfCarga!);
		});		
	}

	Future<void> insertChildren(CteInformacaoNfCargaGrouped object) async {
	}
	
	Future<void> deleteChildren(CteInformacaoNfCargaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_informacao_nf_carga").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}