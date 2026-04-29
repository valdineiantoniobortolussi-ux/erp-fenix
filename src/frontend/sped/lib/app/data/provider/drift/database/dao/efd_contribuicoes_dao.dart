import 'package:drift/drift.dart';
import 'package:sped/app/data/provider/drift/database/database.dart';
import 'package:sped/app/data/provider/drift/database/database_imports.dart';

part 'efd_contribuicoes_dao.g.dart';

@DriftAccessor(tables: [
	EfdContribuicoess,
])
class EfdContribuicoesDao extends DatabaseAccessor<AppDatabase> with _$EfdContribuicoesDaoMixin {
	final AppDatabase db;

	List<EfdContribuicoes> efdContribuicoesList = []; 
	List<EfdContribuicoesGrouped> efdContribuicoesGroupedList = []; 

	EfdContribuicoesDao(this.db) : super(db);

	Future<List<EfdContribuicoes>> getList() async {
		efdContribuicoesList = await select(efdContribuicoess).get();
		return efdContribuicoesList;
	}

	Future<List<EfdContribuicoes>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		efdContribuicoesList = await (select(efdContribuicoess)..where((t) => expression)).get();
		return efdContribuicoesList;	 
	}

	Future<List<EfdContribuicoesGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(efdContribuicoess)
			.join([]);

		if (field != null && field != '') { 
			final column = efdContribuicoess.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		efdContribuicoesGroupedList = await query.map((row) {
			final efdContribuicoes = row.readTableOrNull(efdContribuicoess); 

			return EfdContribuicoesGrouped(
				efdContribuicoes: efdContribuicoes, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var efdContribuicoesGrouped in efdContribuicoesGroupedList) {
		//}		

		return efdContribuicoesGroupedList;	
	}

	Future<EfdContribuicoes?> getObject(dynamic pk) async {
		return await (select(efdContribuicoess)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EfdContribuicoes?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM efd_contribuicoes WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EfdContribuicoes;		 
	} 

	Future<EfdContribuicoesGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EfdContribuicoesGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.efdContribuicoes = object.efdContribuicoes!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(efdContribuicoess).insert(object.efdContribuicoes!);
			object.efdContribuicoes = object.efdContribuicoes!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EfdContribuicoesGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(efdContribuicoess).replace(object.efdContribuicoes!);
		});	 
	} 

	Future<int> deleteObject(EfdContribuicoesGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(efdContribuicoess).delete(object.efdContribuicoes!);
		});		
	}

	Future<void> insertChildren(EfdContribuicoesGrouped object) async {
	}
	
	Future<void> deleteChildren(EfdContribuicoesGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from efd_contribuicoes").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}