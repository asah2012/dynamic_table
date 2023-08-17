import 'package:dynamic_table/data/data_service.dart';
import 'package:dynamic_table/services/crud_data_source.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CRUDDataScreen extends StatefulWidget {
  const CRUDDataScreen({super.key});

  @override
  State<CRUDDataScreen> createState() => _MyCRUDDataScreenState();
}

class _MyCRUDDataScreenState extends State<CRUDDataScreen> {

  DataService dataService = DataService();
  List<String>columnName = [];
  late CrudDataSource crudDataSource;

  Future<void> loadData() async{
    await dataService.initData();
    setState(() {
        crudDataSource = CrudDataSource(dataService.recordList);
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    //isWebOrDesktop = true;
  }

SfDataGrid _buildDataGrid(BuildContext context){
  print("_buildDataGrid : calling SfDataGrid");
      return SfDataGrid(
        allowEditing: true,
        navigationMode: GridNavigationMode.cell,
        //selectionMode: SelectionMode.multiple,
        selectionMode: SelectionMode.single,
        checkboxShape: const CircleBorder(),
       // controller: _dataGridController,
       // editingGestureType: editingGestureType,
        showCheckboxColumn: true,
        allowSorting: true,
        //checkboxColumnSettings: const DataGridCheckboxColumnSettings(label: Text("Selector"), width: 100),
        source: crudDataSource,
        columnWidthMode: ColumnWidthMode.none,
        columns: dataService.columnNameList.map((columnValue){
              return GridColumn(
              columnName: columnValue,
              label: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Text(
                    style:TextStyle(fontSize: 10),
                    columnValue.toUpperCase(),
                  //overflow: TextOverflow.ellipsis,
                  ),
                  ));
        }).toList(),
      );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text("Item Table")),
      body: dataService.recordList.isEmpty ? const Center(child: CircularProgressIndicator()) 
      : SafeArea(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Expanded(child: _buildDataGrid(context)),
        const SizedBox(height: 10,),
        //ElevatedButton(onPressed: () => selectedRowOperation(), child: const Text("Submit")),
        const SizedBox(height: 50,),
        // Container(decoration: BoxDecoration(
        //   border: Border.all(color: Colors.black , width: 2.0)),
        //   width: 100,
        //   child : Text("Selected item is $_selectedItemCode")),
        const SizedBox(height: 100,),
        ])),
    );   
  }

List<GridColumn> getDataColumns() {
  print("column count is : ${dataService.columnNameList}");
  List<GridColumn> gridColumnList = [];
  for(var tmpColName in dataService.columnNameList){
      GridColumn(
              columnName: tmpColName,
              label: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'ID',
                  overflow: TextOverflow.ellipsis,
                  )));
  }
  return gridColumnList;
}

}

