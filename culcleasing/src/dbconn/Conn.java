package dbconn;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Conn
{
  private Connection conn;
  private Statement stmt;
  private ResultSet rs;
  private String dataSource;

  public Conn()
  {
    this.conn = null;
    this.stmt = null;
    this.rs = null;
    this.dataSource = "java:comp/env/jdbc/culcleasing";
    try
    {
      Context ctx = new InitialContext();
      DataSource ds = (DataSource)ctx.lookup(this.dataSource);
      this.conn = ds.getConnection();
      this.stmt = this.conn.createStatement(1005, 1008);
    }
    catch (Exception e)
    {
      System.err.println(e.getMessage());
    }
  }

  public ResultSet executeQuery(String sql)
    throws Exception
  {
    return this.stmt.executeQuery(sql);
  }

  public int executeUpdate(String sql)
    throws Exception
  {
    return this.stmt.executeUpdate(sql);
  }
  public Connection getConnection() { return this.conn; }
  public void close()
  {
    try
    {
      if (this.rs != null) {
        this.rs.close();
        this.rs = null; }
      if (this.stmt != null) {
        this.stmt.close();
        this.stmt = null; }
      if (this.conn == null) return;
      this.conn.close();
      this.conn = null;
    } catch (Exception e) {
      System.err.println(e.getMessage());
    }
  }
}