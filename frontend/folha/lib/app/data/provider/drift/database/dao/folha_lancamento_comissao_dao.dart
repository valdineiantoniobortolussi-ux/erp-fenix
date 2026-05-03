import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_lancamento_comissao_dao.g.dart';

@DriftAccessor(tables: [
	FolhaLancamentoComissaos,
	ViewPessoaColaboradors,
])
class FolhaLancamentoComissaoDao extends DatabaseAccessor<AppDatabase> with _$FolhaLancamentoComissaoDaoMixin {
	final AppDatabase db;

	List<FolhaLancamentoComissao> folhaLancamentoComissaoList = []; 
	List<FolhaLancamentoComissaoGrouped> folhaLancamentoComissaoGroupedList = []; 

	FolhaLancamentoComissaoDao(this.db) : super(db);

	Future<List<FolhaLancamentoComissao>> getList() async {
		folhaLancamentoComissaoList = await select(folhaLancamentoComissaos).get();
		return folhaLancamentoComissaoList;
	}

	Future<List<FolhaLancamentoComissao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaLancamentoComissaoList = await (select(folhaLancamentoComissaos)..where((t) => expression)).get();
		return folhaLancamentoComissaoList;	 
	}

	Future<List<FolhaLancamentoComissaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaLancamentoComissaos)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(folhaLancamentoComissaos.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = folhaLancamentoComissaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaLancamentoComissaoGroupedList = await query.map((row) {
			final folhaLancamentoComissao = row.readTableOrNull(folhaLancamentoComissaos); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return FolhaLancamentoComissaoGrouped(
				folhaLancamentoComissao: folhaLancamentoComissao, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var folhaLancamentoComissaoGrouped in folhaLancamentoComissaoGroupedList) {
		//}		

		return folhaLancamentoComissaoGroupedList;	
	}

	Future<FolhaLancamentoComissao?> getObject(dynamic pk) async {
		return await (select(folhaLancamentoComissaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaLancamentoComissao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_lancamento_comissao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaLancamentoComissao;		 
	} 

	Future<FolhaLancamentoComissaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaLancamentoComissaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaLancamentoComissao = object.folhaLancamentoComissao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaLancamentoComissaos).insert(object.folhaLancamentoComissao!);
			object.folhaLancamentoComissao = object.folhaLancamentoComissao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaLancamentoComissaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaLancamentoComissaos).replace(object.folhaLancamentoComissao!);
		});	 
	} 

	Future<int> deleteObject(FolhaLancamentoComissaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaLancamentoComissaos).delete(object.folhaLancamentoComissao!);
		});		
	}

	Future<void> insertChildren(FolhaLancamentoComissaoGrouped object) async {
	}
	
	Future<void> deleteChildren(FolhaLancamentoComissaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_lancamento_comissao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}