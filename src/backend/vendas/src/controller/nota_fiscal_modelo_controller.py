from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.nota_fiscal_modelo_service import NotaFiscalModeloService

nota_fiscal_modelo_bp = Blueprint('nota-fiscal-modelo', __name__)
service = NotaFiscalModeloService()

@nota_fiscal_modelo_bp.route('/nota-fiscal-modelo', methods=['GET'])
@nota_fiscal_modelo_bp.route('/nota-fiscal-modelo/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@nota_fiscal_modelo_bp.route('/nota-fiscal-modelo/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@nota_fiscal_modelo_bp.route('/nota-fiscal-modelo', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@nota_fiscal_modelo_bp.route('/nota-fiscal-modelo', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@nota_fiscal_modelo_bp.route('/nota-fiscal-modelo/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})