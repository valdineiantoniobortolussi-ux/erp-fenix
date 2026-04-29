from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.tipo_contrato_service import TipoContratoService

tipo_contrato_bp = Blueprint('tipo-contrato', __name__)
service = TipoContratoService()

@tipo_contrato_bp.route('/tipo-contrato', methods=['GET'])
@tipo_contrato_bp.route('/tipo-contrato/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@tipo_contrato_bp.route('/tipo-contrato/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@tipo_contrato_bp.route('/tipo-contrato', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@tipo_contrato_bp.route('/tipo-contrato', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@tipo_contrato_bp.route('/tipo-contrato/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})