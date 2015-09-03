$(function() {
    $('.accordion-toggle').click(function (e) {
        //get html query from target
        var queryString = e.target.toString().split("#")[1];
        //alert("queryString: "+queryString.toString() );

        //get element from query string
        var element = document.getElementById(queryString + "Caret");
        //alert("element.className: "+element.className.toString() );

        //toggle icon in the element
        if (element.className === "fa fa-caret-down"){
            element.className = "fa fa-caret-up";
        } else {
            element.className = "fa fa-caret-down";
        }
    });
});