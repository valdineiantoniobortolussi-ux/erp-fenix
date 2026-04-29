from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.contabil_dre_cabecalho_service import ContabilDreCabecalhoService

contabil_dre_cabecalho_bp = Blueprint('contabil-dre-cabecalho', __name__)
service = ContabilDreCabecalhoService()

@contabil_dre_cabecalho_bp.route('/contabil-dre-cabecalho', methods=['GET'])
@contabil_dre_cabecalho_bp.route('/contabil-dre-cabecalho/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@contabil_dre_cabecalho_bp.route('/contabil-dre-cabecalho/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@contabil_dre_cabecalho_bp.route('/contabil-dre-cabecalho', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@contabil_dre_cabecalho_bp.route('/contabil-dre-cabecalho', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@contabil_dre_cabecalho_bp.route('/contabil-dre-cabecalho/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})