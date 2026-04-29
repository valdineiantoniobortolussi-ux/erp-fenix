import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'funcao_dao.g.dart';

@DriftAccessor(tables: [
	Funcaos,
	PapelFuncaos,
])
class FuncaoDao extends DatabaseAccessor<AppDatabase> with _$FuncaoDaoMixin {
	final AppDatabase db;

	List<Funcao> funcaoList = []; 
	List<FuncaoGrouped> funcaoGroupedList = []; 

	FuncaoDao(this.db) : super(db);

	Future<List<Funcao>> getList() async {
		funcaoList = await select(funcaos).get();
		return funcaoList;
	}

	Future<List<Funcao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		funcaoList = await (select(funcaos)..where((t) => expression)).get();
		return funcaoList;	 
	}

	Future<List<FuncaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(funcaos)
			.join([]);

		if (field != null && field != '') { 
			final column = funcaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		funcaoGroupedList = await query.map((row) {
			final funcao = row.readTableOrNull(funcaos); 

			return FuncaoGrouped(
				funcao: funcao, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var funcaoGrouped in funcaoGroupedList) {
			funcaoGrouped.papelFuncaoGroupedList = [];
			final queryPapelFuncao = ' id_funcao = ${funcaoGrouped.funcao!.id}';
			expression = CustomExpression<bool>(queryPapelFuncao);
			final papelFuncaoList = await (select(papelFuncaos)..where((t) => expression)).get();
			for (var papelFuncao in papelFuncaoList) {
				PapelFuncaoGrouped papelFuncaoGrouped = PapelFuncaoGrouped(
					papelFuncao: papelFuncao,
				);
				funcaoGrouped.papelFuncaoGroupedList!.add(papelFuncaoGrouped);
			}

		}		

		return funcaoGroupedList;	
	}

	Future<Funcao?> getObject(dynamic pk) async {
		return await (select(funcaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Funcao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM funcao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Funcao;		 
	} 

	Future<FuncaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FuncaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.funcao = object.funcao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(funcaos).insert(object.funcao!);
			object.funcao = object.funcao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FuncaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(funcaos).replace(object.funcao!);
		});	 
	} 

	Future<int> deleteObject(FuncaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(funcaos).delete(object.funcao!);
		});		
	}

	Future<void> insertChildren(FuncaoGrouped object) async {
		for (var papelFuncaoGrouped in object.papelFuncaoGroupedList!) {
			papelFuncaoGrouped.papelFuncao = papelFuncaoGrouped.papelFuncao?.copyWith(
				id: const Value(null),
				idFuncao: Value(object.funcao!.id),
			);
			await into(papelFuncaos).insert(papelFuncaoGrouped.papelFuncao!);
		}
	}
	
	Future<void> deleteChildren(FuncaoGrouped object) async {
		await (delete(papelFuncaos)..where((t) => t.idFuncao.equals(object.funcao!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from funcao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}