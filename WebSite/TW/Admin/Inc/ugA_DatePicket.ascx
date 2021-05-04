<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ugA_DatePicket.ascx.cs" Inherits="WebSite.TW.Admin.Inc.ugA_DatePicket" %>
<script>
       $(function () {
        var arrDisabledDates = '<%=this.DisabledDateList%>'.split(',');
        var $txbDate = $("#<%=this.txb_Date.ClientID %>");
        $("#<%=this.txb_Date.ClientID %>").datepicker({
			showOn: 'both',
			buttonImage: '../Images/Icon_Calendar.gif',
			buttonImageOnly: true,
			dateFormat: 'yy/mm/dd',
			changeMonth: true,
            changeYear: true,
<%--        minDate: '<%=this.minDate%>',--%>
<%--        beforeShowDay: function(date){
            var string = jQuery.datepicker.formatDate('yy/mm/dd', date);

                if (arrDisabledDates.indexOf(string) != -1) { return [false]; }
                
                var day = date.getDay();
                if (!<%=this.W1.ToString().ToLower()%> && day == 1) { return [false]; }
                if (!<%=this.W2.ToString().ToLower()%> && day == 2) { return [false]; }
                if (!<%=this.W3.ToString().ToLower()%> && day == 3) { return [false]; }
                if (!<%=this.W4.ToString().ToLower()%> && day == 4) { return [false]; }
                if (!<%=this.W5.ToString().ToLower()%> && day == 5) { return [false]; }
                if (!<%=this.W6.ToString().ToLower()%> && day == 6) { return [false]; }
                if (!<%=this.W7.ToString().ToLower()%> && day == 0) { return [false]; } //Sunday

                return [true];
            }--%>
            onSelect: function (selectedDate) {
                
            }
		});

    });
</script>

<asp:TextBox ID="txb_Date" runat="server" MaxLength="10" CssClass="shortForm"></asp:TextBox>
