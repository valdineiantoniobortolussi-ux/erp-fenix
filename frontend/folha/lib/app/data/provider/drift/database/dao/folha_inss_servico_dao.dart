import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_inss_servico_dao.g.dart';

@DriftAccessor(tables: [
	FolhaInssServicos,
])
class FolhaInssServicoDao extends DatabaseAccessor<AppDatabase> with _$FolhaInssServicoDaoMixin {
	final AppDatabase db;

	List<FolhaInssServico> folhaInssServicoList = []; 
	List<FolhaInssServicoGrouped> folhaInssServicoGroupedList = []; 

	FolhaInssServicoDao(this.db) : super(db);

	Future<List<FolhaInssServico>> getList() async {
		folhaInssServicoList = await select(folhaInssServicos).get();
		return folhaInssServicoList;
	}

	Future<List<FolhaInssServico>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaInssServicoList = await (select(folhaInssServicos)..where((t) => expression)).get();
		return folhaInssServicoList;	 
	}

	Future<List<FolhaInssServicoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaInssServicos)
			.join([]);

		if (field != null && field != '') { 
			final column = folhaInssServicos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaInssServicoGroupedList = await query.map((row) {
			final folhaInssServico = row.readTableOrNull(folhaInssServicos); 

			return FolhaInssServicoGrouped(
				folhaInssServico: folhaInssServico, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var folhaInssServicoGrouped in folhaInssServicoGroupedList) {
		//}		

		return folhaInssServicoGroupedList;	
	}

	Future<FolhaInssServico?> getObject(dynamic pk) async {
		return await (select(folhaInssServicos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaInssServico?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_inss_servico WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaInssServico;		 
	} 

	Future<FolhaInssServicoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaInssServicoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaInssServico = object.folhaInssServico!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaInssServicos).insert(object.folhaInssServico!);
			object.folhaInssServico = object.folhaInssServico!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaInssServicoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaInssServicos).replace(object.folhaInssServico!);
		});	 
	} 

	Future<int> deleteObject(FolhaInssServicoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaInssServicos).delete(object.folhaInssServico!);
		});		
	}

	Future<void> insertChildren(FolhaInssServicoGrouped object) async {
	}
	
	Future<void> deleteChildren(FolhaInssServicoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_inss_servico").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}