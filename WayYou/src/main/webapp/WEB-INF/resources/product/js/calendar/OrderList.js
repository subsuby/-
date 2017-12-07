
jQuery(document).ready(function(){

    LayerAutoBuilder({layerParentSelector : "div#layerPopupWrapDiv"});



    $(tableId).hide();
    var tableId = '#table_order_list';
    groupTable($(tableId + ' tr:has(td)'),0,2);
    $(tableId + ' .deleted').remove();
    $(tableId).show();


    var searchStartDt = $('#searchStartDt').parent().datepicker({
                                                      }).on('changeDate', function(ev){
                                                    	if($('#searchEndDt').val() != ""){
                                                          if(ev.date.valueOf() > searchEndDt.date.valueOf()){
                                                              alertify.alert('종료일보다 클 수 없습니다. 날짜를 조정해주세요.');
                                                              //var newDate = new Date(ev.date);
                                                              //searchEndDt.setValue(newDate);
                                                              $('#searchStartDt').val("");
                                                          }
                                                          eval($(this).data("eval"));
                                                    	}
                                                      }).data('datepicker');

    var searchEndDt = $('#searchEndDt').parent().datepicker({
                                                     }).on('changeDate', function(ev){
                                                    	 if($('#searchStartDt').val() != ""){
                                                    		 if(ev.date.valueOf() < searchStartDt.date.valueOf()){
                                                    			 alertify.alert('시작일보다 작을 수 없습니다. 날짜를 조정해주세요.');
                                                    			 $('#searchEndDt').val("");
                                                    		 }
                                                    		 eval($(this).data("eval"));
                                                    	 }
                                                     }).data('datepicker');

    $('#msgProcess > li').on({
        mouseenter: function() {
            $(this).addClass('hover');
        },
        mouseleave: function() {
            $(this).removeClass('hover');
        }
    });

});