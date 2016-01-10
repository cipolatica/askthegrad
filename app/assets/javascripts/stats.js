$(function() {
    $('.accordion-toggle').click(function (e) {
        //get html query from target
        alert("hi");

        var element;

        if (e.target.toString() === "[object HTMLSpanElement]") { //the span element is the caret
            //alert("hi again");
            element = e.target;
        } else {
            //alert("nope");
            var queryString = e.target.toString().split("#")[1];
            //alert("queryString: "+queryString.toString() );

            //get element from query string
            element = document.getElementById(queryString + "Caret");
            //alert("element.className: "+element.className.toString() );
        }

        //toggle icon in the element
        if (element.className === "fa fa-caret-right"){
            element.className = "fa fa-caret-down";
        } else {
            element.className = "fa fa-caret-right";
        }
    });
});