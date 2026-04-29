from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.feriados_service import FeriadosService

feriados_bp = Blueprint('feriados', __name__)
service = FeriadosService()

@feriados_bp.route('/feriados', methods=['GET'])
@feriados_bp.route('/feriados/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@feriados_bp.route('/feriados/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@feriados_bp.route('/feriados', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@feriados_bp.route('/feriados', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@feriados_bp.route('/feriados/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})