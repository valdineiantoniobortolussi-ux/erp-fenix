import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';

part 'patrim_taxa_depreciacao_dao.g.dart';

@DriftAccessor(tables: [
	PatrimTaxaDepreciacaos,
])
class PatrimTaxaDepreciacaoDao extends DatabaseAccessor<AppDatabase> with _$PatrimTaxaDepreciacaoDaoMixin {
	final AppDatabase db;

	List<PatrimTaxaDepreciacao> patrimTaxaDepreciacaoList = []; 
	List<PatrimTaxaDepreciacaoGrouped> patrimTaxaDepreciacaoGroupedList = []; 

	PatrimTaxaDepreciacaoDao(this.db) : super(db);

	Future<List<PatrimTaxaDepreciacao>> getList() async {
		patrimTaxaDepreciacaoList = await select(patrimTaxaDepreciacaos).get();
		return patrimTaxaDepreciacaoList;
	}

	Future<List<PatrimTaxaDepreciacao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		patrimTaxaDepreciacaoList = await (select(patrimTaxaDepreciacaos)..where((t) => expression)).get();
		return patrimTaxaDepreciacaoList;	 
	}

	Future<List<PatrimTaxaDepreciacaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(patrimTaxaDepreciacaos)
			.join([]);

		if (field != null && field != '') { 
			final column = patrimTaxaDepreciacaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		patrimTaxaDepreciacaoGroupedList = await query.map((row) {
			final patrimTaxaDepreciacao = row.readTableOrNull(patrimTaxaDepreciacaos); 

			return PatrimTaxaDepreciacaoGrouped(
				patrimTaxaDepreciacao: patrimTaxaDepreciacao, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var patrimTaxaDepreciacaoGrouped in patrimTaxaDepreciacaoGroupedList) {
		//}		

		return patrimTaxaDepreciacaoGroupedList;	
	}

	Future<PatrimTaxaDepreciacao?> getObject(dynamic pk) async {
		return await (select(patrimTaxaDepreciacaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PatrimTaxaDepreciacao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM patrim_taxa_depreciacao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PatrimTaxaDepreciacao;		 
	} 

	Future<PatrimTaxaDepreciacaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PatrimTaxaDepreciacaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.patrimTaxaDepreciacao = object.patrimTaxaDepreciacao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(patrimTaxaDepreciacaos).insert(object.patrimTaxaDepreciacao!);
			object.patrimTaxaDepreciacao = object.patrimTaxaDepreciacao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PatrimTaxaDepreciacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(patrimTaxaDepreciacaos).replace(object.patrimTaxaDepreciacao!);
		});	 
	} 

	Future<int> deleteObject(PatrimTaxaDepreciacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(patrimTaxaDepreciacaos).delete(object.patrimTaxaDepreciacao!);
		});		
	}

	Future<void> insertChildren(PatrimTaxaDepreciacaoGrouped object) async {
	}
	
	Future<void> deleteChildren(PatrimTaxaDepreciacaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from patrim_taxa_depreciacao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}