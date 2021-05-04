<%@ Page Language="C#" MasterPageFile="~/TW/Inc/Basic.Master" AutoEventWireup="true" CodeBehind="ugC_Member_Final.aspx.cs" Inherits="WebSite.TW.Member.ugC_Member_Final" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="PageTitleWrapper">
        <header class="PageTitle">
            <p class="BreadCrumbs"><a href="/tw/home/" title="回首頁">首頁</a> &gt; <a href="/tw/member" title="會員專區">會員專區</a> &gt; 會員申請完成</p>
            <h1>會員申請完成</h1>
        </header>
    </div>

    <section class="PageContent">
        <article class="PageArticle">
            <div id="tbContent">
                <div class="ProcessFlow">
                    <div class="Step_o"><span class="No">1</span><span class="Name">填寫基本資料</span></div>
                    <div class="Step_o"><span class="No">2</span><span class="Name">完成註冊</span></div>
                </div>
                <p class="Center">您好，歡迎您成為uGear 優吉兒網站設計的一份子，您將收到一封確認電子郵件。</p>
            </div>
        </article>
    </section>
</asp:Content>
