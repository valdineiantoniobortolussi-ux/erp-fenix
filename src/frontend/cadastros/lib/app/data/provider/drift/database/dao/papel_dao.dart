import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'papel_dao.g.dart';

@DriftAccessor(tables: [
	Papels,
	PapelFuncaos,
	Usuarios,
])
class PapelDao extends DatabaseAccessor<AppDatabase> with _$PapelDaoMixin {
	final AppDatabase db;

	List<Papel> papelList = []; 
	List<PapelGrouped> papelGroupedList = []; 

	PapelDao(this.db) : super(db);

	Future<List<Papel>> getList() async {
		papelList = await select(papels).get();
		return papelList;
	}

	Future<List<Papel>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		papelList = await (select(papels)..where((t) => expression)).get();
		return papelList;	 
	}

	Future<List<PapelGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(papels)
			.join([]);

		if (field != null && field != '') { 
			final column = papels.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		papelGroupedList = await query.map((row) {
			final papel = row.readTableOrNull(papels); 

			return PapelGrouped(
				papel: papel, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var papelGrouped in papelGroupedList) {
			papelGrouped.papelFuncaoGroupedList = [];
			final queryPapelFuncao = ' id_papel = ${papelGrouped.papel!.id}';
			expression = CustomExpression<bool>(queryPapelFuncao);
			final papelFuncaoList = await (select(papelFuncaos)..where((t) => expression)).get();
			for (var papelFuncao in papelFuncaoList) {
				PapelFuncaoGrouped papelFuncaoGrouped = PapelFuncaoGrouped(
					papelFuncao: papelFuncao,
				);
				papelGrouped.papelFuncaoGroupedList!.add(papelFuncaoGrouped);
			}

			papelGrouped.usuarioGroupedList = [];
			final queryUsuario = ' id_papel = ${papelGrouped.papel!.id}';
			expression = CustomExpression<bool>(queryUsuario);
			final usuarioList = await (select(usuarios)..where((t) => expression)).get();
			for (var usuario in usuarioList) {
				UsuarioGrouped usuarioGrouped = UsuarioGrouped(
					usuario: usuario,
				);
				papelGrouped.usuarioGroupedList!.add(usuarioGrouped);
			}

		}		

		return papelGroupedList;	
	}

	Future<Papel?> getObject(dynamic pk) async {
		return await (select(papels)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Papel?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM papel WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Papel;		 
	} 

	Future<PapelGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PapelGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.papel = object.papel!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(papels).insert(object.papel!);
			object.papel = object.papel!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PapelGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(papels).replace(object.papel!);
		});	 
	} 

	Future<int> deleteObject(PapelGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(papels).delete(object.papel!);
		});		
	}

	Future<void> insertChildren(PapelGrouped object) async {
		for (var papelFuncaoGrouped in object.papelFuncaoGroupedList!) {
			papelFuncaoGrouped.papelFuncao = papelFuncaoGrouped.papelFuncao?.copyWith(
				id: const Value(null),
				idPapel: Value(object.papel!.id),
			);
			await into(papelFuncaos).insert(papelFuncaoGrouped.papelFuncao!);
		}
		for (var usuarioGrouped in object.usuarioGroupedList!) {
			usuarioGrouped.usuario = usuarioGrouped.usuario?.copyWith(
				id: const Value(null),
				idPapel: Value(object.papel!.id),
			);
			await into(usuarios).insert(usuarioGrouped.usuario!);
		}
	}
	
	Future<void> deleteChildren(PapelGrouped object) async {
		await (delete(papelFuncaos)..where((t) => t.idPapel.equals(object.papel!.id!))).go();
		await (delete(usuarios)..where((t) => t.idPapel.equals(object.papel!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from papel").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}