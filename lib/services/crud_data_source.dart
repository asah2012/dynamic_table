import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CrudDataSource extends DataGridSource{

  List<DataGridRow>  dataGridRows = [];

  CrudDataSource(List<Map<String, dynamic>> dataList){

    dataList.forEach((dataRecord) {
      DataGridRow dgRow;
      List<DataGridCell> dgCellList = [];
        dataRecord.entries.forEach((dataCellEntry) {
          String columnName = dataCellEntry.key;
          var columnValue = dataCellEntry.value;
          if(columnValue == null){
              columnValue = "";
          }
          late DataGridCell dgCell;
              if(columnValue is int){
                dgCell = DataGridCell<int>(columnName: columnName, value: columnValue);
              }
              if(columnValue is String){
                dgCell = DataGridCell<String>(columnName: columnName, value: columnValue);
              }
              dgCellList.add(dgCell);        
        });
    dgRow =  DataGridRow(cells: [...dgCellList]);
    dataGridRows.add(dgRow);
  });
  }

  @override
  List<DataGridRow> get rows =>  dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {

        List<DataGridCell> dgCellList = row.getCells();
        List<Widget> widgetCellList = [];
        dgCellList.forEach((dgCell) {
          Widget widgetCell = Container(
                            alignment:Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                                  dgCell.value.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  )
                            );
          widgetCellList.add(widgetCell);
        },);
        return DataGridRowAdapter(cells : widgetCellList,);
  }
}