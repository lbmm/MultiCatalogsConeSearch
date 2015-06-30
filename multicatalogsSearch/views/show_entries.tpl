% include header.tpl css_array=["http://cdn.datatables.net/1.10.4/css/jquery.dataTables.min.css","/static/style.css"],js_array=["http://cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js", "https://www.google.com/jsapi"]


<script type="text/javascript">

   google.load("visualization", "1", {packages:["corechart"]});

   google.setOnLoadCallback(drawChart_catalogs);

     function drawChart_catalogs() {

         var data = google.visualization.arrayToDataTable([
          ['Catalogs', 'how many sources']
          % for k in data[0].keys():
          ,["{{k}}", {{data[0][k]}}]
          %end

        ]);

        var options = {
          title: 'ASDC catalogs',
          width: 500,
          height: 300,
          pieSliceText: 'value',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_catalogs'));
        chart.draw(data, options);

        google.visualization.events.addListener(chart, 'select', function() {
        var selection = chart.getSelection();
        row = selection[0].row
        var selected =  data.getFormattedValue(row, 0)
        var all_links = {{!hyper_links}};
        var location = all_links[selected];
        window.location =  location+'index.php?ra='+'{{ra}}'+'&dec='+{{Dec}}+'&radius='+{{radius}};
         });
      }



function fnFormatDetails(table_id, html) {
  var sOut = "<table id=\"catalogs_" + table_id + "\" >";
  sOut += html;
  sOut += "</table>";
  return sOut;
}

var newRowData = [];
var detailsColumns = []; //mDataProp
%for d in range(1, len(data)):
  % catalog_name = data[d]['catalog_name']

    var fullDetail_row{{d}} = {};
    var columnsInfo = [];
    var columns = {};
    %for e_c in extra_columns[catalog_name]:
           %column_name = (e_c.replace("-","_")).replace(" ", "")
           columns ={'mDataProp':'{{column_name}}', 'sTitle':'{{!e_c}}'}
           columnsInfo.push(columns)
           fullDetail_row{{d}}['{{column_name}}']='{{!data[d][e_c]}}'
    % end
detailsColumns.push(columnsInfo);
var details_row{{d}}=[fullDetail_row{{d}}];
var row_{{d}} = { Catalog: '{{catalog_name}}', Name: '{{data[d]['%s_name' %catalog_name]}}', Other_Name: '{{data[d]['other_name']}}',
                  Ra: '{{data[d].get('RA', 0)}}', Dec:'{{data[d].get('Dec', 0)}}', LII: '{{data[d].get('LII', 0)}}', BII: '{{data[d].get('BII', 0)}}',details: details_row{{d}}};
newRowData.push(row_{{d}})
%end


////////////////////////////////////////////////////////////

var iTableCounter = 1;
    var oTable;
    var oInnerTable;
    var detailsTableHtml;

    //Run On HTML Build
    $(document).ready(function () {


       // you would probably be using templates here
        detailsTableHtml = $("#detailsTable").html();

        //Insert a 'details' column to the table
        var nCloneTh = document.createElement('th');
        var nCloneTd = document.createElement('td');
        nCloneTd.innerHTML = '<img src="http://i.imgur.com/SD7Dz.png">';
        nCloneTd.className = "center";

        $('#catalogs thead tr').each(function () {
            this.insertBefore(nCloneTh, this.childNodes[0]);
        });

        $('#catalogs tbody tr').each(function () {
            this.insertBefore(nCloneTd.cloneNode(true), this.childNodes[0]);
        });



          //Initialse DataTables, with no sorting on the 'details' column
        var oTable = $('#catalogs').dataTable({
            "bJQueryUI": true,
            "aaData": newRowData,
            "iDisplayLength": 5,
            "bAutoWidth":false, 
            "aoColumns": [
                {
                   "mDataProp": null,
                   "sClass": "control center",
                   "sDefaultContent": '<img src="http://i.imgur.com/SD7Dz.png">'
                },
                { "mDataProp": "Catalog" },
                { "mDataProp": "Name" },
                { "mDataProp": "Other_Name" },
                { "mDataProp": "Ra" },
                { "mDataProp": "Dec" },
                { "mDataProp": "LII" },
                { "mDataProp": "BII" }
            ],
            "aaSorting": [[1, 'asc']]
        });



        /* Add event listener for opening and closing details
        * Note that the indicator for showing which row is open is not controlled by DataTables,
        * rather it is done here
        */
        $('#catalogs tbody td img').click(function () {
            var nTr = $(this).parents('tr')[0];
            var nTds = this;

            if (oTable.fnIsOpen(nTr)) {
                /* This row is already open - close it */
                this.src = "http://i.imgur.com/SD7Dz.png";
                oTable.fnClose(nTr);
            }
            else {
                /* Open this row */
                var rowIndex = oTable.fnGetPosition( $(nTds).closest('tr')[0]);
                var detailsRowData = newRowData[rowIndex].details;
                var dColumns = detailsColumns[rowIndex];
                this.src = "http://i.imgur.com/d4ICC.png";

                oTable.fnOpen(nTr, fnFormatDetails(iTableCounter, detailsTableHtml), 'details');
                oInnerTable = $("#catalogs_" + iTableCounter).dataTable({
                    "sScrollX": '100%',
                    "bJQueryUI": true,
                    "bFilter": false,
                    "aaData": detailsRowData,
                    "aoColumns": dColumns,
                    "oLanguage": {
			                "sInfo": ""
			         },
                    "bSort" : true, // disables sorting
                    "bPaginate": false,
                    "autoWidth": false,
                    "paging": false,
                    "sErrMode" : "throw"
                    });

                iTableCounter = iTableCounter + 1;
            }
        });


});

</script>




  <div class="all_page">



  <table align="center">
  <tr>
    <td>
       <h2> Result for query with Ra={{ra}}, Dec={{Dec}}, radius={{radius}} arcmin</h2>
    </td>
  </tr>
  <tr>

   <td>

       <div id="piechart_catalogs" align='center' style="width: 500px; height: 300px;"></div>

   </td>
   </tr>

   <tr>
  <td>

  <table class="display"  align="center" id="catalogs">
                        <thead>
                                <tr>

                                        <th>Catalog</th>
                                        <th>Name</th>
                                        <th>Other_Name</th>
                                        <th>Ra</th>
                                        <th>Dec</th>
                                        <th>LII</th>
                                        <th>BII</th>

                                </tr>
                        </thead>

                      <tbody></tbody>
                     </table>

                     <div style="display:none">
                           <table id="detailsTable" >
                            <thead>
                           </thead>
                          <tbody></tbody>
                          </table>
                     </div>



    </td>
    </tr>
    </table>
    </div>


    </body>
    </html>
