import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_lancamento_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	FolhaLancamentoCabecalhos,
	FolhaLancamentoDetalhes,
	FolhaEventos,
	ViewPessoaColaboradors,
])
class FolhaLancamentoCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$FolhaLancamentoCabecalhoDaoMixin {
	final AppDatabase db;

	List<FolhaLancamentoCabecalho> folhaLancamentoCabecalhoList = []; 
	List<FolhaLancamentoCabecalhoGrouped> folhaLancamentoCabecalhoGroupedList = []; 

	FolhaLancamentoCabecalhoDao(this.db) : super(db);

	Future<List<FolhaLancamentoCabecalho>> getList() async {
		folhaLancamentoCabecalhoList = await select(folhaLancamentoCabecalhos).get();
		return folhaLancamentoCabecalhoList;
	}

	Future<List<FolhaLancamentoCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaLancamentoCabecalhoList = await (select(folhaLancamentoCabecalhos)..where((t) => expression)).get();
		return folhaLancamentoCabecalhoList;	 
	}

	Future<List<FolhaLancamentoCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaLancamentoCabecalhos)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(folhaLancamentoCabecalhos.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = folhaLancamentoCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaLancamentoCabecalhoGroupedList = await query.map((row) {
			final folhaLancamentoCabecalho = row.readTableOrNull(folhaLancamentoCabecalhos); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return FolhaLancamentoCabecalhoGrouped(
				folhaLancamentoCabecalho: folhaLancamentoCabecalho, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var folhaLancamentoCabecalhoGrouped in folhaLancamentoCabecalhoGroupedList) {
			folhaLancamentoCabecalhoGrouped.folhaLancamentoDetalheGroupedList = [];
			final queryFolhaLancamentoDetalhe = ' id_folha_lancamento_cabecalho = ${folhaLancamentoCabecalhoGrouped.folhaLancamentoCabecalho!.id}';
			expression = CustomExpression<bool>(queryFolhaLancamentoDetalhe);
			final folhaLancamentoDetalheList = await (select(folhaLancamentoDetalhes)..where((t) => expression)).get();
			for (var folhaLancamentoDetalhe in folhaLancamentoDetalheList) {
				FolhaLancamentoDetalheGrouped folhaLancamentoDetalheGrouped = FolhaLancamentoDetalheGrouped(
					folhaLancamentoDetalhe: folhaLancamentoDetalhe,
					folhaEvento: await (select(folhaEventos)..where((t) => t.id.equals(folhaLancamentoDetalhe.idFolhaEvento!))).getSingleOrNull(),
				);
				folhaLancamentoCabecalhoGrouped.folhaLancamentoDetalheGroupedList!.add(folhaLancamentoDetalheGrouped);
			}

		}		

		return folhaLancamentoCabecalhoGroupedList;	
	}

	Future<FolhaLancamentoCabecalho?> getObject(dynamic pk) async {
		return await (select(folhaLancamentoCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaLancamentoCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_lancamento_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaLancamentoCabecalho;		 
	} 

	Future<FolhaLancamentoCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaLancamentoCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaLancamentoCabecalho = object.folhaLancamentoCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaLancamentoCabecalhos).insert(object.folhaLancamentoCabecalho!);
			object.folhaLancamentoCabecalho = object.folhaLancamentoCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaLancamentoCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaLancamentoCabecalhos).replace(object.folhaLancamentoCabecalho!);
		});	 
	} 

	Future<int> deleteObject(FolhaLancamentoCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaLancamentoCabecalhos).delete(object.folhaLancamentoCabecalho!);
		});		
	}

	Future<void> insertChildren(FolhaLancamentoCabecalhoGrouped object) async {
		for (var folhaLancamentoDetalheGrouped in object.folhaLancamentoDetalheGroupedList!) {
			folhaLancamentoDetalheGrouped.folhaLancamentoDetalhe = folhaLancamentoDetalheGrouped.folhaLancamentoDetalhe?.copyWith(
				id: const Value(null),
				idFolhaLancamentoCabecalho: Value(object.folhaLancamentoCabecalho!.id),
			);
			await into(folhaLancamentoDetalhes).insert(folhaLancamentoDetalheGrouped.folhaLancamentoDetalhe!);
		}
	}
	
	Future<void> deleteChildren(FolhaLancamentoCabecalhoGrouped object) async {
		await (delete(folhaLancamentoDetalhes)..where((t) => t.idFolhaLancamentoCabecalho.equals(object.folhaLancamentoCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_lancamento_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}