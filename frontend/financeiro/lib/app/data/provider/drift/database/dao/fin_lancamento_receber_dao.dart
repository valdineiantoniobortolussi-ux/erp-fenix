import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'fin_lancamento_receber_dao.g.dart';

@DriftAccessor(tables: [
	FinLancamentoRecebers,
	FinParcelaRecebers,
	FinStatusParcelas,
	FinTipoRecebimentos,
	FinDocumentoOrigems,
	BancoContaCaixas,
	FinNaturezaFinanceiras,
	ViewPessoaClientes,
])
class FinLancamentoReceberDao extends DatabaseAccessor<AppDatabase> with _$FinLancamentoReceberDaoMixin {
	final AppDatabase db;

	List<FinLancamentoReceber> finLancamentoReceberList = []; 
	List<FinLancamentoReceberGrouped> finLancamentoReceberGroupedList = []; 

	FinLancamentoReceberDao(this.db) : super(db);

	Future<List<FinLancamentoReceber>> getList() async {
		finLancamentoReceberList = await select(finLancamentoRecebers).get();
		return finLancamentoReceberList;
	}

	Future<List<FinLancamentoReceber>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		finLancamentoReceberList = await (select(finLancamentoRecebers)..where((t) => expression)).get();
		return finLancamentoReceberList;	 
	}

	Future<List<FinLancamentoReceberGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(finLancamentoRecebers)
			.join([ 
				leftOuterJoin(finDocumentoOrigems, finDocumentoOrigems.id.equalsExp(finLancamentoRecebers.idFinDocumentoOrigem)), 
			]).join([ 
				leftOuterJoin(bancoContaCaixas, bancoContaCaixas.id.equalsExp(finLancamentoRecebers.idBancoContaCaixa)), 
			]).join([ 
				leftOuterJoin(finNaturezaFinanceiras, finNaturezaFinanceiras.id.equalsExp(finLancamentoRecebers.idFinNaturezaFinanceira)), 
			]).join([ 
				leftOuterJoin(viewPessoaClientes, viewPessoaClientes.id.equalsExp(finLancamentoRecebers.idCliente)), 
			]);

		if (field != null && field != '') { 
			final column = finLancamentoRecebers.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		finLancamentoReceberGroupedList = await query.map((row) {
			final finLancamentoReceber = row.readTableOrNull(finLancamentoRecebers); 
			final finDocumentoOrigem = row.readTableOrNull(finDocumentoOrigems); 
			final bancoContaCaixa = row.readTableOrNull(bancoContaCaixas); 
			final finNaturezaFinanceira = row.readTableOrNull(finNaturezaFinanceiras); 
			final viewPessoaCliente = row.readTableOrNull(viewPessoaClientes); 

			return FinLancamentoReceberGrouped(
				finLancamentoReceber: finLancamentoReceber, 
				finDocumentoOrigem: finDocumentoOrigem, 
				bancoContaCaixa: bancoContaCaixa, 
				finNaturezaFinanceira: finNaturezaFinanceira, 
				viewPessoaCliente: viewPessoaCliente, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var finLancamentoReceberGrouped in finLancamentoReceberGroupedList) {
			finLancamentoReceberGrouped.finParcelaReceberGroupedList = [];
			final queryFinParcelaReceber = ' id_fin_lancamento_receber = ${finLancamentoReceberGrouped.finLancamentoReceber!.id}';
			expression = CustomExpression<bool>(queryFinParcelaReceber);
			final finParcelaReceberList = await (select(finParcelaRecebers)..where((t) => expression)).get();
			for (var finParcelaReceber in finParcelaReceberList) {
				FinParcelaReceberGrouped finParcelaReceberGrouped = FinParcelaReceberGrouped(
					finParcelaReceber: finParcelaReceber,
					finStatusParcela: await (select(finStatusParcelas)..where((t) => t.id.equals(finParcelaReceber.idFinStatusParcela!))).getSingleOrNull(),
					finTipoRecebimento: await (select(finTipoRecebimentos)..where((t) => t.id.equals(finParcelaReceber.idFinTipoRecebimento!))).getSingleOrNull(),
				);
				finLancamentoReceberGrouped.finParcelaReceberGroupedList!.add(finParcelaReceberGrouped);
			}

		}		

		return finLancamentoReceberGroupedList;	
	}

	Future<FinLancamentoReceber?> getObject(dynamic pk) async {
		return await (select(finLancamentoRecebers)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FinLancamentoReceber?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fin_lancamento_receber WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FinLancamentoReceber;		 
	} 

	Future<FinLancamentoReceberGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FinLancamentoReceberGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.finLancamentoReceber = object.finLancamentoReceber!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(finLancamentoRecebers).insert(object.finLancamentoReceber!);
			object.finLancamentoReceber = object.finLancamentoReceber!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FinLancamentoReceberGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(finLancamentoRecebers).replace(object.finLancamentoReceber!);
		});	 
	} 

	Future<int> deleteObject(FinLancamentoReceberGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(finLancamentoRecebers).delete(object.finLancamentoReceber!);
		});		
	}

	Future<void> insertChildren(FinLancamentoReceberGrouped object) async {
		for (var finParcelaReceberGrouped in object.finParcelaReceberGroupedList!) {
			finParcelaReceberGrouped.finParcelaReceber = finParcelaReceberGrouped.finParcelaReceber?.copyWith(
				id: const Value(null),
				idFinLancamentoReceber: Value(object.finLancamentoReceber!.id),
			);
			await into(finParcelaRecebers).insert(finParcelaReceberGrouped.finParcelaReceber!);
		}
	}
	
	Future<void> deleteChildren(FinLancamentoReceberGrouped object) async {
		await (delete(finParcelaRecebers)..where((t) => t.idFinLancamentoReceber.equals(object.finLancamentoReceber!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fin_lancamento_receber").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}