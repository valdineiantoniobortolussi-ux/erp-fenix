from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.esocial_classificacao_tribut_service import EsocialClassificacaoTributService

esocial_classificacao_tribut_bp = Blueprint('esocial-classificacao-tribut', __name__)
service = EsocialClassificacaoTributService()

@esocial_classificacao_tribut_bp.route('/esocial-classificacao-tribut', methods=['GET'])
@esocial_classificacao_tribut_bp.route('/esocial-classificacao-tribut/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@esocial_classificacao_tribut_bp.route('/esocial-classificacao-tribut/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@esocial_classificacao_tribut_bp.route('/esocial-classificacao-tribut', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@esocial_classificacao_tribut_bp.route('/esocial-classificacao-tribut', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@esocial_classificacao_tribut_bp.route('/esocial-classificacao-tribut/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})