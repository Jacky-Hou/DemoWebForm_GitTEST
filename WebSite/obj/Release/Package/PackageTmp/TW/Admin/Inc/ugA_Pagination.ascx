<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ugA_Pagination.ascx.cs" Inherits="WebSite.TW.Admin.ugA_Pagination" %>

<script type="text/javascript">
    var ChineseNum = { "0": "", "1": "一", "2": "二", "3": "三", "4": "四", "5": "五", "6": "六", "7": "七", "8": "八", "9": "九" };
    var UnitNum = { "2": "十", "3": "百", "4": "千", "5": "萬" };

    function CheckBoxSelect(Id) {  //使用InClude
        $(".lbut_SelectAll").on('click', function () {  //全選
            $("#Table_List :checkbox").prop('checked', true);
            $.each(Id.All, function (Key, Val) {
                if (Id.Del.indexOf(Val) < 0) {
                    Id.Del.push(Val)
                }
            })
        })

        $(".lbut_NotSelectAll").on('click', function () {   //全取消
            $("#Table_List :checkbox").prop('checked', false);
            Id.Del.length = 0;
        })
    }

    //全選、取消
    function ArrayPushSplice(e, idNum, Id) {
        if ($(e).prop("checked")) {
            if (Id.Del.indexOf(idNum) < 0) {
                Id.Del.push(idNum);
            }
        } else {
            var ArrayIndex = Id.Del.indexOf(idNum);
            Id.Del.splice(ArrayIndex, 1);
        }
    }

    //排序變化
    function SortChange(FirstColunm, Sort, PgNum, ComeBackDesc) {

        if (Par.Sort != "" && Par.Sort == Sort) { //非第一次Page_load之後，按下排序，同一類別排序動作
            if (Par.SortEnter == true)  //點擊標題Sort排序才置換
                Par.Desc = (Par.Desc == "N" ? "Y" : "N")
        } else if (Par.Sort != "" && Par.Sort != Sort) { //非第一次Page_load之後，按下排序，不同類別排序動作
            if (Par.SortEnter == true)  //點擊標題Sort排序才置換
            {
                Par.Desc = "N" //非Desc
                Par.Sort = Sort;
            }
        } else if (Par.Sort == "" && Par.Sort != Sort && Sort == FirstColunm) { //第一次Page_load之後，按下排序，第一欄位"LoginID"排序動作
            if (Par.SortEnter == true)  //點擊標題Sort排序才置換
            {
                Par.Desc = "Y" //Desc
                Par.Sort = Sort;
            }
            else {   //記錄當下排序狀態，離開此頁後瀏覽回來或其他動作繼續使用該記錄排序
                Par.Desc = ComeBackDesc;
                Par.Sort = Sort;
            }
        } else if (Par.Sort == "" && Par.Sort != Sort && Sort != FirstColunm) { //第一次Page_load之後，按下排序，非第一欄位"LoginID"排序動作
            if (Par.SortEnter == true)  //點擊標題Sort排序才置換
            {
                Par.Desc = "N" //非Desc
                Par.Sort = Sort;
            }
            else {  //記錄當下排序狀態，離開此頁後瀏覽回來或其他動作繼續使用該記錄排序
                Par.Desc = ComeBackDesc;
                Par.Sort = Sort;
            }
        }else if(Sort == ""){ //第一次Page_load 無任何紀錄，什麼動作都沒做
            Par.Sort = FirstColunm;
            Par.Desc = "N" //
        }

        Par.PgNum = PgNum;

        return Par;

    }

    var StartPgNum;  //區間分頁起始位置
    var EndPgNum;    //區間分頁結束位置
    var FirstCount;  //第一區間分頁計算
    var NextPgLimit; //總頁與頁數判斷
    var NextNum;     //下幾頁區間位置
    var PrevNuum;    //上幾頁區間位置
    var NextOneNum;  //下一頁

    //分頁 (以按下分頁號碼角度看)
    function DrawPageList(intPgNumCurrent, intPgLimit, intPgTotal, Sort) {

        //intPgNumCurrent 當前頁面
        //intPgLimit      限制分頁數
        //intPgTotal      總分頁數
        //Sort            排序欄位

        var Count = parseInt(intPgNumCurrent / intPgLimit); //當前/限制分頁取整數  ex: 當前5 / 限6分頁 = 0 , ex: 當前12 / 限6分頁 = 2 
        var residue = intPgNumCurrent % intPgLimit;         //當前/限制分頁取餘數  ex: 當前5 / 限6分頁 = 5 , ex: 當前12 / 限6分頁 = 0 

        if ((Count == 0 && residue != 0) || (Count == 1 && residue == 0)) {
            //落在個位數或剛好落在第一區間最後一個可以整除(無餘數)，

            if (Count == 0 && residue != 0)  //在第一區間未整除有餘數 ex:限 6 落在 1~5 分頁
                FirstCount = Count + 1;      //有餘數 倍數加1 總頁從6判斷
            else if (Count == 1 && residue == 0) //第一區間整除 未有餘數 ex:限 6 落在 6 分頁
                FirstCount = Count;          //未有餘數 總頁從6判斷

            if (intPgTotal <= intPgLimit * FirstCount) {
                //總頁 <= 第一區間最後分頁號碼
                StartPgNum = 1;
                EndPgNum = intPgTotal; //第一區間分頁結束在總頁
            } else {
                StartPgNum = 1;
                EndPgNum = intPgLimit; //第一區間分頁結束在限制頁
            }
        }
        else {

            if (Count > 1 && residue == 0) { //第一區間以上可整除無餘數，落在第一區間以上每個區間最後一分頁 ex:限 6 在 12,18,24.....上

                //******************區間落在 Count - 1 與 Count******************//

                //StartPgNum = (Count * intPgLimit) - (intPgLimit - 1);
                StartPgNum = ((Count - 1) * intPgLimit) + 1; //開始在此區間起始位置 ex:限 6 落在 12 區間 7
                EndPgNum = Count * intPgLimit   //結束在該倍數區間尾 ex:限 6 落在 12 區間 12
            } else if (Count >= 1 && residue != 0) { //第一區間以上 不在每個區間最後一分頁 ex:限 6 不在 12,18,24.....上

                //******************區間落在 Count 與 Count + 1******************//

                StartPgNum = Count * intPgLimit + 1;  //開始在此區間起始位置 ex:限 6 落在 12 區間 7
                if (intPgTotal > (Count + 1) * intPgLimit) {
                    //總頁數大於目前區間最後分頁編號
                    EndPgNum = (Count + 1) * intPgLimit;  //結束在該區間尾
                } else if (intPgTotal <= (Count + 1) * intPgLimit) {
                    //總頁數小於等於目前區間最後分頁編號
                    EndPgNum = intPgTotal;  //結束在總數位置
                }
            }
        }


        //上幾頁
        if ((Count == 1 && residue != 0) || Count > 1) { //第一區間以上不可整除有餘數 ex:限 6 在含7分頁以上
            if (residue == 0) {
                //第一區間以上在倍數區間尾 ex:限 6 落在 12 區間 12
                PrevNuum = ((Count - 2) * intPgLimit) + 1; //回到上一區間開頭位置
            }
            else {
                //第一區間以上未在倍數區間尾 ex:限 6 落在 12 區間 9
                PrevNuum = ((Count - 1) * intPgLimit) + 1; //回到上一區間開頭位置
            }
            var PgListNum = $("#PgListNum").html();
            PgListNum = PgListNum.replace(/\%Sort%/g, Sort).replace(/\%Num%/g, PrevNuum).replace(/\%NumName%/g, "上" + NumConverChin(intPgLimit.toString()) + "頁")
            $(".css_PageList").append(PgListNum);
        }

        //上一頁
        if (intPgNumCurrent != 1) {
            var PgListNum = $("#PgListNum").html();
            PgListNum = PgListNum.replace(/\%Sort%/g, Sort).replace(/\%Num%/g, intPgNumCurrent - 1).replace(/\%NumName%/g, "< 上一頁 ")
            $(".css_PageList").append(PgListNum);
        }


        //Draw PageList
        for (i = StartPgNum; i <= EndPgNum; i++) {
            if (i == intPgNumCurrent) {
                $(".css_PageList").append("<span class='current'>" + i + "</span>"); //當前頁面css
            } else {
                var PgListNum = $("#PgListNum").html();
                PgListNum = PgListNum.replace(/\%Sort%/g, Sort).replace(/\%Num%/g, i).replace(/\%NumName%/g, i)
                $(".css_PageList").append(PgListNum);
            }
        }

        //下一頁 Start __若目前頁為最大則下一頁為目前頁

        if (intPgNumCurrent != intPgTotal) {
            var PgListNum = $("#PgListNum").html();
            PgListNum = PgListNum.replace(/\%Sort%/g, Sort).replace(/\%Num%/g, intPgNumCurrent + 1).replace(/\%NumName%/g, " 下一頁 >")
            $(".css_PageList").append(PgListNum);
        }
        //下一頁 End


        //下幾頁 Start
        if (residue == 0) {
            NextPgLimit = Count * intPgLimit;   //可整除則總頁數與當下Count倍數運算判斷 
            NextNum = (Count * intPgLimit) + 1;    //下一區間啟示位置
        }
        else {
            NextPgLimit = (Count + 1) * intPgLimit; //不可整除,有餘數該區間分頁倍數(Count + 1)運算判斷
            NextNum = ((Count + 1) * intPgLimit) + 1;
        }

        if (intPgTotal > NextPgLimit) { //判斷總頁數進入下一區間
            var PgListNum = $("#PgListNum").html();
            PgListNum = PgListNum.replace(/\%Sort%/g, Sort).replace(/\%Num%/g, NextNum).replace(/\%NumName%/g, "下" + NumConverChin(intPgLimit.toString()) + "頁")
            $(".css_PageList").append(PgListNum);
        }
        //下幾頁 End
    }

    //Number Convert Chinese
    function NumConverChin(strNum) {
        var Chin
        if (strNum.length == 1) {
            Chin = ChineseNum[strNum.substr(0, 1)];
        } else if (strNum.length == 2) {
            if (strNum.substr(0, 1) == "1") {
                var Digits = ChineseNum[strNum.substr(1, 1)];
                var Unit = UnitNum[strNum.length.toString()];
                Chin = Unit + Digits;
            } else {
                var Digits = ChineseNum[strNum.substr(1, 1)];
                var TenDigits = ChineseNum[strNum.substr(0, 1)];
                var Unit = UnitNum[strNum.length.toString()];
                Chin = TenDigits + Unit + Digits;
            }
        }
        return Chin;
    }

