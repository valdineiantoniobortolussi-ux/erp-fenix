from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.ponto_marcacao_service import PontoMarcacaoService

ponto_marcacao_bp = Blueprint('ponto-marcacao', __name__)
service = PontoMarcacaoService()

@ponto_marcacao_bp.route('/ponto-marcacao', methods=['GET'])
@ponto_marcacao_bp.route('/ponto-marcacao/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@ponto_marcacao_bp.route('/ponto-marcacao/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@ponto_marcacao_bp.route('/ponto-marcacao', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@ponto_marcacao_bp.route('/ponto-marcacao', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@ponto_marcacao_bp.route('/ponto-marcacao/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})