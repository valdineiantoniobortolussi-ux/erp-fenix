from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.ponto_abono_service import PontoAbonoService

ponto_abono_bp = Blueprint('ponto-abono', __name__)
service = PontoAbonoService()

@ponto_abono_bp.route('/ponto-abono', methods=['GET'])
@ponto_abono_bp.route('/ponto-abono/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@ponto_abono_bp.route('/ponto-abono/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@ponto_abono_bp.route('/ponto-abono', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@ponto_abono_bp.route('/ponto-abono', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@ponto_abono_bp.route('/ponto-abono/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})