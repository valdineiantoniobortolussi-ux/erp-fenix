import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';

part 'patrim_estado_conservacao_dao.g.dart';

@DriftAccessor(tables: [
	PatrimEstadoConservacaos,
])
class PatrimEstadoConservacaoDao extends DatabaseAccessor<AppDatabase> with _$PatrimEstadoConservacaoDaoMixin {
	final AppDatabase db;

	List<PatrimEstadoConservacao> patrimEstadoConservacaoList = []; 
	List<PatrimEstadoConservacaoGrouped> patrimEstadoConservacaoGroupedList = []; 

	PatrimEstadoConservacaoDao(this.db) : super(db);

	Future<List<PatrimEstadoConservacao>> getList() async {
		patrimEstadoConservacaoList = await select(patrimEstadoConservacaos).get();
		return patrimEstadoConservacaoList;
	}

	Future<List<PatrimEstadoConservacao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		patrimEstadoConservacaoList = await (select(patrimEstadoConservacaos)..where((t) => expression)).get();
		return patrimEstadoConservacaoList;	 
	}

	Future<List<PatrimEstadoConservacaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(patrimEstadoConservacaos)
			.join([]);

		if (field != null && field != '') { 
			final column = patrimEstadoConservacaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		patrimEstadoConservacaoGroupedList = await query.map((row) {
			final patrimEstadoConservacao = row.readTableOrNull(patrimEstadoConservacaos); 

			return PatrimEstadoConservacaoGrouped(
				patrimEstadoConservacao: patrimEstadoConservacao, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var patrimEstadoConservacaoGrouped in patrimEstadoConservacaoGroupedList) {
		//}		

		return patrimEstadoConservacaoGroupedList;	
	}

	Future<PatrimEstadoConservacao?> getObject(dynamic pk) async {
		return await (select(patrimEstadoConservacaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PatrimEstadoConservacao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM patrim_estado_conservacao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PatrimEstadoConservacao;		 
	} 

	Future<PatrimEstadoConservacaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PatrimEstadoConservacaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.patrimEstadoConservacao = object.patrimEstadoConservacao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(patrimEstadoConservacaos).insert(object.patrimEstadoConservacao!);
			object.patrimEstadoConservacao = object.patrimEstadoConservacao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PatrimEstadoConservacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(patrimEstadoConservacaos).replace(object.patrimEstadoConservacao!);
		});	 
	} 

	Future<int> deleteObject(PatrimEstadoConservacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(patrimEstadoConservacaos).delete(object.patrimEstadoConservacao!);
		});		
	}

	Future<void> insertChildren(PatrimEstadoConservacaoGrouped object) async {
	}
	
	Future<void> deleteChildren(PatrimEstadoConservacaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from patrim_estado_conservacao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}