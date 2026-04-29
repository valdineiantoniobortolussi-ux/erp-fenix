from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.nota_fiscal_tipo_service import NotaFiscalTipoService

nota_fiscal_tipo_bp = Blueprint('nota-fiscal-tipo', __name__)
service = NotaFiscalTipoService()

@nota_fiscal_tipo_bp.route('/nota-fiscal-tipo', methods=['GET'])
@nota_fiscal_tipo_bp.route('/nota-fiscal-tipo/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@nota_fiscal_tipo_bp.route('/nota-fiscal-tipo/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@nota_fiscal_tipo_bp.route('/nota-fiscal-tipo', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@nota_fiscal_tipo_bp.route('/nota-fiscal-tipo', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@nota_fiscal_tipo_bp.route('/nota-fiscal-tipo/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})