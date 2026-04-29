from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.fin_natureza_financeira_service import FinNaturezaFinanceiraService

fin_natureza_financeira_bp = Blueprint('fin-natureza-financeira', __name__)
service = FinNaturezaFinanceiraService()

@fin_natureza_financeira_bp.route('/fin-natureza-financeira', methods=['GET'])
@fin_natureza_financeira_bp.route('/fin-natureza-financeira/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@fin_natureza_financeira_bp.route('/fin-natureza-financeira/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@fin_natureza_financeira_bp.route('/fin-natureza-financeira', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@fin_natureza_financeira_bp.route('/fin-natureza-financeira', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@fin_natureza_financeira_bp.route('/fin-natureza-financeira/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})