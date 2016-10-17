using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Details : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(Helper.GetConnection());
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["ID"] != null)
        {
            int productID = 0;
            bool validProduct = int.TryParse(Request.QueryString["ID"].ToString(), out productID);

            if (validProduct)
            {
                if (!IsPostBack)
                {
                    GetCategories();
                    GetInfo(productID);
                }
            }
            else
                Response.Redirect("Default.aspx");
        }
        else
            Response.Redirect("Default.aspx");
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = @"UPDATE Products SET Name=@Name, CatID=@CatID, Code=@Code, 
            Description=@Description, Image=@Image, Price=@Price, IsFeatured=@IsFeatured,
            CriticalLevel=@CriticalLevel, Maximum=@Maximum, DateModified=@DateModified
            WHERE ProductID=@ProductID";

        cmd.Parameters.AddWithValue("@Name", txtName.Text);
        cmd.Parameters.AddWithValue("@CatID", ddlCategories.SelectedValue);
        cmd.Parameters.AddWithValue("@Code", txtCode.Text);
        cmd.Parameters.AddWithValue("@Description", txtDesc.Text);
        if (fuImage.HasFile)
        {
            string fileExt = Path.GetExtension(fuImage.FileName);
            string id = Guid.NewGuid().ToString();
            cmd.Parameters.AddWithValue("@Image", id + fileExt);
            fuImage.SaveAs(Server.MapPath("~/img/products/" + id + fileExt));

        }
            cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
            cmd.Parameters.AddWithValue("@IsFeatured", ddlFeatured.SelectedValue);
            cmd.Parameters.AddWithValue("@Available", 0);
            cmd.Parameters.AddWithValue("@CriticalLevel", txtCritical.Text);
            cmd.Parameters.AddWithValue("@Maximum", txtMax.Text);
            cmd.Parameters.AddWithValue("@DateModified", DateTime.Now);
            cmd.Parameters.AddWithValue("@ProductID", Request.QueryString["ID"].ToString());
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("Default.aspx");
       
    }

    void GetCategories()
    {
        con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "SELECT CatID, Category FROM Categories";
        SqlDataReader dr = cmd.ExecuteReader();
        ddlCategories.DataSource = dr;
        ddlCategories.DataTextField = "Category";
        ddlCategories.DataValueField = "CatID";
        ddlCategories.DataBind();
        con.Close();
    }

    void GetInfo(int ID)
    {
        con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "SELECT ProductID, Name, CatID, Code, Description, Image, " +
            "Price, IsFeatured, CriticalLevel, Maximum FROM Products " +
            "WHERE ProductID=@ProductID";
        cmd.Parameters.AddWithValue("@ProductID", ID);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                ltID.Text = dr["ProductID"].ToString();
                txtName.Text = dr["Name"].ToString();
                ddlCategories.SelectedValue = dr["CatID"].ToString();
                txtCode.Text = dr["Code"].ToString();
                txtDesc.Text = dr["Description"].ToString();
                Session["image"] = dr["Price"].ToString();
                txtPrice.Text = dr["Price"].ToString();
                ddlFeatured.SelectedValue = dr["IsFeatured"].ToString();
                txtCritical.Text = dr["CriticalLevel"].ToString();
                txtMax.Text = dr["Maximum"].ToString();
            }
            Image1.ImageUrl = "~/img/products/" + Session["image"].ToString();
            con.Close();
        }
        else
        {
            con.Close();
            Response.Redirect("Default.aspx");
        }
    }
}
