from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.cst_ipi_service import CstIpiService

cst_ipi_bp = Blueprint('cst-ipi', __name__)
service = CstIpiService()

@cst_ipi_bp.route('/cst-ipi', methods=['GET'])
@cst_ipi_bp.route('/cst-ipi/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@cst_ipi_bp.route('/cst-ipi/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@cst_ipi_bp.route('/cst-ipi', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@cst_ipi_bp.route('/cst-ipi', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@cst_ipi_bp.route('/cst-ipi/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})