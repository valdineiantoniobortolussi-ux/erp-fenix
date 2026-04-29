from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.fin_status_parcela_service import FinStatusParcelaService

fin_status_parcela_bp = Blueprint('fin-status-parcela', __name__)
service = FinStatusParcelaService()

@fin_status_parcela_bp.route('/fin-status-parcela', methods=['GET'])
@fin_status_parcela_bp.route('/fin-status-parcela/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@fin_status_parcela_bp.route('/fin-status-parcela/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@fin_status_parcela_bp.route('/fin-status-parcela', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@fin_status_parcela_bp.route('/fin-status-parcela', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@fin_status_parcela_bp.route('/fin-status-parcela/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})