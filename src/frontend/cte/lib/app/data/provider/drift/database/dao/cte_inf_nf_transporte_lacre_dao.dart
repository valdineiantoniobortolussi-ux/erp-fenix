import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_inf_nf_transporte_lacre_dao.g.dart';

@DriftAccessor(tables: [
	CteInfNfTransporteLacres,
	CteInformacaoNfTransportes,
])
class CteInfNfTransporteLacreDao extends DatabaseAccessor<AppDatabase> with _$CteInfNfTransporteLacreDaoMixin {
	final AppDatabase db;

	List<CteInfNfTransporteLacre> cteInfNfTransporteLacreList = []; 
	List<CteInfNfTransporteLacreGrouped> cteInfNfTransporteLacreGroupedList = []; 

	CteInfNfTransporteLacreDao(this.db) : super(db);

	Future<List<CteInfNfTransporteLacre>> getList() async {
		cteInfNfTransporteLacreList = await select(cteInfNfTransporteLacres).get();
		return cteInfNfTransporteLacreList;
	}

	Future<List<CteInfNfTransporteLacre>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteInfNfTransporteLacreList = await (select(cteInfNfTransporteLacres)..where((t) => expression)).get();
		return cteInfNfTransporteLacreList;	 
	}

	Future<List<CteInfNfTransporteLacreGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteInfNfTransporteLacres)
			.join([ 
				leftOuterJoin(cteInformacaoNfTransportes, cteInformacaoNfTransportes.id.equalsExp(cteInfNfTransporteLacres.idCteInformacaoNfTransporte)), 
			]);

		if (field != null && field != '') { 
			final column = cteInfNfTransporteLacres.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteInfNfTransporteLacreGroupedList = await query.map((row) {
			final cteInfNfTransporteLacre = row.readTableOrNull(cteInfNfTransporteLacres); 
			final cteInformacaoNfTransporte = row.readTableOrNull(cteInformacaoNfTransportes); 

			return CteInfNfTransporteLacreGrouped(
				cteInfNfTransporteLacre: cteInfNfTransporteLacre, 
				cteInformacaoNfTransporte: cteInformacaoNfTransporte, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cteInfNfTransporteLacreGrouped in cteInfNfTransporteLacreGroupedList) {
		//}		

		return cteInfNfTransporteLacreGroupedList;	
	}

	Future<CteInfNfTransporteLacre?> getObject(dynamic pk) async {
		return await (select(cteInfNfTransporteLacres)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteInfNfTransporteLacre?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_inf_nf_transporte_lacre WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteInfNfTransporteLacre;		 
	} 

	Future<CteInfNfTransporteLacreGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteInfNfTransporteLacreGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteInfNfTransporteLacre = object.cteInfNfTransporteLacre!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteInfNfTransporteLacres).insert(object.cteInfNfTransporteLacre!);
			object.cteInfNfTransporteLacre = object.cteInfNfTransporteLacre!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteInfNfTransporteLacreGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteInfNfTransporteLacres).replace(object.cteInfNfTransporteLacre!);
		});	 
	} 

	Future<int> deleteObject(CteInfNfTransporteLacreGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteInfNfTransporteLacres).delete(object.cteInfNfTransporteLacre!);
		});		
	}

	Future<void> insertChildren(CteInfNfTransporteLacreGrouped object) async {
	}
	
	Future<void> deleteChildren(CteInfNfTransporteLacreGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_inf_nf_transporte_lacre").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}