from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.esocial_rubrica_service import EsocialRubricaService

esocial_rubrica_bp = Blueprint('esocial-rubrica', __name__)
service = EsocialRubricaService()

@esocial_rubrica_bp.route('/esocial-rubrica', methods=['GET'])
@esocial_rubrica_bp.route('/esocial-rubrica/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@esocial_rubrica_bp.route('/esocial-rubrica/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@esocial_rubrica_bp.route('/esocial-rubrica', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@esocial_rubrica_bp.route('/esocial-rubrica', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@esocial_rubrica_bp.route('/esocial-rubrica/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})