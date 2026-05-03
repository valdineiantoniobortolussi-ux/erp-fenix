import 'package:drift/drift.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';
import 'package:esocial/app/data/provider/drift/database/database_imports.dart';

part 'esocial_natureza_juridica_dao.g.dart';

@DriftAccessor(tables: [
	EsocialNaturezaJuridicas,
])
class EsocialNaturezaJuridicaDao extends DatabaseAccessor<AppDatabase> with _$EsocialNaturezaJuridicaDaoMixin {
	final AppDatabase db;

	List<EsocialNaturezaJuridica> esocialNaturezaJuridicaList = []; 
	List<EsocialNaturezaJuridicaGrouped> esocialNaturezaJuridicaGroupedList = []; 

	EsocialNaturezaJuridicaDao(this.db) : super(db);

	Future<List<EsocialNaturezaJuridica>> getList() async {
		esocialNaturezaJuridicaList = await select(esocialNaturezaJuridicas).get();
		return esocialNaturezaJuridicaList;
	}

	Future<List<EsocialNaturezaJuridica>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		esocialNaturezaJuridicaList = await (select(esocialNaturezaJuridicas)..where((t) => expression)).get();
		return esocialNaturezaJuridicaList;	 
	}

	Future<List<EsocialNaturezaJuridicaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(esocialNaturezaJuridicas)
			.join([]);

		if (field != null && field != '') { 
			final column = esocialNaturezaJuridicas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		esocialNaturezaJuridicaGroupedList = await query.map((row) {
			final esocialNaturezaJuridica = row.readTableOrNull(esocialNaturezaJuridicas); 

			return EsocialNaturezaJuridicaGrouped(
				esocialNaturezaJuridica: esocialNaturezaJuridica, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var esocialNaturezaJuridicaGrouped in esocialNaturezaJuridicaGroupedList) {
		//}		

		return esocialNaturezaJuridicaGroupedList;	
	}

	Future<EsocialNaturezaJuridica?> getObject(dynamic pk) async {
		return await (select(esocialNaturezaJuridicas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EsocialNaturezaJuridica?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM esocial_natureza_juridica WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EsocialNaturezaJuridica;		 
	} 

	Future<EsocialNaturezaJuridicaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EsocialNaturezaJuridicaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.esocialNaturezaJuridica = object.esocialNaturezaJuridica!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(esocialNaturezaJuridicas).insert(object.esocialNaturezaJuridica!);
			object.esocialNaturezaJuridica = object.esocialNaturezaJuridica!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EsocialNaturezaJuridicaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(esocialNaturezaJuridicas).replace(object.esocialNaturezaJuridica!);
		});	 
	} 

	Future<int> deleteObject(EsocialNaturezaJuridicaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(esocialNaturezaJuridicas).delete(object.esocialNaturezaJuridica!);
		});		
	}

	Future<void> insertChildren(EsocialNaturezaJuridicaGrouped object) async {
	}
	
	Future<void> deleteChildren(EsocialNaturezaJuridicaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from esocial_natureza_juridica").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}