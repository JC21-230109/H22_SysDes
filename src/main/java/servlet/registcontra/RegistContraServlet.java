package servlet.registcontra;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegistContra")
public class RegistContraServlet extends HttpServlet {

    private static final String DRIVER_NAME =
            "oracle.jdbc.driver.OracleDriver";
    private static final String URL =
            "jdbc:oracle:thin:@192.168.54.222:1521/r07sysdev";
    private static final String USER = "r07sysdev";
    private static final String PASS = "R07SysDev";

    // ===== 初期表示 =====
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> delareaList = new ArrayList<>();

        try {
            Class.forName(DRIVER_NAME);

            try (
                Connection con = DriverManager.getConnection(URL, USER, PASS);
                PreparedStatement ps = con.prepareStatement(
                    "SELECT DELAREA_CODE, DELAREA_NAME FROM DELAREA ORDER BY DELAREA_CODE");
                ResultSet rs = ps.executeQuery()
            ) {
                while (rs.next()) {
                    Map<String, String> area = new HashMap<>();
                    area.put("code", rs.getString("DELAREA_CODE"));
                    area.put("name", rs.getString("DELAREA_NAME"));
                    delareaList.add(area);
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }

        request.setAttribute("delareaList", delareaList);
        request.getRequestDispatcher("registcontra.jsp")
               .forward(request, response);
    }

    // ===== 登録処理 =====
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String contraName   = request.getParameter("contraName");
        String tel          = request.getParameter("tel");
        String delareaCode  = request.getParameter("DELAREA_CODE");
        String password     = request.getParameter("password");

        String errorMsg = null;

        if (contraName == null || contraName.isEmpty()) {
            errorMsg = "業者名を入力してください";
        } else if (tel == null || !tel.matches("\\d{10,11}")) {
            errorMsg = "連絡先はハイフンなし半角数字で入力してください";
        } else if (delareaCode == null || delareaCode.isEmpty()) {
            errorMsg = "担当地域を選択してください";
        } else if (password == null || !password.matches("[a-zA-Z0-9]{6}")) {
            errorMsg = "パスワードは英数字6桁で入力してください";
        }

        if (errorMsg != null) {
            request.setAttribute("errorMsg", errorMsg);
            doGet(request, response);
            return;
        }
        
        // ★ 表示・保存用にハイフン付きへ変換
        tel = tel.replaceFirst("(\\d{3})(\\d{4})(\\d+)", "$1-$2-$3");

        try {
            Class.forName(DRIVER_NAME);

            try (
                Connection con = DriverManager.getConnection(URL, USER, PASS);
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO CONTRA (" +
                    "CONTRA_CODE, CONTRA_NAME, CONTRA_PHONUM, DELAREA_CODE, PASSWORD" +
                    ") " +
                    "SELECT " +
                    "'C' || LPAD(COUNT(*) + 1, 4, '0'), ?, ?, ?, ? " +
                    "FROM CONTRA"
                )
            ) {
                ps.setString(1, contraName);
                ps.setString(2, tel);
                ps.setString(3, delareaCode);
                ps.setString(4, password);
                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "登録処理中にエラーが発生しました");
            doGet(request, response);
            return;
        }

        request.setAttribute("contraName", contraName);
        request.setAttribute("tel", tel);
        request.setAttribute("areaCode", delareaCode);
        request.setAttribute("password", password);

        request.getRequestDispatcher("registcontracomp.jsp")
               .forward(request, response);
    }
}
