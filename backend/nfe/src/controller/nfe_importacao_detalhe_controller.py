from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.nfe_importacao_detalhe_service import NfeImportacaoDetalheService

nfe_importacao_detalhe_bp = Blueprint('nfe-importacao-detalhe', __name__)
service = NfeImportacaoDetalheService()

@nfe_importacao_detalhe_bp.route('/nfe-importacao-detalhe', methods=['GET'])
@nfe_importacao_detalhe_bp.route('/nfe-importacao-detalhe/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@nfe_importacao_detalhe_bp.route('/nfe-importacao-detalhe/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@nfe_importacao_detalhe_bp.route('/nfe-importacao-detalhe', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@nfe_importacao_detalhe_bp.route('/nfe-importacao-detalhe', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@nfe_importacao_detalhe_bp.route('/nfe-importacao-detalhe/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})