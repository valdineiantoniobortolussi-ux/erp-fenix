import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';

part 'patrim_indice_atualizacao_dao.g.dart';

@DriftAccessor(tables: [
	PatrimIndiceAtualizacaos,
])
class PatrimIndiceAtualizacaoDao extends DatabaseAccessor<AppDatabase> with _$PatrimIndiceAtualizacaoDaoMixin {
	final AppDatabase db;

	List<PatrimIndiceAtualizacao> patrimIndiceAtualizacaoList = []; 
	List<PatrimIndiceAtualizacaoGrouped> patrimIndiceAtualizacaoGroupedList = []; 

	PatrimIndiceAtualizacaoDao(this.db) : super(db);

	Future<List<PatrimIndiceAtualizacao>> getList() async {
		patrimIndiceAtualizacaoList = await select(patrimIndiceAtualizacaos).get();
		return patrimIndiceAtualizacaoList;
	}

	Future<List<PatrimIndiceAtualizacao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		patrimIndiceAtualizacaoList = await (select(patrimIndiceAtualizacaos)..where((t) => expression)).get();
		return patrimIndiceAtualizacaoList;	 
	}

	Future<List<PatrimIndiceAtualizacaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(patrimIndiceAtualizacaos)
			.join([]);

		if (field != null && field != '') { 
			final column = patrimIndiceAtualizacaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		patrimIndiceAtualizacaoGroupedList = await query.map((row) {
			final patrimIndiceAtualizacao = row.readTableOrNull(patrimIndiceAtualizacaos); 

			return PatrimIndiceAtualizacaoGrouped(
				patrimIndiceAtualizacao: patrimIndiceAtualizacao, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var patrimIndiceAtualizacaoGrouped in patrimIndiceAtualizacaoGroupedList) {
		//}		

		return patrimIndiceAtualizacaoGroupedList;	
	}

	Future<PatrimIndiceAtualizacao?> getObject(dynamic pk) async {
		return await (select(patrimIndiceAtualizacaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PatrimIndiceAtualizacao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM patrim_indice_atualizacao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PatrimIndiceAtualizacao;		 
	} 

	Future<PatrimIndiceAtualizacaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PatrimIndiceAtualizacaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.patrimIndiceAtualizacao = object.patrimIndiceAtualizacao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(patrimIndiceAtualizacaos).insert(object.patrimIndiceAtualizacao!);
			object.patrimIndiceAtualizacao = object.patrimIndiceAtualizacao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PatrimIndiceAtualizacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(patrimIndiceAtualizacaos).replace(object.patrimIndiceAtualizacao!);
		});	 
	} 

	Future<int> deleteObject(PatrimIndiceAtualizacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(patrimIndiceAtualizacaos).delete(object.patrimIndiceAtualizacao!);
		});		
	}

	Future<void> insertChildren(PatrimIndiceAtualizacaoGrouped object) async {
	}
	
	Future<void> deleteChildren(PatrimIndiceAtualizacaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from patrim_indice_atualizacao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}