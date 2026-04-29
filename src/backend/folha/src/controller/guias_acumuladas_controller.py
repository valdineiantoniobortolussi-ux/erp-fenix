from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.guias_acumuladas_service import GuiasAcumuladasService

guias_acumuladas_bp = Blueprint('guias-acumuladas', __name__)
service = GuiasAcumuladasService()

@guias_acumuladas_bp.route('/guias-acumuladas', methods=['GET'])
@guias_acumuladas_bp.route('/guias-acumuladas/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@guias_acumuladas_bp.route('/guias-acumuladas/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@guias_acumuladas_bp.route('/guias-acumuladas', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@guias_acumuladas_bp.route('/guias-acumuladas', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@guias_acumuladas_bp.route('/guias-acumuladas/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})