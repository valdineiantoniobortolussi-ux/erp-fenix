from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.fin_cheque_recebido_service import FinChequeRecebidoService

fin_cheque_recebido_bp = Blueprint('fin-cheque-recebido', __name__)
service = FinChequeRecebidoService()

@fin_cheque_recebido_bp.route('/fin-cheque-recebido', methods=['GET'])
@fin_cheque_recebido_bp.route('/fin-cheque-recebido/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@fin_cheque_recebido_bp.route('/fin-cheque-recebido/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@fin_cheque_recebido_bp.route('/fin-cheque-recebido', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@fin_cheque_recebido_bp.route('/fin-cheque-recebido', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@fin_cheque_recebido_bp.route('/fin-cheque-recebido/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})