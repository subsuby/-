
function groupTable($rows, startIndex, total){ 
    
    if (total === 0){ 
        return;
    } 
    var i , currentIndex = startIndex, count=1, lst=[];
    var tds = $rows.find('td:eq('+ currentIndex +')');
    var ctrl = $(tds[0]);
    lst.push($rows[0]);
    
    var length = tds.length;

    for (i=1;i<=length;i++){
        if ($.trim(ctrl.text()).replace(/\s+/g, "") ==  $.trim($(tds[i]).text()).replace(/\s+/g, "")){ 
            count++;
            $(tds[i]).addClass('deleted');
            lst.push($rows[i]);
        } 
        else{
          if (count>1){
              ctrl.attr('rowspan',count);
              groupTable($(lst),startIndex+1,total-1); 
          } 
          count=1;
          lst = [];
          ctrl=$(tds[i]);
          lst.push($rows[i]);
          }
        
    } 
} 
