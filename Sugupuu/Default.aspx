﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head runat="server">
        <title>Elizabeth II sugupuu</title>
    </head>
    <body>
        <h1>Sugupuu uülesannete lahendamine</h1>
        <form id="form1" runat="server">
            <div>
                <asp:Xml ID="xml" runat="server" DocumentSource="~/Sugupuu.xml" TransformSource="~/XSLTFileSugupuu.xslt" />
            </div>
        </form>
    </body>
</html>