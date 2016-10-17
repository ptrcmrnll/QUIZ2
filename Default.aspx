<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Products</title>

    <link href="~/css/bootstrap.css" rel="stylesheet" />
    <link href="~/fonts/font-awesome.min.css" rel="stylesheet" />
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet" />


    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css" />
    <style>
        .navbar {
            margin-bottom: 0;
            border-radius: 0;
        }

        .navbar {
            margin-bottom: 0;
            border-radius: 0;
            background-color: rgba(255,255,255, 0.5);
            color: inherit;
        }



        body {
            background: url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/45544/background-svg.svg) no-repeat center center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }

        .jumbotron {
            background-color: rgba(255,255,255, 0.5);
            color: inherit;
        }

        .well {
            background-color: rgba(255,255,255, 0.5);
            color: inherit;
        }

        th {
            font-family: 'Century Gothic';
        }

        td {
            font-family: 'Century Gothic';
        }

        h1 {
            font-family: 'Century Gothic';
        }
    </style>
</head>
<body>
    <form runat="server" class="form-horizontal">
        <div class="container">
            <br />
            <br />
            <br />
            <div class="col-lg-12">
                <div class="well">

                    <div class="col-lg-12">

                        <h1 class="text-center"><strong>View Products</strong></h1>

                        <hr />
                        <div class="col-lg-3 pull-right">
                            <div class="input-group">
                                <asp:TextBox ID="txtKeyword" runat="server" CssClass="form-control"
                                    placeholder="Keyword...." />
                                <span class="input-group-btn">
                                    <asp:LinkButton ID="btnSearch" runat="server" class="btn btn-info"
                                        OnClick="btnSearch_Click">
                                    <i class="fa fa-search"></i>
                                    </asp:LinkButton>
                                </span>
                            </div>
                        </div>
                    </div>
                   
                    <br />
                    <br />
                    <table class="table table-hover">
                        <thead>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Description</th>
                            <th class="text-center">Image</th>
                            <th>Price</th>
                            <th>Is Featured?</th>
                            
                            <th>Date Added</th>
                            <th>DateModifed</th>
                        </thead>
                        <tbody>
                            <asp:ListView ID="lvProducts" runat="server" OnPagePropertiesChanging="lvProducts_PagePropertiesChanging">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("ProductID")%></td>
                                        <td><%# Eval("Name")%>
                                        <td><%# Eval("Category")%></td>
                                        <td><%# Eval("Description")%></td>
                                        <td>
                                            <img runat="server" src=' <%# string.Concat("~/img/products/", Eval("Image")) %>'
                                                class="img-responsive" width="100" />
                                        </td>
                                        <td><%# Eval("Price", "{0:#,###.00}")%></td>
                                        <td><%# Eval("IsFeatured")%></td>
                                        <td><%# Eval("DateAdded", "{0: MMMM dd, yyyy}") %></td>
                                        <td><%# Eval("DateModified", "{0: MMMM dd, yyyy}") %></td>
                                        <td>
                                            <a href='Details.aspx?ID=<%# Eval("ProductID")%>'
                                                class="btn btn-xs btn-info">
                                                <i class="fa fa-edit"></i>
                                            </a>
                                             <a href='Delete.aspx?ID=<%# Eval("ProductID") %>'
                                                 class="btn btn-xs btn-danger"
                                                 onclick='return confirm("Are you sure?");'>
                                                 <i class="fa fa-trash"></i>
                                             </a>
                                        </td>
                                    </tr>
                                </ItemTemplate>

                                <EmptyDataTemplate>
                                    <tr>
                                        <td colspan="11">
                                            <h2 class="text-center">
                                                No records found!
                                            </h2>
                                        </td>
                                    </tr>
                                </EmptyDataTemplate>
                            </asp:ListView>


                        </tbody>
                    </table>
                    <asp:DataPager ID="dpProducts" runat="server" PageSize="5"
                        PagedControlID="lvProducts">
                        <Fields>
                            <asp:NumericPagerField ButtonType="Button"
                                CurrentPageLabelCssClass="btn btn-info"
                                NumericButtonCssClass="btn"
                                NextPreviousButtonCssClass="btn" />
                        </Fields>
                    </asp:DataPager>


                </div>

            </div>

        </div>

    </form>
</body>
</html>
