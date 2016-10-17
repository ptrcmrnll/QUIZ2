<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Add.aspx.cs" Inherits="Add" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Product</title>
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

        label {
            font-family: 'Century Gothic';
            font-size: 16px;
        }
    </style>

</head>
<body>
    <div class="container">
        <br />
        <br />
        <br />
        <div class="col-lg-12">
            <div class="well clearfix">
                <form runat="server" class="form-horizontal">
                    <div class="col-lg-12">
                        <h1 class="text-center"><strong>Add Products </strong></h1>
                        <hr />
                        <div class="col-lg-6">
                        <div class="form-group">
                                <label class="control-label col-lg-4">Name</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="txtName" runat="server"
                                        class="form-control" MaxLength="50" required />
                                </div>
                            </div>
                        

                            <div class="form-group">
                                <label class="control-label col-lg-4">Category</label>
                                <div class="col-lg-8">
                                    <asp:DropDownList ID="ddlCategories" runat="server"
                                        CssClass="form-control" required>
                                        </asp:DropDownList>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="control-label col-lg-4">Code</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="txtCode" runat="server"
                                        class="form-control"
                                        MaxLength="20" required />
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="control-label col-lg-4">Description</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="txtDesc" runat="server"
                                        class="form-control" TextMode="MultiLine"
                                        MaxLength="300" required />
                                </div>
                            </div>
                           
                            <div class="form-group">
                                <label class="control-label col-lg-4">Image</label>
                                <div class="col-lg-8">
                                    <asp:FileUpload ID="fuImage" runat="server"
                                        class="form-control" required />
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="control-label col-lg-4">Price</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="txtPrice" runat="server"
                                        class="form-control" type="number"
                                        min="0.01" max="500000.00" step="0.01" required />
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="control-label col-lg-4">Is Featured</label>
                                <div class="col-lg-8">
                                    <asp:DropDownList ID ="ddlFeatured" runat="server" CssClass="form-control">
                                        <asp:ListItem>Yes</asp:ListItem>
                                        <asp:ListItem>No</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                           
                            <div class="form-group">
                                <label class="control-label col-lg-4">Critical Level</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="txtCritical" runat="server"
                                        class="form-control" autocomplete="off"
                                        MaxLength="80" required />
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="control-label col-lg-4">Maximum</label>
                                <div class="col-lg-8">
                                    <asp:TextBox ID="txtMax" runat="server"
                                        class="form-control" autocomplete="off"
                                        MaxLength="50" required />
                                </div>
                            </div>
                            </div>
                            

                            <div class="form-group">
                                <div class="col-lg-12">
                                    <asp:Button ID="btnAdd" runat="server"
                                        class="btn btn-success pull-right"
                                        Text="Add"  OnClick="btnAdd_Click" />
                                </div>
                            </div>
                        </div>
                </form>
            </div>
        </div>

    </div>
</body>
</html>
