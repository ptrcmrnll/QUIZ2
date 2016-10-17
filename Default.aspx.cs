using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(Helper.GetConnection());
    protected void Page_Load(object sender, EventArgs e)
    {
        GetProducts();
    }
    protected void lvProducts_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpProducts.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
    }
    protected void lvProducts_DataBound(object sender, EventArgs e)
    {
        dpProducts.Visible = dpProducts.PageSize < dpProducts.TotalRowCount;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (txtKeyword.Text == "")
        {
            GetProducts();
        }
        else
        {
            GetProducts(txtKeyword.Text);
        }
    }
    void GetProducts()
    {
        con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "SELECT Products.ProductID, Products.Name, Categories.Category, " +
            "Products.Code, Products.Description, Products.Image, Products.Price, " +
            "Products.IsFeatured, Products.DateAdded, Products.DateModified, Products.Status " +
            "FROM Products INNER JOIN Categories ON Products.CatID = Categories.CatID";
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "Products");
        lvProducts.DataSource = ds;
        lvProducts.DataBind();
        con.Close();
    }

    void GetProducts(string keyword)
    {
        using (SqlConnection con = new SqlConnection(Helper.GetConnection()))
        {
            con.Open();
            string SQL = @"SELECT p.ProductID, p.Name, c.Category, p.Description, 
                                p.Image, p.Price, p.IsFeatured, p.DateAdded, p.DateModified 
                                FROM Products p INNER JOIN Categories c ON p.CatID = c.CatID WHERE 
                                ProductID Like @keyword OR
                                Name Like @keyword OR
                                Category Like @keyword OR
                                Description Like @keyword OR
                                Image Like @keyword OR
                                Price Like @keyword OR
                                IsFeatured Like @keyword";

            using (SqlCommand cmd = new SqlCommand(SQL, con))
            {
                cmd.Parameters.AddWithValue("@keyword", "%" + keyword + "%");

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataSet ds = new DataSet();
                    da.Fill(ds, "Products");

                    lvProducts.DataSource = ds;
                    lvProducts.DataBind();
                }
            }
        }
    }   
}