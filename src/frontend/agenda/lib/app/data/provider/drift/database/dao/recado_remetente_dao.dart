import 'package:drift/drift.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';
import 'package:agenda/app/data/provider/drift/database/database_imports.dart';

part 'recado_remetente_dao.g.dart';

@DriftAccessor(tables: [
	RecadoRemetentes,
	RecadoDestinatarios,
	ViewPessoaColaboradors,
	ViewPessoaColaboradors,
])
class RecadoRemetenteDao extends DatabaseAccessor<AppDatabase> with _$RecadoRemetenteDaoMixin {
	final AppDatabase db;

	List<RecadoRemetente> recadoRemetenteList = []; 
	List<RecadoRemetenteGrouped> recadoRemetenteGroupedList = []; 

	RecadoRemetenteDao(this.db) : super(db);

	Future<List<RecadoRemetente>> getList() async {
		recadoRemetenteList = await select(recadoRemetentes).get();
		return recadoRemetenteList;
	}

	Future<List<RecadoRemetente>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		recadoRemetenteList = await (select(recadoRemetentes)..where((t) => expression)).get();
		return recadoRemetenteList;	 
	}

	Future<List<RecadoRemetenteGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(recadoRemetentes)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(recadoRemetentes.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = recadoRemetentes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		recadoRemetenteGroupedList = await query.map((row) {
			final recadoRemetente = row.readTableOrNull(recadoRemetentes); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return RecadoRemetenteGrouped(
				recadoRemetente: recadoRemetente, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var recadoRemetenteGrouped in recadoRemetenteGroupedList) {
			recadoRemetenteGrouped.recadoDestinatarioGroupedList = [];
			final queryRecadoDestinatario = ' id_recado_remetente = ${recadoRemetenteGrouped.recadoRemetente!.id}';
			expression = CustomExpression<bool>(queryRecadoDestinatario);
			final recadoDestinatarioList = await (select(recadoDestinatarios)..where((t) => expression)).get();
			for (var recadoDestinatario in recadoDestinatarioList) {
				RecadoDestinatarioGrouped recadoDestinatarioGrouped = RecadoDestinatarioGrouped(
					recadoDestinatario: recadoDestinatario,
					viewPessoaColaborador: await (select(viewPessoaColaboradors)..where((t) => t.id.equals(recadoDestinatario.idColaborador!))).getSingleOrNull(),
				);
				recadoRemetenteGrouped.recadoDestinatarioGroupedList!.add(recadoDestinatarioGrouped);
			}

		}		

		return recadoRemetenteGroupedList;	
	}

	Future<RecadoRemetente?> getObject(dynamic pk) async {
		return await (select(recadoRemetentes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<RecadoRemetente?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM recado_remetente WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as RecadoRemetente;		 
	} 

	Future<RecadoRemetenteGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(RecadoRemetenteGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.recadoRemetente = object.recadoRemetente!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(recadoRemetentes).insert(object.recadoRemetente!);
			object.recadoRemetente = object.recadoRemetente!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(RecadoRemetenteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(recadoRemetentes).replace(object.recadoRemetente!);
		});	 
	} 

	Future<int> deleteObject(RecadoRemetenteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(recadoRemetentes).delete(object.recadoRemetente!);
		});		
	}

	Future<void> insertChildren(RecadoRemetenteGrouped object) async {
		for (var recadoDestinatarioGrouped in object.recadoDestinatarioGroupedList!) {
			recadoDestinatarioGrouped.recadoDestinatario = recadoDestinatarioGrouped.recadoDestinatario?.copyWith(
				id: const Value(null),
				idRecadoRemetente: Value(object.recadoRemetente!.id),
			);
			await into(recadoDestinatarios).insert(recadoDestinatarioGrouped.recadoDestinatario!);
		}
	}
	
	Future<void> deleteChildren(RecadoRemetenteGrouped object) async {
		await (delete(recadoDestinatarios)..where((t) => t.idRecadoRemetente.equals(object.recadoRemetente!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from recado_remetente").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}