import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'fin_cheque_recebido_dao.g.dart';

@DriftAccessor(tables: [
	FinChequeRecebidos,
	ViewPessoaClientes,
])
class FinChequeRecebidoDao extends DatabaseAccessor<AppDatabase> with _$FinChequeRecebidoDaoMixin {
	final AppDatabase db;

	List<FinChequeRecebido> finChequeRecebidoList = []; 
	List<FinChequeRecebidoGrouped> finChequeRecebidoGroupedList = []; 

	FinChequeRecebidoDao(this.db) : super(db);

	Future<List<FinChequeRecebido>> getList() async {
		finChequeRecebidoList = await select(finChequeRecebidos).get();
		return finChequeRecebidoList;
	}

	Future<List<FinChequeRecebido>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		finChequeRecebidoList = await (select(finChequeRecebidos)..where((t) => expression)).get();
		return finChequeRecebidoList;	 
	}

	Future<List<FinChequeRecebidoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(finChequeRecebidos)
			.join([ 
				leftOuterJoin(viewPessoaClientes, viewPessoaClientes.id.equalsExp(finChequeRecebidos.idCliente)), 
			]);

		if (field != null && field != '') { 
			final column = finChequeRecebidos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		finChequeRecebidoGroupedList = await query.map((row) {
			final finChequeRecebido = row.readTableOrNull(finChequeRecebidos); 
			final viewPessoaCliente = row.readTableOrNull(viewPessoaClientes); 

			return FinChequeRecebidoGrouped(
				finChequeRecebido: finChequeRecebido, 
				viewPessoaCliente: viewPessoaCliente, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var finChequeRecebidoGrouped in finChequeRecebidoGroupedList) {
		//}		

		return finChequeRecebidoGroupedList;	
	}

	Future<FinChequeRecebido?> getObject(dynamic pk) async {
		return await (select(finChequeRecebidos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FinChequeRecebido?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fin_cheque_recebido WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FinChequeRecebido;		 
	} 

	Future<FinChequeRecebidoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FinChequeRecebidoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.finChequeRecebido = object.finChequeRecebido!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(finChequeRecebidos).insert(object.finChequeRecebido!);
			object.finChequeRecebido = object.finChequeRecebido!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FinChequeRecebidoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(finChequeRecebidos).replace(object.finChequeRecebido!);
		});	 
	} 

	Future<int> deleteObject(FinChequeRecebidoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(finChequeRecebidos).delete(object.finChequeRecebido!);
		});		
	}

	Future<void> insertChildren(FinChequeRecebidoGrouped object) async {
	}
	
	Future<void> deleteChildren(FinChequeRecebidoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fin_cheque_recebido").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}