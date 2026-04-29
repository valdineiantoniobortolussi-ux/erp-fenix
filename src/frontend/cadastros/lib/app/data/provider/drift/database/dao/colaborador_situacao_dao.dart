import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'colaborador_situacao_dao.g.dart';

@DriftAccessor(tables: [
	ColaboradorSituacaos,
])
class ColaboradorSituacaoDao extends DatabaseAccessor<AppDatabase> with _$ColaboradorSituacaoDaoMixin {
	final AppDatabase db;

	List<ColaboradorSituacao> colaboradorSituacaoList = []; 
	List<ColaboradorSituacaoGrouped> colaboradorSituacaoGroupedList = []; 

	ColaboradorSituacaoDao(this.db) : super(db);

	Future<List<ColaboradorSituacao>> getList() async {
		colaboradorSituacaoList = await select(colaboradorSituacaos).get();
		return colaboradorSituacaoList;
	}

	Future<List<ColaboradorSituacao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		colaboradorSituacaoList = await (select(colaboradorSituacaos)..where((t) => expression)).get();
		return colaboradorSituacaoList;	 
	}

	Future<List<ColaboradorSituacaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(colaboradorSituacaos)
			.join([]);

		if (field != null && field != '') { 
			final column = colaboradorSituacaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		colaboradorSituacaoGroupedList = await query.map((row) {
			final colaboradorSituacao = row.readTableOrNull(colaboradorSituacaos); 

			return ColaboradorSituacaoGrouped(
				colaboradorSituacao: colaboradorSituacao, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var colaboradorSituacaoGrouped in colaboradorSituacaoGroupedList) {
		//}		

		return colaboradorSituacaoGroupedList;	
	}

	Future<ColaboradorSituacao?> getObject(dynamic pk) async {
		return await (select(colaboradorSituacaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ColaboradorSituacao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM colaborador_situacao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ColaboradorSituacao;		 
	} 

	Future<ColaboradorSituacaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ColaboradorSituacaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.colaboradorSituacao = object.colaboradorSituacao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(colaboradorSituacaos).insert(object.colaboradorSituacao!);
			object.colaboradorSituacao = object.colaboradorSituacao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ColaboradorSituacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(colaboradorSituacaos).replace(object.colaboradorSituacao!);
		});	 
	} 

	Future<int> deleteObject(ColaboradorSituacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(colaboradorSituacaos).delete(object.colaboradorSituacao!);
		});		
	}

	Future<void> insertChildren(ColaboradorSituacaoGrouped object) async {
	}
	
	Future<void> deleteChildren(ColaboradorSituacaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from colaborador_situacao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}