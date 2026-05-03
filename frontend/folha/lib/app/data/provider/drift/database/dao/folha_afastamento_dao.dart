import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_afastamento_dao.g.dart';

@DriftAccessor(tables: [
	FolhaAfastamentos,
	ViewPessoaColaboradors,
	FolhaTipoAfastamentos,
])
class FolhaAfastamentoDao extends DatabaseAccessor<AppDatabase> with _$FolhaAfastamentoDaoMixin {
	final AppDatabase db;

	List<FolhaAfastamento> folhaAfastamentoList = []; 
	List<FolhaAfastamentoGrouped> folhaAfastamentoGroupedList = []; 

	FolhaAfastamentoDao(this.db) : super(db);

	Future<List<FolhaAfastamento>> getList() async {
		folhaAfastamentoList = await select(folhaAfastamentos).get();
		return folhaAfastamentoList;
	}

	Future<List<FolhaAfastamento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaAfastamentoList = await (select(folhaAfastamentos)..where((t) => expression)).get();
		return folhaAfastamentoList;	 
	}

	Future<List<FolhaAfastamentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaAfastamentos)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(folhaAfastamentos.idColaborador)), 
			]).join([ 
				leftOuterJoin(folhaTipoAfastamentos, folhaTipoAfastamentos.id.equalsExp(folhaAfastamentos.idFolhaTipoAfastamento)), 
			]);

		if (field != null && field != '') { 
			final column = folhaAfastamentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaAfastamentoGroupedList = await query.map((row) {
			final folhaAfastamento = row.readTableOrNull(folhaAfastamentos); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 
			final folhaTipoAfastamento = row.readTableOrNull(folhaTipoAfastamentos); 

			return FolhaAfastamentoGrouped(
				folhaAfastamento: folhaAfastamento, 
				viewPessoaColaborador: viewPessoaColaborador, 
				folhaTipoAfastamento: folhaTipoAfastamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var folhaAfastamentoGrouped in folhaAfastamentoGroupedList) {
		//}		

		return folhaAfastamentoGroupedList;	
	}

	Future<FolhaAfastamento?> getObject(dynamic pk) async {
		return await (select(folhaAfastamentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaAfastamento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_afastamento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaAfastamento;		 
	} 

	Future<FolhaAfastamentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaAfastamentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaAfastamento = object.folhaAfastamento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaAfastamentos).insert(object.folhaAfastamento!);
			object.folhaAfastamento = object.folhaAfastamento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaAfastamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaAfastamentos).replace(object.folhaAfastamento!);
		});	 
	} 

	Future<int> deleteObject(FolhaAfastamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaAfastamentos).delete(object.folhaAfastamento!);
		});		
	}

	Future<void> insertChildren(FolhaAfastamentoGrouped object) async {
	}
	
	Future<void> deleteChildren(FolhaAfastamentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_afastamento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}