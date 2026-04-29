import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_inf_nf_carga_lacre_dao.g.dart';

@DriftAccessor(tables: [
	CteInfNfCargaLacres,
	CteInformacaoNfCargas,
])
class CteInfNfCargaLacreDao extends DatabaseAccessor<AppDatabase> with _$CteInfNfCargaLacreDaoMixin {
	final AppDatabase db;

	List<CteInfNfCargaLacre> cteInfNfCargaLacreList = []; 
	List<CteInfNfCargaLacreGrouped> cteInfNfCargaLacreGroupedList = []; 

	CteInfNfCargaLacreDao(this.db) : super(db);

	Future<List<CteInfNfCargaLacre>> getList() async {
		cteInfNfCargaLacreList = await select(cteInfNfCargaLacres).get();
		return cteInfNfCargaLacreList;
	}

	Future<List<CteInfNfCargaLacre>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteInfNfCargaLacreList = await (select(cteInfNfCargaLacres)..where((t) => expression)).get();
		return cteInfNfCargaLacreList;	 
	}

	Future<List<CteInfNfCargaLacreGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteInfNfCargaLacres)
			.join([ 
				leftOuterJoin(cteInformacaoNfCargas, cteInformacaoNfCargas.id.equalsExp(cteInfNfCargaLacres.idCteInformacaoNfCarga)), 
			]);

		if (field != null && field != '') { 
			final column = cteInfNfCargaLacres.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteInfNfCargaLacreGroupedList = await query.map((row) {
			final cteInfNfCargaLacre = row.readTableOrNull(cteInfNfCargaLacres); 
			final cteInformacaoNfCarga = row.readTableOrNull(cteInformacaoNfCargas); 

			return CteInfNfCargaLacreGrouped(
				cteInfNfCargaLacre: cteInfNfCargaLacre, 
				cteInformacaoNfCarga: cteInformacaoNfCarga, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cteInfNfCargaLacreGrouped in cteInfNfCargaLacreGroupedList) {
		//}		

		return cteInfNfCargaLacreGroupedList;	
	}

	Future<CteInfNfCargaLacre?> getObject(dynamic pk) async {
		return await (select(cteInfNfCargaLacres)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteInfNfCargaLacre?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_inf_nf_carga_lacre WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteInfNfCargaLacre;		 
	} 

	Future<CteInfNfCargaLacreGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteInfNfCargaLacreGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteInfNfCargaLacre = object.cteInfNfCargaLacre!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteInfNfCargaLacres).insert(object.cteInfNfCargaLacre!);
			object.cteInfNfCargaLacre = object.cteInfNfCargaLacre!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteInfNfCargaLacreGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteInfNfCargaLacres).replace(object.cteInfNfCargaLacre!);
		});	 
	} 

	Future<int> deleteObject(CteInfNfCargaLacreGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteInfNfCargaLacres).delete(object.cteInfNfCargaLacre!);
		});		
	}

	Future<void> insertChildren(CteInfNfCargaLacreGrouped object) async {
	}
	
	Future<void> deleteChildren(CteInfNfCargaLacreGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_inf_nf_carga_lacre").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}