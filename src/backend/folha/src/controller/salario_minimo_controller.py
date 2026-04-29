from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.salario_minimo_service import SalarioMinimoService

salario_minimo_bp = Blueprint('salario-minimo', __name__)
service = SalarioMinimoService()

@salario_minimo_bp.route('/salario-minimo', methods=['GET'])
@salario_minimo_bp.route('/salario-minimo/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@salario_minimo_bp.route('/salario-minimo/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@salario_minimo_bp.route('/salario-minimo', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@salario_minimo_bp.route('/salario-minimo', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@salario_minimo_bp.route('/salario-minimo/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})