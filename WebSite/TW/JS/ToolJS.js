
//後台列印
function SetPrint() {
    //舊版ASP的列印
    /*var iframe = frames["ifrmPrint"].document;
    iframe.open();
    iframe.write(
        '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional //EN" "http://www.w3.org/TR/html4/loose.dtd">' +
        '<html><head><link rel="stylesheet" type="text/css" href="../CSS/ugA_Main.css" media="all" />' +
        '<\/style><\/head><body><\/body><\/html>'
    );
    iframe.close();
    iframe.body.innerHTML = document.getElementById("PrintDescr").innerHTML;

    iframe = document.getElementById("ifrmPrint");
    if (iframe && iframe.contentWindow) {
        iframe.contentWindow.focus();
        iframe.contentWindow.print();
    }*/
    //新版的列印
    var value = document.getElementById("PrintDescr").innerHTML;
    var printPage = window.open("", "Printing...", "");
    printPage.document.open();
    printPage.document.write("<HTML><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><link rel='stylesheet' type='text/css' href='../CSS/ugA_Main.css' media='all' /></head><BODY onload='window.print();window.close()'>");
    printPage.document.write("<PRE>");
    printPage.document.write(value);
    printPage.document.write("</PRE>");
    printPage.document.close("</BODY></HTML>");
}