from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.talonario_cheque_service import TalonarioChequeService

talonario_cheque_bp = Blueprint('talonario-cheque', __name__)
service = TalonarioChequeService()

@talonario_cheque_bp.route('/talonario-cheque', methods=['GET'])
@talonario_cheque_bp.route('/talonario-cheque/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@talonario_cheque_bp.route('/talonario-cheque/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@talonario_cheque_bp.route('/talonario-cheque', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@talonario_cheque_bp.route('/talonario-cheque', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@talonario_cheque_bp.route('/talonario-cheque/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})