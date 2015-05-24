% include header.tpl css_array=["http://cdn.datatables.net/1.10.4/css/jquery.dataTables.min.css","/static/style.css"],js_array=["http://cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js","/js/show_entries.js"]




<div class="all_page" width="90%" align="center">

  <table  width="90%" class="display"  align="center" id="catalogs">
                <thead>
                   <tr>
                         %for header in catalog_meta_data['columns']:
                               <th>{{header}}</th>

                          %end
                 </tr>
                 </thead>
                 <tbody>
                 % for d in data:
                     <tr>
                    %for header in catalog_meta_data['columns']:


                               <td >{{d[header]}}</td>


                        % end
                        </tr>
                 %end
                  </tbody>
                </table>

  <p align="center">
  <a href="{{catalog_meta_data['link']}}">ASDC catalog</a>
  </p>

</div>

    </body>
    </html>