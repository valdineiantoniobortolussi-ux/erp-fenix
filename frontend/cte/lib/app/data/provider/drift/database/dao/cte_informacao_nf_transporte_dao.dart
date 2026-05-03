import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_informacao_nf_transporte_dao.g.dart';

@DriftAccessor(tables: [
	CteInformacaoNfTransportes,
	CteInformacaoNfOutross,
])
class CteInformacaoNfTransporteDao extends DatabaseAccessor<AppDatabase> with _$CteInformacaoNfTransporteDaoMixin {
	final AppDatabase db;

	List<CteInformacaoNfTransporte> cteInformacaoNfTransporteList = []; 
	List<CteInformacaoNfTransporteGrouped> cteInformacaoNfTransporteGroupedList = []; 

	CteInformacaoNfTransporteDao(this.db) : super(db);

	Future<List<CteInformacaoNfTransporte>> getList() async {
		cteInformacaoNfTransporteList = await select(cteInformacaoNfTransportes).get();
		return cteInformacaoNfTransporteList;
	}

	Future<List<CteInformacaoNfTransporte>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteInformacaoNfTransporteList = await (select(cteInformacaoNfTransportes)..where((t) => expression)).get();
		return cteInformacaoNfTransporteList;	 
	}

	Future<List<CteInformacaoNfTransporteGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteInformacaoNfTransportes)
			.join([ 
				leftOuterJoin(cteInformacaoNfOutross, cteInformacaoNfOutross.id.equalsExp(cteInformacaoNfTransportes.idCteInformacaoNf)), 
			]);

		if (field != null && field != '') { 
			final column = cteInformacaoNfTransportes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteInformacaoNfTransporteGroupedList = await query.map((row) {
			final cteInformacaoNfTransporte = row.readTableOrNull(cteInformacaoNfTransportes); 
			final cteInformacaoNfOutros = row.readTableOrNull(cteInformacaoNfOutross); 

			return CteInformacaoNfTransporteGrouped(
				cteInformacaoNfTransporte: cteInformacaoNfTransporte, 
				cteInformacaoNfOutros: cteInformacaoNfOutros, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cteInformacaoNfTransporteGrouped in cteInformacaoNfTransporteGroupedList) {
		//}		

		return cteInformacaoNfTransporteGroupedList;	
	}

	Future<CteInformacaoNfTransporte?> getObject(dynamic pk) async {
		return await (select(cteInformacaoNfTransportes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteInformacaoNfTransporte?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_informacao_nf_transporte WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteInformacaoNfTransporte;		 
	} 

	Future<CteInformacaoNfTransporteGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteInformacaoNfTransporteGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteInformacaoNfTransporte = object.cteInformacaoNfTransporte!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteInformacaoNfTransportes).insert(object.cteInformacaoNfTransporte!);
			object.cteInformacaoNfTransporte = object.cteInformacaoNfTransporte!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteInformacaoNfTransporteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteInformacaoNfTransportes).replace(object.cteInformacaoNfTransporte!);
		});	 
	} 

	Future<int> deleteObject(CteInformacaoNfTransporteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteInformacaoNfTransportes).delete(object.cteInformacaoNfTransporte!);
		});		
	}

	Future<void> insertChildren(CteInformacaoNfTransporteGrouped object) async {
	}
	
	Future<void> deleteChildren(CteInformacaoNfTransporteGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_informacao_nf_transporte").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}