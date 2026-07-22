@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText.label: 'Stock Quantity by Warehouse'

@UI.presentationVariant: [
  {
    qualifier: 'Default',
    visualizations: [ { type: #AS_CHART, qualifier: 'StockChart' } ]
  }
]

@UI.chart: [
  {
    qualifier: 'StockChart',
    chartType: #COLUMN,
    dimensions: [ 'WarehouseID' ],
    measures: [ 'TotalQuantity' ],
    measureAttributes: [
      {
        measure: 'TotalQuantity',
        role: #AXIS_1
      }
    ]
  }
]

define view entity ZI_WHMS_VV01
  as select from zwhms_stk
{
  @UI.lineItem: [ { position: 10 } ]
  key warehouse_id as WarehouseID,

  @UI.lineItem: [ { position: 20 } ]
  sum( quantity ) as TotalQuantity
}
group by
  warehouse_id
