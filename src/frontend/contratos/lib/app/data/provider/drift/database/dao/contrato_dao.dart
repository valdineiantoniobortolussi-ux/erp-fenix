import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';
import 'package:contratos/app/data/provider/drift/database/database_imports.dart';

part 'contrato_dao.g.dart';

@DriftAccessor(tables: [
	Contratos,
	ContratoHistoricoReajustes,
	ContratoPrevFaturamentos,
	ContratoHistFaturamentos,
	TipoContratos,
	ContratoSolicitacaoServicos,
])
class ContratoDao extends DatabaseAccessor<AppDatabase> with _$ContratoDaoMixin {
	final AppDatabase db;

	List<Contrato> contratoList = []; 
	List<ContratoGrouped> contratoGroupedList = []; 

	ContratoDao(this.db) : super(db);

	Future<List<Contrato>> getList() async {
		contratoList = await select(contratos).get();
		return contratoList;
	}

	Future<List<Contrato>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contratoList = await (select(contratos)..where((t) => expression)).get();
		return contratoList;	 
	}

	Future<List<ContratoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contratos)
			.join([ 
				leftOuterJoin(tipoContratos, tipoContratos.id.equalsExp(contratos.idTipoContrato)), 
			]).join([ 
				leftOuterJoin(contratoSolicitacaoServicos, contratoSolicitacaoServicos.id.equalsExp(contratos.idSolicitacaoServico)), 
			]);

		if (field != null && field != '') { 
			final column = contratos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contratoGroupedList = await query.map((row) {
			final contrato = row.readTableOrNull(contratos); 
			final tipoContrato = row.readTableOrNull(tipoContratos); 
			final contratoSolicitacaoServico = row.readTableOrNull(contratoSolicitacaoServicos); 

			return ContratoGrouped(
				contrato: contrato, 
				tipoContrato: tipoContrato, 
				contratoSolicitacaoServico: contratoSolicitacaoServico, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var contratoGrouped in contratoGroupedList) {
			contratoGrouped.contratoHistoricoReajusteGroupedList = [];
			final queryContratoHistoricoReajuste = ' id_contrato = ${contratoGrouped.contrato!.id}';
			expression = CustomExpression<bool>(queryContratoHistoricoReajuste);
			final contratoHistoricoReajusteList = await (select(contratoHistoricoReajustes)..where((t) => expression)).get();
			for (var contratoHistoricoReajuste in contratoHistoricoReajusteList) {
				ContratoHistoricoReajusteGrouped contratoHistoricoReajusteGrouped = ContratoHistoricoReajusteGrouped(
					contratoHistoricoReajuste: contratoHistoricoReajuste,
				);
				contratoGrouped.contratoHistoricoReajusteGroupedList!.add(contratoHistoricoReajusteGrouped);
			}

			contratoGrouped.contratoPrevFaturamentoGroupedList = [];
			final queryContratoPrevFaturamento = ' id_contrato = ${contratoGrouped.contrato!.id}';
			expression = CustomExpression<bool>(queryContratoPrevFaturamento);
			final contratoPrevFaturamentoList = await (select(contratoPrevFaturamentos)..where((t) => expression)).get();
			for (var contratoPrevFaturamento in contratoPrevFaturamentoList) {
				ContratoPrevFaturamentoGrouped contratoPrevFaturamentoGrouped = ContratoPrevFaturamentoGrouped(
					contratoPrevFaturamento: contratoPrevFaturamento,
				);
				contratoGrouped.contratoPrevFaturamentoGroupedList!.add(contratoPrevFaturamentoGrouped);
			}

			contratoGrouped.contratoHistFaturamentoGroupedList = [];
			final queryContratoHistFaturamento = ' id_contrato = ${contratoGrouped.contrato!.id}';
			expression = CustomExpression<bool>(queryContratoHistFaturamento);
			final contratoHistFaturamentoList = await (select(contratoHistFaturamentos)..where((t) => expression)).get();
			for (var contratoHistFaturamento in contratoHistFaturamentoList) {
				ContratoHistFaturamentoGrouped contratoHistFaturamentoGrouped = ContratoHistFaturamentoGrouped(
					contratoHistFaturamento: contratoHistFaturamento,
				);
				contratoGrouped.contratoHistFaturamentoGroupedList!.add(contratoHistFaturamentoGrouped);
			}

		}		

		return contratoGroupedList;	
	}

	Future<Contrato?> getObject(dynamic pk) async {
		return await (select(contratos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Contrato?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contrato WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Contrato;		 
	} 

	Future<ContratoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContratoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contrato = object.contrato!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contratos).insert(object.contrato!);
			object.contrato = object.contrato!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContratoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contratos).replace(object.contrato!);
		});	 
	} 

	Future<int> deleteObject(ContratoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contratos).delete(object.contrato!);
		});		
	}

	Future<void> insertChildren(ContratoGrouped object) async {
		for (var contratoHistoricoReajusteGrouped in object.contratoHistoricoReajusteGroupedList!) {
			contratoHistoricoReajusteGrouped.contratoHistoricoReajuste = contratoHistoricoReajusteGrouped.contratoHistoricoReajuste?.copyWith(
				id: const Value(null),
				idContrato: Value(object.contrato!.id),
			);
			await into(contratoHistoricoReajustes).insert(contratoHistoricoReajusteGrouped.contratoHistoricoReajuste!);
		}
		for (var contratoPrevFaturamentoGrouped in object.contratoPrevFaturamentoGroupedList!) {
			contratoPrevFaturamentoGrouped.contratoPrevFaturamento = contratoPrevFaturamentoGrouped.contratoPrevFaturamento?.copyWith(
				id: const Value(null),
				idContrato: Value(object.contrato!.id),
			);
			await into(contratoPrevFaturamentos).insert(contratoPrevFaturamentoGrouped.contratoPrevFaturamento!);
		}
		for (var contratoHistFaturamentoGrouped in object.contratoHistFaturamentoGroupedList!) {
			contratoHistFaturamentoGrouped.contratoHistFaturamento = contratoHistFaturamentoGrouped.contratoHistFaturamento?.copyWith(
				id: const Value(null),
				idContrato: Value(object.contrato!.id),
			);
			await into(contratoHistFaturamentos).insert(contratoHistFaturamentoGrouped.contratoHistFaturamento!);
		}
	}
	
	Future<void> deleteChildren(ContratoGrouped object) async {
		await (delete(contratoHistoricoReajustes)..where((t) => t.idContrato.equals(object.contrato!.id!))).go();
		await (delete(contratoPrevFaturamentos)..where((t) => t.idContrato.equals(object.contrato!.id!))).go();
		await (delete(contratoHistFaturamentos)..where((t) => t.idContrato.equals(object.contrato!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contrato").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}