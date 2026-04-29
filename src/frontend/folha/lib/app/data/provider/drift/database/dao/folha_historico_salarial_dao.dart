import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_historico_salarial_dao.g.dart';

@DriftAccessor(tables: [
	FolhaHistoricoSalarials,
	ViewPessoaColaboradors,
])
class FolhaHistoricoSalarialDao extends DatabaseAccessor<AppDatabase> with _$FolhaHistoricoSalarialDaoMixin {
	final AppDatabase db;

	List<FolhaHistoricoSalarial> folhaHistoricoSalarialList = []; 
	List<FolhaHistoricoSalarialGrouped> folhaHistoricoSalarialGroupedList = []; 

	FolhaHistoricoSalarialDao(this.db) : super(db);

	Future<List<FolhaHistoricoSalarial>> getList() async {
		folhaHistoricoSalarialList = await select(folhaHistoricoSalarials).get();
		return folhaHistoricoSalarialList;
	}

	Future<List<FolhaHistoricoSalarial>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaHistoricoSalarialList = await (select(folhaHistoricoSalarials)..where((t) => expression)).get();
		return folhaHistoricoSalarialList;	 
	}

	Future<List<FolhaHistoricoSalarialGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaHistoricoSalarials)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(folhaHistoricoSalarials.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = folhaHistoricoSalarials.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaHistoricoSalarialGroupedList = await query.map((row) {
			final folhaHistoricoSalarial = row.readTableOrNull(folhaHistoricoSalarials); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return FolhaHistoricoSalarialGrouped(
				folhaHistoricoSalarial: folhaHistoricoSalarial, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var folhaHistoricoSalarialGrouped in folhaHistoricoSalarialGroupedList) {
		//}		

		return folhaHistoricoSalarialGroupedList;	
	}

	Future<FolhaHistoricoSalarial?> getObject(dynamic pk) async {
		return await (select(folhaHistoricoSalarials)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaHistoricoSalarial?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_historico_salarial WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaHistoricoSalarial;		 
	} 

	Future<FolhaHistoricoSalarialGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaHistoricoSalarialGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaHistoricoSalarial = object.folhaHistoricoSalarial!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaHistoricoSalarials).insert(object.folhaHistoricoSalarial!);
			object.folhaHistoricoSalarial = object.folhaHistoricoSalarial!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaHistoricoSalarialGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaHistoricoSalarials).replace(object.folhaHistoricoSalarial!);
		});	 
	} 

	Future<int> deleteObject(FolhaHistoricoSalarialGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaHistoricoSalarials).delete(object.folhaHistoricoSalarial!);
		});		
	}

	Future<void> insertChildren(FolhaHistoricoSalarialGrouped object) async {
	}
	
	Future<void> deleteChildren(FolhaHistoricoSalarialGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_historico_salarial").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}