<%@ Page Language="C#" MasterPageFile="~/TW/Inc/Basic.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="WebSite.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="DefAlbumSlide">
        <div class="swiper-container swiper-container3">
            <div class="swiper-wrapper" id="ul_album" runat="server"></div>
            <div class="swiper-pagination swiper-pagination-container3"></div>
        </div>
    </div>
</asp:Content>