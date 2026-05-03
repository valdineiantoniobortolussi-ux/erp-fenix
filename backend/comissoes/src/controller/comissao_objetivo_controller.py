from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.comissao_objetivo_service import ComissaoObjetivoService

comissao_objetivo_bp = Blueprint('comissao-objetivo', __name__)
service = ComissaoObjetivoService()

@comissao_objetivo_bp.route('/comissao-objetivo', methods=['GET'])
@comissao_objetivo_bp.route('/comissao-objetivo/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@comissao_objetivo_bp.route('/comissao-objetivo/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@comissao_objetivo_bp.route('/comissao-objetivo', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@comissao_objetivo_bp.route('/comissao-objetivo', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@comissao_objetivo_bp.route('/comissao-objetivo/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})