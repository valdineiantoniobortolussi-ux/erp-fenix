from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.tipo_admissao_service import TipoAdmissaoService

tipo_admissao_bp = Blueprint('tipo-admissao', __name__)
service = TipoAdmissaoService()

@tipo_admissao_bp.route('/tipo-admissao', methods=['GET'])
@tipo_admissao_bp.route('/tipo-admissao/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@tipo_admissao_bp.route('/tipo-admissao/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@tipo_admissao_bp.route('/tipo-admissao', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@tipo_admissao_bp.route('/tipo-admissao', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@tipo_admissao_bp.route('/tipo-admissao/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})