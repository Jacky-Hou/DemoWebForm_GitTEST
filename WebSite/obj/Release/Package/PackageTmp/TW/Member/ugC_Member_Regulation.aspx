<%@ Page Language="C#" MasterPageFile="~/TW/Inc/Basic.Master" AutoEventWireup="true" CodeBehind="ugC_Member_Regulation.aspx.cs" Inherits="WebSite.TW.Member.ugC_Member_Regulation" %>

<%@ Register Src="~/TW/Member/ugC_incPageMenuTop.ascx" TagPrefix="uc1" TagName="ugC_incPageMenuTop" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(function () {
            GetMemberRegulation(GetString);

            //Top選單目前位置
            $("#SlideMenu a").removeClass('Active');
            $("#TopVipAdd").addClass('Active');
        })

        function GetMemberRegulation(callback) {
            $.ajax({
                type: "POST",
                url: "ugC_Member_Regulation.aspx/GetMemberRegulation",
                contentType: 'application/json; charset=utf-8'
            }).done(function (res) {
                var jdata = $.parseJSON(res.d);
                var data = $.parseJSON(jdata.MemberRegulationData);
                callback(data);
            })
        }

        function GetString(res) {
            $("#tbContent").append(res[0].Descr);   //取資料庫陣列裡資料
            var GoAddVip = $("#GoAddVip").html();
            $("#tbContent").append(GoAddVip);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="PageTitleWrapper">
        <header class="PageTitle">
            <p class="BreadCrumbs"><a href="/tw/home/Default.aspx" title="回首頁">首頁</a> &gt; <a href="/tw/member/ugC_Member.aspx" title="<%=FrontMenuName%>"><%=FrontMenuName%></a> &gt; <%=CurrentPageName%></p>
            <h1><%=CurrentPageName%></h1>
        </header>
    </div>
    <section class="PageMenuTop">
        <uc1:ugC_incPageMenuTop runat="server" ID="ugC_incPageMenuTop" />
    </section>
    <section class="PageContent">
        <article class="PageArticle">
            <div id="tbContent">
            </div>
        </article>
    </section>

    <script type="text/template" id="GoAddVip">
        <a class="GoBack" href="/tw/Member/ugC_Member.aspx" title="前往加入會員"><i class="fa fa-arrow-right"></i>前往加入會員</a>
    </script>
</asp:Content>
