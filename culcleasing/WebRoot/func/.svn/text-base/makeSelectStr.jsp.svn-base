<%!
String makeSelectStr(String selectname,int selecthavenull,String selectsql)   // 由sql查询构造select控件
{
    try
    {
        String temp_select=selectsql;
        if ((temp_select==null) || (temp_select.equals("")))
        {
            temp_select="";
        }
        else
        {
            rs=db.executeQuery(temp_select);
            if (selecthavenull==1)
            {
                temp_select="<select name="+selectname+"><option selected=true></option>";
            }
            else
            {
                temp_select="<select name="+selectname+">";
            }
            int temp_selectcount=0;
            while (rs.next())
            {
                 if ((temp_selectcount==0) && (selecthavenull!=1))
                 {
                   temp_select="";
                     temp_select=temp_select+"<option value="+rs.getString(1)+" selected=true>"+rs.getString(2)+"</option>";
                 }
                 else
                 {
                 temp_select="";
                     temp_select=temp_select+"<option value="+rs.getString(1)+">"+rs.getString(2)+"</option>";                                 }
                 }  
           }
           temp_select=temp_select+"</select>"; 
        }
        rs.close();
        return temp_select; 
    }
    catch(Exception e)
    {
    }
    return "";
}
%>
