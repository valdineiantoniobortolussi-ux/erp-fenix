import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_plano_saude_dao.g.dart';

@DriftAccessor(tables: [
	FolhaPlanoSaudes,
	ViewPessoaColaboradors,
	OperadoraPlanoSaudes,
])
class FolhaPlanoSaudeDao extends DatabaseAccessor<AppDatabase> with _$FolhaPlanoSaudeDaoMixin {
	final AppDatabase db;

	List<FolhaPlanoSaude> folhaPlanoSaudeList = []; 
	List<FolhaPlanoSaudeGrouped> folhaPlanoSaudeGroupedList = []; 

	FolhaPlanoSaudeDao(this.db) : super(db);

	Future<List<FolhaPlanoSaude>> getList() async {
		folhaPlanoSaudeList = await select(folhaPlanoSaudes).get();
		return folhaPlanoSaudeList;
	}

	Future<List<FolhaPlanoSaude>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaPlanoSaudeList = await (select(folhaPlanoSaudes)..where((t) => expression)).get();
		return folhaPlanoSaudeList;	 
	}

	Future<List<FolhaPlanoSaudeGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaPlanoSaudes)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(folhaPlanoSaudes.idColaborador)), 
			]).join([ 
				leftOuterJoin(operadoraPlanoSaudes, operadoraPlanoSaudes.id.equalsExp(folhaPlanoSaudes.idOperadoraPlanoSaude)), 
			]);

		if (field != null && field != '') { 
			final column = folhaPlanoSaudes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaPlanoSaudeGroupedList = await query.map((row) {
			final folhaPlanoSaude = row.readTableOrNull(folhaPlanoSaudes); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 
			final operadoraPlanoSaude = row.readTableOrNull(operadoraPlanoSaudes); 

			return FolhaPlanoSaudeGrouped(
				folhaPlanoSaude: folhaPlanoSaude, 
				viewPessoaColaborador: viewPessoaColaborador, 
				operadoraPlanoSaude: operadoraPlanoSaude, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var folhaPlanoSaudeGrouped in folhaPlanoSaudeGroupedList) {
		//}		

		return folhaPlanoSaudeGroupedList;	
	}

	Future<FolhaPlanoSaude?> getObject(dynamic pk) async {
		return await (select(folhaPlanoSaudes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaPlanoSaude?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_plano_saude WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaPlanoSaude;		 
	} 

	Future<FolhaPlanoSaudeGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaPlanoSaudeGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaPlanoSaude = object.folhaPlanoSaude!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaPlanoSaudes).insert(object.folhaPlanoSaude!);
			object.folhaPlanoSaude = object.folhaPlanoSaude!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaPlanoSaudeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaPlanoSaudes).replace(object.folhaPlanoSaude!);
		});	 
	} 

	Future<int> deleteObject(FolhaPlanoSaudeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaPlanoSaudes).delete(object.folhaPlanoSaude!);
		});		
	}

	Future<void> insertChildren(FolhaPlanoSaudeGrouped object) async {
	}
	
	Future<void> deleteChildren(FolhaPlanoSaudeGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_plano_saude").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}