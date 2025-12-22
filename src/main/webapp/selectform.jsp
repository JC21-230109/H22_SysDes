<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>予約キャンセル／更新</title>

<style>
/* 全体 */
body {
    font-family: "Meiryo", sans-serif;
    background-color: #f0f2f5;
    margin: 0;
    padding: 0;
}

/* 中央コンテナ */
.container {
    max-width: 500px;
    margin: 60px auto;
    background: #ffffff;
    padding: 40px 30px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

/* 見出し */
h2 {
    text-align: center;
    margin-bottom: 15px;
    color: #333;
}

/* 説明文 */
p {
    text-align: center;
    color: #666;
    font-size: 14px;
    margin-bottom: 30px;
}

/* ラベル */
label {
    display: block;
    font-weight: bold;
    margin-bottom: 6px;
    color: #444;
}

/* 入力欄 */
input[type="text"] {
    width: 100%;
    padding: 12px 14px;
    margin-bottom: 20px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 8px;
    box-sizing: border-box;
    transition: border-color 0.3s;
}

input[type="text"]:focus {
    border-color: #007BFF;
    outline: none;
}

/* エラーメッセージ */
.error {
    background-color: #ffe0e0;
    color: #c00;
    padding: 12px;
    border-radius: 8px;
    margin-bottom: 20px;
    font-size: 14px;
    text-align: center;
}

/* ボタン全体 */
.buttons {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

/* 上段ボタン */
.top-buttons {
    display: flex;
    gap: 10px;
}

/* 下段ボタン */
.bottom-buttons button {
    width: 100%;
}

/* ボタン共通 */
button {
    flex: 1;
    font-size: 16px;
    padding: 12px 0;
    border-radius: 8px;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s, color 0.3s;
}

/* 戻るボタン */
.bottom-buttons button,
button[type="button"] {
    background-color: #e0e0e0;
    color: #333;
}

.bottom-buttons button:hover,
button[type="button"]:hover {
    background-color: #d0d0d0;
}

/* 更新ボタン */
button[name="actionType"][value="update"] {
    background-color: #007BFF;
    color: #fff;
}

button[name="actionType"][value="update"]:hover {
    background-color: #0056b3;
}

/* キャンセルボタン */
button[name="actionType"][value="cancel"] {
    background-color: #dc3545;
    color: #fff;
}

button[name="actionType"][value="cancel"]:hover {
    background-color: #a71d2a;
}

/* スマホ対応 */
@media (max-width: 500px) {
    .container {
        margin: 40px 20px;
        padding: 30px 20px;
    }
    .top-buttons {
        flex-direction: column;
    }
    button {
        flex: 1 1 100%;
    }
}
</style>
</head>

<body>

<div class="container">

<h2>配達予約更新・キャンセル</h2>
<p>※配達予定日の2日前まで可能です</p>

<%-- エラーメッセージ表示 --%>
<%
String errorMessage = (String) request.getAttribute("errorMessage");
if (errorMessage != null) {
%>
<div class="error"><%= errorMessage %></div>
<%
}
%>

<form action="cancel" method="post">

    <label>予約番号</label>
    <input type="text"
           name="reservationCode"
           placeholder="半角10桁数字"
           required>

    <div class="buttons">
        <!-- 上段: 更新 と キャンセル -->
        <div class="top-buttons">
            <button type="submit" name="actionType" value="update">更新</button>
            <button type="submit" name="actionType" value="cancel">キャンセル</button>
        </div>

        <!-- 下段: 戻る -->
        <div class="bottom-buttons">
            <button type="button" onclick="location.href='index2.html'">戻る</button>
        </div>
    </div>

</form>

</div>

</body>
</html>
