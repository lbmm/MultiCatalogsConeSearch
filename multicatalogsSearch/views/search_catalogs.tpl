% include header.tpl js_array=["/js/jquery.multiselect.js","/js/jquery.multiselect.filter.js","/js/search_catalogs.js", "http://d3js.org/d3.v3.min.js"], css_array=["/static/jquery.multiselect.css", "/static/jquery.multiselect.filter.css", "/static/tree.css"]

%setdefault('error','')
%setdefault('ra','')
%setdefault('dec','')




<div id="Content">
<h1>Cone search for all catalogs</h1>



    <form method="post" action="/cone_search">
      <table >
      <tr> <td class="error" colspan="2"> {{error}} </td></tr>
        <tr>
          <td >
            Catalog
          </td>
          <td>
            <select name="catalogs" id="catalogs" multiple="multiple" style="width:370px" required>
               %for c in catalogs:
               <optgroup label="Fermi">
                 <option value="{{c}}">{{c}} </option>
               </optgroup>
               % end
            </select> *
          </td>
        </tr>
        <tr>
          <td >
            Ra
          </td>
          <td>
            <input type="text" name="ra"  value="{{ra}}" required> *
          </td>

        </tr>

        <tr>
          <td >
           dec
          </td>
          <td>
            <input type="text" name="dec" value="{{dec}}" required> *
          </td>

        </tr>
         <tr>
           <td > Radius (arcmin) </td>
           <td>
            <select name="radius">
                 <option value="0.5">0.5 </option>
                 <option value="1">1 </option>
                 <option value="2">2 </option>
                 <option value="5" selected>5 </option>
                 <option value="10">10 </option>
                 <option value="30">30 </option>
                 <option value="60">60</option>
                 <option value="90">90</option>
                 <option value="120">120</option>
                 <option value="180">180</option>
            </select>
          </td>
        </tr>

        <tr>
          <td>

            <button type="submit">search</button>
          </td>
        </tr>

    </table>

    </form>
</div>

