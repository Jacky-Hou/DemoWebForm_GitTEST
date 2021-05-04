using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebTest
{
    public partial class GoogleCalender : System.Web.UI.Page
    {
        string redirect_url = @"http://localhost:6972/GoogleCalender.aspx";  //xml檔
        string client_id = "688618300957-c4tls6am8bbroc9tsmdd9jv5rh4ouk1c.apps.googleusercontent.com";  //xml檔
        string client_secret = "de6O2BzSUORvdCYNeG4qfGqv";  //xml檔
        string refresh_token = "1//0eI_17lAp7GBPCgYIARAAGA4SNwF-L9Ir7jRRopkHfA-xsg0V-jm8YA7AHeOb_Y6KoLzZHb2YuiQdIobey5nmEAWQCzHMD2lIz4g";  //xml檔
        string share_calender_id = "c9l3tq7ruvi0i0n1drmkvc771s@group.calendar.google.com"; //xml檔

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string code = Request["code"];
                string state = Request["state"];

                if (code != null)
                {
                    switch (state)
                    {
                        case "Subscribe":
                            AddSubscribe(code);
                            break;
                        case "ReferenceToke":
                            GetReferenceToke(code);
                            break;
                    }
                }
            }
        }

        protected void btn_Subscribe_Click(object sender, EventArgs e)
        {
            //Start 取使用者權限
            string state = "Subscribe";
            string scope = "https://www.googleapis.com/auth/calendar https://www.googleapis.com/auth/userinfo.email";
            string oauthURL = "https://accounts.google.com/o/oauth2/auth?" +
                            "scope={0}&redirect_uri={1}&response_type=code&client_id={2}&access_type=offline&prompt=consent&state={3}";
            oauthURL = string.Format(oauthURL,
                            HttpUtility.HtmlDecode(scope),
                            HttpUtility.HtmlDecode(redirect_url),
                            HttpUtility.HtmlDecode(client_id),
                            HttpUtility.HtmlDecode(state));

            HttpContext.Current.Response.Redirect(oauthURL);
            //End 取使用者權限

        }

        protected void btn_Who_Subscribe_Click(object sender, EventArgs e)
        {
            string AccessToken = GetAccessToken();
            string ShareList = string.Format("https://www.googleapis.com/calendar/v3/calendars/{0}/acl?", share_calender_id);
            string result = GetMethod(ShareList, AccessToken);
            JObject resJson = JObject.Parse(result);
            JArray items = resJson.Value<JArray>("items");
            JObject scope;
            HtmlGenericControl p;
            int i = 0;
            foreach (var J in items)
            {
                scope = J.Value<JObject>("scope");
                if (J.Value<string>("role") == "reader" && scope.Value<string>("type") == "user")
                {
                    p = new HtmlGenericControl("p");
                    p.InnerText ="帳號: " +  J.Value<string>("id").Split(':')[1];
                    div_Who_Subscribe.Controls.Add(p);
                    i++;
                }

            }

            if (i == 0)
                p_Count.InnerText += "訂閱數: 0";
            else
                p_Count.InnerText = "訂閱數: " + i.ToString();

        }

        protected void btn_Create_Reference_Token_Click(object sender, EventArgs e)
        {
            //Start 取使用者權限
            string state = "ReferenceToke";
            string scope = " https://www.googleapis.com/auth/userinfo.email";
            string oauthURL = "https://accounts.google.com/o/oauth2/auth?" +
                            "scope={0}&redirect_uri={1}&response_type=code&client_id={2}&access_type=offline&prompt=consent&state={3}";
            oauthURL = string.Format(oauthURL,
                            HttpUtility.HtmlDecode(scope),
                            HttpUtility.HtmlDecode(redirect_url),
                            HttpUtility.HtmlDecode(client_id),
                            HttpUtility.HtmlDecode(state));

            HttpContext.Current.Response.Redirect(oauthURL);
            //End 取使用者權限
        }

        protected void GetReferenceToke(string authorization_code)
        {
            string TokenUrl = string.Format("https://www.googleapis.com/oauth2/v4/token");
            string queryString = @"code={0}&client_id={1}&client_secret={2}&redirect_uri={3}&grant_type=authorization_code";
            string postContent = string.Format(queryString,
                                        HttpUtility.HtmlEncode(authorization_code),
                                        HttpUtility.HtmlEncode(client_id),
                                        HttpUtility.HtmlEncode(client_secret),
                                        HttpUtility.HtmlEncode(redirect_url));

            string result = PostMethod(TokenUrl, postContent);
            JObject resJson = JObject.Parse(result);
            p_reference_token.InnerText += resJson.Value<string>("refresh_token");
        }


        protected void AddSubscribe(string authorization_code)
        {
            try
            {
                //Start 取使用者驗證後資料
                string TokenUrl = string.Format("https://www.googleapis.com/oauth2/v4/token");
                string queryString = @"code={0}&client_id={1}&client_secret={2}&redirect_uri={3}&grant_type=authorization_code";
                string postContent = string.Format(queryString,
                                            HttpUtility.HtmlEncode(authorization_code),
                                            HttpUtility.HtmlEncode(client_id),
                                            HttpUtility.HtmlEncode(client_secret),
                                            HttpUtility.HtmlEncode(redirect_url));

                string result = PostMethod(TokenUrl, postContent);
                JObject resJson = JObject.Parse(result);
                //string refresh_token = resJson.Value<string>("refresh_token");
                string id_token = resJson.Value<string>("id_token");
                JwtSecurityTokenHandler handler = new JwtSecurityTokenHandler();
                JwtPayload jwtPayload = handler.ReadJwtToken(id_token).Payload;
                //End 取使用者驗證後資料

                //主要共享Access_token
                string AccessToken = GetAccessToken();

                //Start 共享日歷
                string ShareUrl = string.Format("https://www.googleapis.com/calendar/v3/calendars/{0}/acl?", share_calender_id);
                JObject JO = new JObject();
                JO.Add("role", "reader");
                JObject Scope = new JObject();
                Scope.Add("type", "user");
                Scope.Add("value", jwtPayload["email"].ToString());
                JO.Add("scope", Scope);
                PostMethod(ShareUrl, JO.ToString(), AccessToken);
                //Emd 共享日歷

                p_State.InnerText = "訂閱完成，請至Email信箱新增訂閱";
            }
            catch (Exception ex)
            {
                p_State.InnerText = "訂閱失敗 " + ex.Message;
            }
        }

        protected string PostMethod(string url, string postContent, string token = "")
        {
            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(url);
            request.Method = "POST";
            if (token == "")
                request.ContentType = "application/x-www-form-urlencoded";
            else
            {
                request.Headers.Add("Authorization", "Bearer " + token);
                request.Accept = "application/json";
                request.ContentType = "application/json; charset=utf-8";
            }
            using (var sw = new StreamWriter(request.GetRequestStream()))
                sw.Write(postContent);

            string result = "";
            using (var response = request.GetResponse())
            using (var sr = new StreamReader(response.GetResponseStream()))
                result = sr.ReadToEnd();

            return result;
        }

        protected string GetMethod(string url, string token)
        {
            HttpWebRequest requestGet = (HttpWebRequest)HttpWebRequest.Create(url);
            requestGet.Method = "GET";
            requestGet.Headers.Add("Authorization", "Bearer " + token);
            requestGet.Accept = "application/json";
            string result = "";
            using (var response = requestGet.GetResponse())
            using (var sr = new StreamReader(response.GetResponseStream()))
                result = sr.ReadToEnd();

            return result;
        }


        protected string GetAccessToken()
        {
            string queryString = @"client_id={0}&client_secret={1}&refresh_token={2}&grant_type=refresh_token";
            string postContent = string.Format(queryString,
                                        HttpUtility.HtmlEncode(client_id),
                                        HttpUtility.HtmlEncode(client_secret),
                                        HttpUtility.HtmlEncode(refresh_token));

            string result = PostMethod("https://www.googleapis.com/oauth2/v4/token", postContent);
            JObject resJson = JObject.Parse(result);
            return resJson.Value<string>("access_token");
        }
    }
}