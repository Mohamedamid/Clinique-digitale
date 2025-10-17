<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <title>جدول المواعيد</title>
    <link href="https://cdn.tailwindcss.com" rel="stylesheet">
</head>
<body class="bg-gray-50 p-4">

<h1 class="text-2xl font-bold mb-4">جدول المواعيد</h1>

<table class="w-full bg-white rounded shadow">
    <tr class="bg-gray-200">
        <th>التاريخ</th>
        <th>الوقت</th>
        <th>المريض</th>
        <th>الحالة</th>
        <th>إجراءات</th>
    </tr>
    <tr>
        <td>2025-10-16</td>
        <td>09:00</td>
        <td>John Smith</td>
        <td>PLANNED</td>
        <td><button class="bg-blue-500 text-white px-2 rounded">Edit</button>
            <button class="bg-red-500 text-white px-2 rounded">Delete</button></td>
    </tr>
    <tr>
        <td>2025-10-16</td>
        <td>10:00</td>
        <td>Sarah Johnson</td>
        <td>DONE</td>
        <td><button class="bg-blue-500 text-white px-2 rounded">View</button></td>
    </tr>
</table>

</body>
</html>