</script>

<div id="Panel" class="ugA_MenuPageWrapper">
    <div id="Panel_Num" class="ugA_MenuPageLeft">
        <div class='css_PageList'>
        </div>
    </div>
    <div id="Panel_Del" class="ugA_MenuPageRight">
        <a class="lbut_NotSelectAll" href="javascript:void(0)">取消全選</a> | <a class="lbut_SelectAll" href="javascript:void(0)">全選</a>
    </div>
</div>

<script type="text/template" id="PgListNum">
    <a href="javascript:PageListClick(%Num%,'%Sort%')"><span class="css_PageList_EN">%NumName%</span></a>
</script>

<%--<div id="Panel_Top" class="ugA_MenuPageWrapper">
    <div id="Panel_Top_Num" class="ugA_MenuPageLeft"></div>
    <div class="css_PageList"></div>
    <div id="Panel_Top_Del" class="ugA_MenuPageRight">
    <a id="lbut_Top_NotSelectAll" href="javascript:void(0)">取消全選</a>
    <a id="lbut_Top_SelectAll" href="javascript:void(0)">全選</a>
    </div>
</div>--%>

<%--<table id="Table_List" style="width: 100%; border: 0; padding: 0; border-spacing: 0; text-align: center" class="tbStyle01">
</table>--%>

<%--<div id="Panel_Bot" class="ugA_MenuPageWrapper">
    <div id="Panel_Bot_Num" class="ugA_MenuPageLeft css_PageList"></div>
    <div id="Panel_Bot_Del" class="ugA_MenuPageRight"></div>
    <a id="lbut_Bot_NotSelectAll" href="javascript:void(0)">取消全選</a>
    <a id="lbut_Bot_SelectAll" href="javascript:void(0)">全選</a>
</div>--%>
