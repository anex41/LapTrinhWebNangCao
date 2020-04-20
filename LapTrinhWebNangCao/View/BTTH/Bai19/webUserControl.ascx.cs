using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LapTrinhWebNangCao.View.BTTH.Bai19
{
    public partial class webUserControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                classList.DataSource = getClassInfo();
                subjectList.DataSource = getSubjectInfo();
                classList.DataTextField = "name";
                subjectList.DataTextField = "name";
                classList.DataValueField = "id";
                subjectList.DataValueField = "id";
                classList.DataBind();
                subjectList.DataBind();
            }
        }

        private List<Class> getClassInfo()
        {
            List<Class> lstClass = new List<Class>()
                {
                   new Class(1,"B1"),
                   new Class(2,"c2"),
                   new Class(3,"D3"),
                   new Class(4,"E4"),
                   new Class(5,"F5"),
                   new Class(6,"G6"),
                   new Class(7,"H7"),
                   new Class(8,"I8"),
                   new Class(9,"K9"),
                   new Class(10,"L10")
                };
            return lstClass;
        }

        private List<SubjectB20> getSubjectInfo()
        {
            List<SubjectB20> lstSubject = new List<SubjectB20>()
                {
                    new SubjectB20(1,"VB.NET"),
                    new SubjectB20(2,"ASP.NET"),
                    new SubjectB20(3,"Lập trình hệ thống"),
                    new SubjectB20(4,"Giải tích"),
                    new SubjectB20(5,"Nhập môn CNPM"),
                    new SubjectB20(6,"Angular"),
                    new SubjectB20(7,"Lập trình di động"),
                    new SubjectB20(8,"Vuejs"),
                    new SubjectB20(9,"nodejs"),
                    new SubjectB20(10,"Xác suất thống kê")
                };
            return lstSubject;
        }
    }
}