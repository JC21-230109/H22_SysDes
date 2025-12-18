package servlet.registcontra;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sql_temp.ConnectSQL;

@WebServlet("/limit")
public class LimitServlet extends HttpServlet {

  protected void doPost(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {

    req.setCharacterEncoding("UTF-8");

    String mode = req.getParameter("mode");
    String contraCode = req.getParameter("contraCode");
    int year = Integer.parseInt(req.getParameter("year"));
    int month = Integer.parseInt(req.getParameter("month"));

    /* ===== 業者名取得 ===== */
    String contraName = null;
    try{
      PreparedStatement st =
        ConnectSQL.getSt(
          "SELECT CONTRA_NAME FROM CONTRAR WHERE CONTRA_CODE=?");
      st.setString(1, contraCode);
      ResultSet rs = st.executeQuery();
      if(rs.next()){
        contraName = rs.getString(1);
      }
    }catch(Exception e){ throw new ServletException(e); }

    /* ===== 決定ボタン ===== */
    if("view".equals(mode)){
      Map<String, Map<String,Integer>> limitMap = new HashMap<>();

      try{
        PreparedStatement st =
          ConnectSQL.getSt(
            "SELECT AVAIL_DEL_DATETIME, MAX_DELIVERY_COUNT " +
            "FROM DATE_CONTRA WHERE CONTRA_CODE=? " +
            "AND TO_CHAR(AVAIL_DEL_DATETIME,'YYYY-MM')=?");

        st.setString(1, contraCode);
        st.setString(2, year+"-"+String.format("%02d",month));
        ResultSet rs = st.executeQuery();

        while(rs.next()){
          String dt = rs.getString(1);
          int cnt = rs.getInt(2);

          String date = dt.substring(0,10);
          String hh = dt.substring(11,13);

          limitMap.putIfAbsent(date,new HashMap<>());
          if("09".equals(hh)){
            limitMap.get(date).put("AM",cnt);
          }else if("13".equals(hh)){
            limitMap.get(date).put("PM",cnt);
          }
        }
      }catch(Exception e){ throw new ServletException(e); }

      req.setAttribute("contraCode",contraCode);
      req.setAttribute("contraName",contraName);
      req.setAttribute("year",year);
      req.setAttribute("month",month);
      req.setAttribute("limitMap",limitMap);

      req.getRequestDispatcher("/limitform.jsp").forward(req,res);
      return;
    }

    /* ===== 登録 ===== */
    if("save".equals(mode)){
      try{
        PreparedStatement del =
          ConnectSQL.getSt(
            "DELETE FROM DATE_CONTRA WHERE CONTRA_CODE=? " +
            "AND TO_CHAR(AVAIL_DEL_DATETIME,'YYYY-MM')=?");
        del.setString(1,contraCode);
        del.setString(2,year+"-"+String.format("%02d",month));
        del.executeUpdate();

        PreparedStatement ins =
          ConnectSQL.getSt(
            "INSERT INTO DATE_CONTRA VALUES(?,?,?)");

        for(String name : req.getParameterMap().keySet()){
          if(name.startsWith("am_") || name.startsWith("pm_")){
            String val = req.getParameter(name);
            if(val==null || val.isEmpty()) continue;

            String date = name.substring(3);
            String time = name.startsWith("am_") ? "09:00:00":"13:00:00";

            ins.setString(1, date+" "+time);
            ins.setString(2, contraCode);
            ins.setInt(3, Integer.parseInt(val));
            ins.executeUpdate();
          }
        }
      }catch(Exception e){ throw new ServletException(e); }

      req.getRequestDispatcher("/limit.jsp").forward(req,res);
    }
  }
}
