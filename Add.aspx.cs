using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Add : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(Helper.GetConnection());
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetCategories();
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "INSERT INTO Products VALUES (@Name, @CatID, @Code, @Description, " +
            "@Image, @Price, @IsFeatured, @Available, @CriticalLevel, @Maximum, @Status, " +
            "@DateAdded, @DateModified)";
        cmd.Parameters.AddWithValue("@Name", txtName.Text);
        cmd.Parameters.AddWithValue("@CatID", ddlCategories.SelectedValue);
        cmd.Parameters.AddWithValue("@Code", txtCode.Text);
        cmd.Parameters.AddWithValue("@Description", txtDesc.Text);

        string fileExt = Path.GetExtension(fuImage.FileName);
        string id = Guid.NewGuid().ToString();
        cmd.Parameters.AddWithValue("@Image", id + fileExt);
        fuImage.SaveAs(Server.MapPath("~/img/products/" + id + fileExt));

        cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
        cmd.Parameters.AddWithValue("@IsFeatured", ddlFeatured.SelectedValue);
        cmd.Parameters.AddWithValue("@Available", 0);
        cmd.Parameters.AddWithValue("@CriticalLevel", txtCritical.Text);
        cmd.Parameters.AddWithValue("@Maximum", txtMax.Text);

        cmd.Parameters.AddWithValue("@Status", "Active");
        cmd.Parameters.AddWithValue("@DateAdded", DateTime.Now);
        cmd.Parameters.AddWithValue("@DateModified", DBNull.Value);
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
}