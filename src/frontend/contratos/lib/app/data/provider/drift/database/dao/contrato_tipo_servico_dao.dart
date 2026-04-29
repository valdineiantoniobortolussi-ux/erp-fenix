import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';
import 'package:contratos/app/data/provider/drift/database/database_imports.dart';

part 'contrato_tipo_servico_dao.g.dart';

@DriftAccessor(tables: [
	ContratoTipoServicos,
])
class ContratoTipoServicoDao extends DatabaseAccessor<AppDatabase> with _$ContratoTipoServicoDaoMixin {
	final AppDatabase db;

	List<ContratoTipoServico> contratoTipoServicoList = []; 
	List<ContratoTipoServicoGrouped> contratoTipoServicoGroupedList = []; 

	ContratoTipoServicoDao(this.db) : super(db);

	Future<List<ContratoTipoServico>> getList() async {
		contratoTipoServicoList = await select(contratoTipoServicos).get();
		return contratoTipoServicoList;
	}

	Future<List<ContratoTipoServico>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contratoTipoServicoList = await (select(contratoTipoServicos)..where((t) => expression)).get();
		return contratoTipoServicoList;	 
	}

	Future<List<ContratoTipoServicoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contratoTipoServicos)
			.join([]);

		if (field != null && field != '') { 
			final column = contratoTipoServicos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contratoTipoServicoGroupedList = await query.map((row) {
			final contratoTipoServico = row.readTableOrNull(contratoTipoServicos); 

			return ContratoTipoServicoGrouped(
				contratoTipoServico: contratoTipoServico, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var contratoTipoServicoGrouped in contratoTipoServicoGroupedList) {
		//}		

		return contratoTipoServicoGroupedList;	
	}

	Future<ContratoTipoServico?> getObject(dynamic pk) async {
		return await (select(contratoTipoServicos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContratoTipoServico?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contrato_tipo_servico WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContratoTipoServico;		 
	} 

	Future<ContratoTipoServicoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContratoTipoServicoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contratoTipoServico = object.contratoTipoServico!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contratoTipoServicos).insert(object.contratoTipoServico!);
			object.contratoTipoServico = object.contratoTipoServico!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContratoTipoServicoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contratoTipoServicos).replace(object.contratoTipoServico!);
		});	 
	} 

	Future<int> deleteObject(ContratoTipoServicoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contratoTipoServicos).delete(object.contratoTipoServico!);
		});		
	}

	Future<void> insertChildren(ContratoTipoServicoGrouped object) async {
	}
	
	Future<void> deleteChildren(ContratoTipoServicoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contrato_tipo_servico").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}