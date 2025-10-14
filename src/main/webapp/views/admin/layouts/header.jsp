<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter, java.util.Locale" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy", Locale.ENGLISH);
    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("h:mm a");
    request.setAttribute("currentDate", now.format(dateFormatter));
    request.setAttribute("currentTime", now.format(timeFormatter));
%>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin | Clinique Digitale</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <script>
        tailwind.config = {
            darkMode: 'class',
        }
    </script>

    <style>
        * { font-family: 'Inter', sans-serif; }
    </style>

    <script>
        if (localStorage.theme === 'dark') {
            document.documentElement.classList.add('dark')
        }
    </script>
</head>
<body class="bg-gray-50 dark:bg-gray-900">

