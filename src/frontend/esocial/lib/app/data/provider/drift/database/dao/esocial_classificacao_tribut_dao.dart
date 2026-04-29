import 'package:drift/drift.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';
import 'package:esocial/app/data/provider/drift/database/database_imports.dart';

part 'esocial_classificacao_tribut_dao.g.dart';

@DriftAccessor(tables: [
	EsocialClassificacaoTributs,
])
class EsocialClassificacaoTributDao extends DatabaseAccessor<AppDatabase> with _$EsocialClassificacaoTributDaoMixin {
	final AppDatabase db;

	List<EsocialClassificacaoTribut> esocialClassificacaoTributList = []; 
	List<EsocialClassificacaoTributGrouped> esocialClassificacaoTributGroupedList = []; 

	EsocialClassificacaoTributDao(this.db) : super(db);

	Future<List<EsocialClassificacaoTribut>> getList() async {
		esocialClassificacaoTributList = await select(esocialClassificacaoTributs).get();
		return esocialClassificacaoTributList;
	}

	Future<List<EsocialClassificacaoTribut>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		esocialClassificacaoTributList = await (select(esocialClassificacaoTributs)..where((t) => expression)).get();
		return esocialClassificacaoTributList;	 
	}

	Future<List<EsocialClassificacaoTributGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(esocialClassificacaoTributs)
			.join([]);

		if (field != null && field != '') { 
			final column = esocialClassificacaoTributs.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		esocialClassificacaoTributGroupedList = await query.map((row) {
			final esocialClassificacaoTribut = row.readTableOrNull(esocialClassificacaoTributs); 

			return EsocialClassificacaoTributGrouped(
				esocialClassificacaoTribut: esocialClassificacaoTribut, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var esocialClassificacaoTributGrouped in esocialClassificacaoTributGroupedList) {
		//}		

		return esocialClassificacaoTributGroupedList;	
	}

	Future<EsocialClassificacaoTribut?> getObject(dynamic pk) async {
		return await (select(esocialClassificacaoTributs)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EsocialClassificacaoTribut?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM esocial_classificacao_tribut WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EsocialClassificacaoTribut;		 
	} 

	Future<EsocialClassificacaoTributGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EsocialClassificacaoTributGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.esocialClassificacaoTribut = object.esocialClassificacaoTribut!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(esocialClassificacaoTributs).insert(object.esocialClassificacaoTribut!);
			object.esocialClassificacaoTribut = object.esocialClassificacaoTribut!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EsocialClassificacaoTributGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(esocialClassificacaoTributs).replace(object.esocialClassificacaoTribut!);
		});	 
	} 

	Future<int> deleteObject(EsocialClassificacaoTributGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(esocialClassificacaoTributs).delete(object.esocialClassificacaoTribut!);
		});		
	}

	Future<void> insertChildren(EsocialClassificacaoTributGrouped object) async {
	}
	
	Future<void> deleteChildren(EsocialClassificacaoTributGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from esocial_classificacao_tribut").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}