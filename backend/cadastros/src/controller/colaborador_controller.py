from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.colaborador_service import ColaboradorService

colaborador_bp = Blueprint('colaborador', __name__)
service = ColaboradorService()

@colaborador_bp.route('/colaborador', methods=['GET'])
@colaborador_bp.route('/colaborador/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@colaborador_bp.route('/colaborador/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@colaborador_bp.route('/colaborador', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@colaborador_bp.route('/colaborador', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@colaborador_bp.route('/colaborador/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})