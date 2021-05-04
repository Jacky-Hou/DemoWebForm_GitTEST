using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class NumericHelper
    {
        public string ToChinese(long mValue, bool mUnitEnable = false)
        {
            string[] number = { "零", "壹", "貳", "叁", "肆", "伍", "陸", "柒", "捌", "玖" };
            string[] unit = { "", "拾", "佰", "仟", "萬", "拾", "佰", "仟", "億", "拾", "佰", "仟", "兆", "拾", "佰", "仟" };
            string strValue = mValue.ToString();
            string strChinese = "";
            if (mValue > 9999999999999999)
            {
                return "";
            }
            if (strValue.Substring(0, 1).Equals("-"))
            {
                strChinese = "負的";
                strValue = strValue.Substring(1, strValue.Length - 1);
            }
            if (strValue.Substring(0, 1).Equals("+"))
            {
                //strChinese = "正的";
                strValue = strValue.Substring(1, strValue.Length - 1);
            }

            for (int i = 0; i < strValue.Length; i++)
            {
                strChinese = strChinese + number[Convert.ToInt32(strValue.Substring(i, 1))];
                if (mUnitEnable.Equals(true))
                    strChinese = strChinese + unit[(strValue.Length - (i + 1)) % 16];
            }

            return strChinese;
        }

        public string ToTW_Numeric(long value)
        {
            string TW_Value = "";
            string Temp = value.ToString();
            string[] ChineseNum = { "零", "一", "二", "三", "四", "五", "六", "七", "八", "九" }; //個位
            string[] ChineseUnit = { "", "十", "百", "千", "萬", "十萬", "百萬", "千萬", "億", "十億", "百億", "千億", "兆", "十兆", "百兆", "千兆" }; //單位
            int Num_Len = value.ToString().Length;
            if (Num_Len > 0)
            {
                for (int i = 0; i < Temp.Length; i++)
                {
                    if (i == 0 && Temp.Substring(0, 1) == "1" && (Num_Len == 2 || Num_Len == 6 || Num_Len == 10 || Num_Len == 14))
                    { }
                    else
                        TW_Value = TW_Value + (((Num_Len > 1 && Temp.Substring(i, 1) == "0")) ? "" : ChineseNum[Convert.ToInt32(Temp.Substring(i, 1))]);
                    TW_Value = TW_Value + ((Num_Len > 1 && Temp.Substring(i, 1) == "0") ? "" : ChineseUnit[(Temp.Length - (i + 1)) % 16]);
                }
            }
            return TW_Value;
        }

        public bool IsNumeric(string text) { double _out; return double.TryParse(text, out _out); }
    }
}
