import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'fin_lancamento_pagar_dao.g.dart';

@DriftAccessor(tables: [
	FinLancamentoPagars,
	FinParcelaPagars,
	FinStatusParcelas,
	FinTipoPagamentos,
	FinDocumentoOrigems,
	BancoContaCaixas,
	FinNaturezaFinanceiras,
	ViewPessoaFornecedors,
])
class FinLancamentoPagarDao extends DatabaseAccessor<AppDatabase> with _$FinLancamentoPagarDaoMixin {
	final AppDatabase db;

	List<FinLancamentoPagar> finLancamentoPagarList = []; 
	List<FinLancamentoPagarGrouped> finLancamentoPagarGroupedList = []; 

	FinLancamentoPagarDao(this.db) : super(db);

	Future<List<FinLancamentoPagar>> getList() async {
		finLancamentoPagarList = await select(finLancamentoPagars).get();
		return finLancamentoPagarList;
	}

	Future<List<FinLancamentoPagar>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		finLancamentoPagarList = await (select(finLancamentoPagars)..where((t) => expression)).get();
		return finLancamentoPagarList;	 
	}

	Future<List<FinLancamentoPagarGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(finLancamentoPagars)
			.join([ 
				leftOuterJoin(finDocumentoOrigems, finDocumentoOrigems.id.equalsExp(finLancamentoPagars.idFinDocumentoOrigem)), 
			]).join([ 
				leftOuterJoin(bancoContaCaixas, bancoContaCaixas.id.equalsExp(finLancamentoPagars.idBancoContaCaixa)), 
			]).join([ 
				leftOuterJoin(finNaturezaFinanceiras, finNaturezaFinanceiras.id.equalsExp(finLancamentoPagars.idFinNaturezaFinanceira)), 
			]).join([ 
				leftOuterJoin(viewPessoaFornecedors, viewPessoaFornecedors.id.equalsExp(finLancamentoPagars.idFornecedor)), 
			]);

		if (field != null && field != '') { 
			final column = finLancamentoPagars.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		finLancamentoPagarGroupedList = await query.map((row) {
			final finLancamentoPagar = row.readTableOrNull(finLancamentoPagars); 
			final finDocumentoOrigem = row.readTableOrNull(finDocumentoOrigems); 
			final bancoContaCaixa = row.readTableOrNull(bancoContaCaixas); 
			final finNaturezaFinanceira = row.readTableOrNull(finNaturezaFinanceiras); 
			final viewPessoaFornecedor = row.readTableOrNull(viewPessoaFornecedors); 

			return FinLancamentoPagarGrouped(
				finLancamentoPagar: finLancamentoPagar, 
				finDocumentoOrigem: finDocumentoOrigem, 
				bancoContaCaixa: bancoContaCaixa, 
				finNaturezaFinanceira: finNaturezaFinanceira, 
				viewPessoaFornecedor: viewPessoaFornecedor, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var finLancamentoPagarGrouped in finLancamentoPagarGroupedList) {
			finLancamentoPagarGrouped.finParcelaPagarGroupedList = [];
			final queryFinParcelaPagar = ' id_fin_lancamento_pagar = ${finLancamentoPagarGrouped.finLancamentoPagar!.id}';
			expression = CustomExpression<bool>(queryFinParcelaPagar);
			final finParcelaPagarList = await (select(finParcelaPagars)..where((t) => expression)).get();
			for (var finParcelaPagar in finParcelaPagarList) {
				FinParcelaPagarGrouped finParcelaPagarGrouped = FinParcelaPagarGrouped(
					finParcelaPagar: finParcelaPagar,
					finStatusParcela: await (select(finStatusParcelas)..where((t) => t.id.equals(finParcelaPagar.idFinStatusParcela!))).getSingleOrNull(),
					finTipoPagamento: await (select(finTipoPagamentos)..where((t) => t.id.equals(finParcelaPagar.idFinTipoPagamento!))).getSingleOrNull(),
				);
				finLancamentoPagarGrouped.finParcelaPagarGroupedList!.add(finParcelaPagarGrouped);
			}

		}		

		return finLancamentoPagarGroupedList;	
	}

	Future<FinLancamentoPagar?> getObject(dynamic pk) async {
		return await (select(finLancamentoPagars)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FinLancamentoPagar?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fin_lancamento_pagar WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FinLancamentoPagar;		 
	} 

	Future<FinLancamentoPagarGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FinLancamentoPagarGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.finLancamentoPagar = object.finLancamentoPagar!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(finLancamentoPagars).insert(object.finLancamentoPagar!);
			object.finLancamentoPagar = object.finLancamentoPagar!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FinLancamentoPagarGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(finLancamentoPagars).replace(object.finLancamentoPagar!);
		});	 
	} 

	Future<int> deleteObject(FinLancamentoPagarGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(finLancamentoPagars).delete(object.finLancamentoPagar!);
		});		
	}

	Future<void> insertChildren(FinLancamentoPagarGrouped object) async {
		for (var finParcelaPagarGrouped in object.finParcelaPagarGroupedList!) {
			finParcelaPagarGrouped.finParcelaPagar = finParcelaPagarGrouped.finParcelaPagar?.copyWith(
				id: const Value(null),
				idFinLancamentoPagar: Value(object.finLancamentoPagar!.id),
			);
			await into(finParcelaPagars).insert(finParcelaPagarGrouped.finParcelaPagar!);
		}
	}
	
	Future<void> deleteChildren(FinLancamentoPagarGrouped object) async {
		await (delete(finParcelaPagars)..where((t) => t.idFinLancamentoPagar.equals(object.finLancamentoPagar!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fin_lancamento_pagar").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}