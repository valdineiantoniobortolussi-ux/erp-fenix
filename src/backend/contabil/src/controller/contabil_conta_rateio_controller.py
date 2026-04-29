from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.contabil_conta_rateio_service import ContabilContaRateioService

contabil_conta_rateio_bp = Blueprint('contabil-conta-rateio', __name__)
service = ContabilContaRateioService()

@contabil_conta_rateio_bp.route('/contabil-conta-rateio', methods=['GET'])
@contabil_conta_rateio_bp.route('/contabil-conta-rateio/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@contabil_conta_rateio_bp.route('/contabil-conta-rateio/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@contabil_conta_rateio_bp.route('/contabil-conta-rateio', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@contabil_conta_rateio_bp.route('/contabil-conta-rateio', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@contabil_conta_rateio_bp.route('/contabil-conta-rateio/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})