<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter, java.util.Locale" %>
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
    <title>Dashboard - Clinique Digitale</title>

    <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Crect fill='%232563eb' width='100' height='100' rx='20'/%3E%3Cpath fill='white' d='M50 25 L50 45 L30 45 L30 55 L50 55 L50 75 L60 75 L60 55 L80 55 L80 45 L60 45 L60 25 Z'/%3E%3C/svg%3E">

    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <script>
        tailwind.config = {
            darkMode: 'class',
        }
    </script>

    <style>
        * {
            font-family: 'Inter', sans-serif;
        }

        .fade-in {
            animation: fadeIn 0.6s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .hover-lift {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .hover-lift:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        }

        .nav-item {
            transition: all 0.2s ease;
        }

        .nav-item:hover {
            background: rgba(59, 130, 246, 0.1);
        }

        .nav-item.active {
            background: rgba(59, 130, 246, 0.15);
            color: #2563eb;
            font-weight: 600;
        }

        .sidebar {
            background: white;
            border-right: 1px solid #e5e7eb;
        }

        .dark .sidebar {
            background: #1f2937;
            border-right-color: #374151;
        }
    </style>

    <script>
        if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            document.documentElement.classList.add('dark')
        }
    </script>
</head>
<body class="bg-white dark:bg-gray-900 text-gray-900 dark:text-white antialiased">

<!-- Sidebar -->
<aside class="sidebar fixed left-0 top-0 h-screen w-64 z-50 hidden lg:block">
    <div class="flex flex-col h-full">

        <!-- Logo -->
        <div class="flex items-center h-16 px-6 border-b border-gray-200 dark:border-gray-700">
            <div class="flex items-center space-x-3">
                <div class="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
                    <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"/>
                    </svg>
                </div>
                <div>
                    <h1 class="text-base font-bold">Clinique Digitale</h1>
                    <p class="text-xs text-gray-500 dark:text-gray-400">Patient Portal</p>
                </div>
            </div>
        </div>

        <!-- Navigation -->
        <nav class="flex-1 px-3 py-4 overflow-y-auto">
            <div class="space-y-1">
                <a href="#" class="nav-item active flex items-center px-3 py-2.5 rounded-lg text-sm font-medium">
                    <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"/>
                    </svg>
                    Dashboard
                </a>

                <a href="#" class="nav-item flex items-center px-3 py-2.5 rounded-lg text-sm font-medium text-gray-700 dark:text-gray-300">
                    <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"/>
                    </svg>
                    Appointments
                    <span class="ml-auto bg-blue-600 text-white text-xs px-2 py-0.5 rounded-full">3</span>
                </a>

                <a href="#" class="nav-item flex items-center px-3 py-2.5 rounded-lg text-sm font-medium text-gray-700 dark:text-gray-300">
                    <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/>
                    </svg>
                    Doctors
                </a>

                <a href="#" class="nav-item flex items-center px-3 py-2.5 rounded-lg text-sm font-medium text-gray-700 dark:text-gray-300">
                    <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                        <path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/>
                    </svg>
                    Medical Records
                </a>

                <a href="#" class="nav-item flex items-center px-3 py-2.5 rounded-lg text-sm font-medium text-gray-700 dark:text-gray-300">
                    <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M6 2a2 2 0 00-2 2v12a2 2 0 002 2h8a2 2 0 002-2V7.414A2 2 0 0015.414 6L12 2.586A2 2 0 0010.586 2H6zm2 10a1 1 0 10-2 0v3a1 1 0 102 0v-3zm2-3a1 1 0 011 1v5a1 1 0 11-2 0v-5a1 1 0 011-1zm4-1a1 1 0 10-2 0v7a1 1 0 102 0V8z" clip-rule="evenodd"/>
                    </svg>
                    Prescriptions
                </a>

                <a href="#" class="nav-item flex items-center px-3 py-2.5 rounded-lg text-sm font-medium text-gray-700 dark:text-gray-300">
                    <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"/>
                        <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"/>
                    </svg>
                    Messages
                    <span class="ml-auto bg-red-600 text-white text-xs px-2 py-0.5 rounded-full">2</span>
                </a>
            </div>

            <!-- Settings Section -->
            <div class="mt-6 pt-6 border-t border-gray-200 dark:border-gray-700">
                <p class="px-3 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">Account</p>
                <div class="space-y-1">
                    <a href="#" class="nav-item flex items-center px-3 py-2.5 rounded-lg text-sm font-medium text-gray-700 dark:text-gray-300">
                        <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"/>
                        </svg>
                        Profile
                    </a>

                    <a href="#" class="nav-item flex items-center px-3 py-2.5 rounded-lg text-sm font-medium text-gray-700 dark:text-gray-300">
                        <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd"/>
                        </svg>
                        Settings
                    </a>
                </div>
            </div>
        </nav>

        <!-- User Profile -->
        <div class="px-3 py-4 border-t border-gray-200 dark:border-gray-700">
            <div class="flex items-center px-3">
                <div class="w-10 h-10 bg-blue-600 rounded-full flex items-center justify-center">
                    <span class="text-white text-sm font-semibold">${userName.substring(0, 1).toUpperCase()}</span>
                </div>
                <div class="ml-3 flex-1 min-w-0">
                    <p class="text-sm font-semibold truncate">${userName}</p>
                    <p class="text-xs text-gray-500 dark:text-gray-400 truncate">${userEmail}</p>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="p-2 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg">
                    <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                    </svg>
                </a>
            </div>
        </div>
    </div>
</aside>

<!-- Main Content -->
<div class="lg:ml-64">

    <!-- Top Bar -->
    <header class="fixed top-0 right-0 left-0 lg:left-64 z-40 bg-white/95 dark:bg-gray-900/95 backdrop-blur-md shadow-sm">
        <div class="flex items-center justify-between h-16 px-6">

            <!-- Mobile Menu Button -->
            <button id="mobileMenuBtn" class="lg:hidden p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
                </svg>
            </button>

            <!-- Search -->
            <div class="hidden md:flex flex-1 max-w-md mx-4">
                <div class="relative w-full">
                    <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                    <input type="text" placeholder="Search..." class="w-full pl-10 pr-4 py-2 bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600 text-sm">
                </div>
            </div>

            <!-- Right Actions -->
            <div class="flex items-center space-x-3">
                <button id="themeToggle" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800">
                    <svg class="w-5 h-5 hidden dark:block" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"/>
                    </svg>
                    <svg class="w-5 h-5 dark:hidden" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" clip-rule="evenodd"/>
                    </svg>
                </button>

                <button class="relative p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
                    </svg>
                    <span class="absolute top-1 right-1 w-2 h-2 bg-red-600 rounded-full"></span>
                </button>

                <div class="hidden sm:flex items-center space-x-2">
                    <div class="w-9 h-9 bg-blue-600 rounded-full flex items-center justify-center">
                        <span class="text-white text-sm font-semibold">${userName.substring(0, 1).toUpperCase()}</span>
                    </div>
                    <div class="text-right">
                        <p class="text-sm font-semibold">${userName}</p>
                        <p class="text-xs text-gray-500 dark:text-gray-400">Patient</p>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Page Content -->
    <main class="pt-20 p-6 bg-gray-50 dark:bg-gray-800 min-h-screen">

        <!-- Page Header -->
        <div class="mb-8 fade-in">
            <div class="flex items-center space-x-2 mb-2">
                <span class="w-2 h-2 bg-blue-600 rounded-full animate-pulse"></span>
                <span class="text-sm font-medium text-blue-600">Welcome back</span>
            </div>
            <h1 class="text-3xl font-bold mb-1">Good afternoon, ${userName}!</h1>
            <p class="text-sm text-gray-600 dark:text-gray-400">${currentDate} • ${currentTime}</p>
        </div>

        <!-- Stats Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <div class="hover-lift bg-white dark:bg-gray-700 rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-blue-100 dark:bg-blue-900/30 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                    <span class="text-xs font-semibold text-green-600">+12%</span>
                </div>
                <p class="text-3xl font-bold mb-1">3</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Upcoming Appointments</p>
            </div>

            <div class="hover-lift bg-white dark:bg-gray-700 rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-green-100 dark:bg-green-900/30 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                            <path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                </div>
                <p class="text-3xl font-bold mb-1">12</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Medical Records</p>
            </div>

            <div class="hover-lift bg-white dark:bg-gray-700 rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-purple-100 dark:bg-purple-900/30 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-purple-600" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M6 2a2 2 0 00-2 2v12a2 2 0 002 2h8a2 2 0 002-2V7.414A2 2 0 0015.414 6L12 2.586A2 2 0 0010.586 2H6zm2 10a1 1 0 10-2 0v3a1 1 0 102 0v-3zm2-3a1 1 0 011 1v5a1 1 0 11-2 0v-5a1 1 0 011-1zm4-1a1 1 0 10-2 0v7a1 1 0 102 0V8z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                    <span class="inline-flex items-center px-2 py-1 bg-green-50 dark:bg-green-900/20 text-green-600 text-xs font-semibold rounded-full">Active</span>
                </div>
                <p class="text-3xl font-bold mb-1">5</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Prescriptions</p>
            </div>

            <div class="hover-lift bg-white dark:bg-gray-700 rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 bg-orange-100 dark:bg-orange-900/30 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-orange-600" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"/>
                            <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"/>
                        </svg>
                    </div>
                    <span class="text-xs font-semibold text-red-600">2 New</span>
                </div>
                <p class="text-3xl font-bold mb-1">8</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Messages</p>
            </div>
        </div>

        <!-- Main Grid -->
        <div class="grid lg:grid-cols-3 gap-8">

            <!-- Appointments Column -->
            <div class="lg:col-span-2 space-y-6">

                <!-- Next Appointment -->
                <div class="bg-white dark:bg-gray-700 rounded-xl shadow-md p-6">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-xl font-bold">Next Appointment</h2>
                        <a href="#" class="text-sm font-medium text-blue-600 hover:text-blue-700">View all →</a>
                    </div>

                    <div class="bg-gradient-to-r from-blue-50 to-blue-100 dark:from-blue-900/20 dark:to-blue-800/20 rounded-xl p-6">
                        <div class="flex items-start justify-between mb-4">
                            <div class="flex items-center space-x-4">
                                <div class="w-14 h-14 bg-blue-600 rounded-full flex items-center justify-center">
                                    <span class="text-white font-bold text-lg">SJ</span>
                                </div>
                                <div>
                                    <h3 class="font-bold text-lg">Dr. Sarah Johnson</h3>
                                    <p class="text-sm text-gray-600 dark:text-gray-400">Cardiology Specialist</p>
                                </div>
                            </div>
                            <span class="inline-flex items-center px-3 py-1 bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400 text-xs font-semibold rounded-full">Confirmed</span>
                        </div>

                        <div class="grid grid-cols-2 gap-4 mb-4">
                            <div class="bg-white dark:bg-gray-800 rounded-lg p-3">
                                <p class="text-xs text-gray-500 dark:text-gray-400 mb-1">Date</p>
                                <p class="font-semibold">October 15, 2025</p>
                            </div>
                            <div class="bg-white dark:bg-gray-800 rounded-lg p-3">
                                <p class="text-xs text-gray-500 dark:text-gray-400 mb-1">Time</p>
                                <p class="font-semibold">10:30 AM</p>
                            </div>
                        </div>

                        <div class="flex gap-3">
                            <button class="flex-1 bg-blue-600 text-white px-6 py-3 rounded-lg font-medium hover:bg-blue-700 transition-colors shadow-md">
                                Join Video Call
                            </button>
                            <button class="px-6 py-3 border-2 border-blue-600 text-blue-600 rounded-lg font-medium hover:bg-blue-50 dark:hover:bg-blue-900/20 transition-colors">
                                Reschedule
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Upcoming Appointments -->
                <div class="bg-white dark:bg-gray-700 rounded-xl shadow-md p-6">
                    <h2 class="text-xl font-bold mb-6">Upcoming</h2>

                    <div class="space-y-4">
                        <div class="flex items-center justify-between p-4 bg-gray-50 dark:bg-gray-600 rounded-lg">
                            <div class="flex items-center space-x-3">
                                <div class="w-12 h-12 bg-green-100 dark:bg-green-900/30 rounded-full flex items-center justify-center">
                                    <span class="text-green-600 font-bold">MC</span>
                                </div>
                                <div>
                                    <p class="font-semibold">Dr. Michael Chen</p>
                                    <p class="text-sm text-gray-600 dark:text-gray-400">Oct 18, 2:00 PM • General Medicine</p>
                                </div>
                            </div>
                            <span class="inline-flex items-center px-3 py-1 bg-yellow-100 dark:bg-yellow-900/30 text-yellow-700 dark:text-yellow-400 text-xs font-semibold rounded-full">Pending</span>
                        </div>

                        <div class="flex items-center justify-between p-4 bg-gray-50 dark:bg-gray-600 rounded-lg">
                            <div class="flex items-center space-x-3">
                                <div class="w-12 h-12 bg-purple-100 dark:bg-purple-900/30 rounded-full flex items-center justify-center">
                                    <span class="text-purple-600 font-bold">EM</span>
                                </div>
                                <div>
                                    <p class="font-semibold">Dr. Emily Martinez</p>
                                    <p class="text-sm text-gray-600 dark:text-gray-400">Oct 22, 11:00 AM • Dermatology</p>
                                </div>
                            </div>
                            <span class="inline-flex items-center px-3 py-1 bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-400 text-xs font-semibold rounded-full">Scheduled</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar Column -->
            <div class="space-y-6">

                <!-- Quick Actions -->
                <div class="bg-white dark:bg-gray-700 rounded-xl shadow-md p-6">
                    <h2 class="text-xl font-bold mb-6">Quick Actions</h2>

                    <div class="grid grid-cols-2 gap-3">
                        <button class="p-4 bg-gray-50 dark:bg-gray-600 hover:bg-gray-100 dark:hover:bg-gray-500 rounded-lg transition-colors text-left">
                            <svg class="w-8 h-8 text-blue-600 mb-2" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"/>
                            </svg>
                            <p class="font-semibold text-sm">Book</p>
                        </button>

                        <button class="p-4 bg-gray-50 dark:bg-gray-600 hover:bg-gray-100 dark:hover:bg-gray-500 rounded-lg transition-colors text-left">
                            <svg class="w-8 h-8 text-green-600 mb-2" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                                <path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/>
                            </svg>
                            <p class="font-semibold text-sm">Records</p>
                        </button>

                        <button class="p-4 bg-gray-50 dark:bg-gray-600 hover:bg-gray-100 dark:hover:bg-gray-500 rounded-lg transition-colors text-left">
                            <svg class="w-8 h-8 text-purple-600 mb-2" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0z"/>
                            </svg>
                            <p class="font-semibold text-sm">Doctors</p>
                        </button>

                        <button class="p-4 bg-gray-50 dark:bg-gray-600 hover:bg-gray-100 dark:hover:bg-gray-500 rounded-lg transition-colors text-left">
                            <svg class="w-8 h-8 text-orange-600 mb-2" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"/>
                                <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"/>
                            </svg>
                            <p class="font-semibold text-sm">Messages</p>
                        </button>
                    </div>
                </div>

                <!-- Health Summary -->
                <div class="bg-white dark:bg-gray-700 rounded-xl shadow-md p-6">
                    <h2 class="text-xl font-bold mb-6">Health Summary</h2>

                    <div class="space-y-4">
                        <div class="flex justify-between">
                            <span class="text-sm text-gray-600 dark:text-gray-400">Blood Type</span>
                            <span class="font-semibold">A+</span>
                        </div>
                        <div class="flex justify-between border-t dark:border-gray-600 pt-4">
                            <span class="text-sm text-gray-600 dark:text-gray-400">Allergies</span>
                            <span class="font-semibold">None</span>
                        </div>
                        <div class="flex justify-between border-t dark:border-gray-600 pt-4">
                            <span class="text-sm text-gray-600 dark:text-gray-400">Insurance</span>
                            <span class="font-semibold">CNSS</span>
                        </div>
                    </div>

                    <button class="w-full mt-6 px-4 py-2 border-2 border-gray-300 dark:border-gray-600 rounded-lg font-medium hover:border-blue-600 dark:hover:border-blue-600 transition-colors">
                        Update Profile
                    </button>
                </div>
            </div>
        </div>
    </main>
</div>

<script>
    // Theme Toggle
    const themeToggle = document.getElementById('themeToggle');
    const html = document.documentElement;

    themeToggle.addEventListener('click', () => {
        html.classList.toggle('dark');
        localStorage.theme = html.classList.contains('dark') ? 'dark' : 'light';
    });

    // Mobile Menu
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const sidebar = document.querySelector('aside');

    mobileMenuBtn?.addEventListener('click', () => {
        sidebar.classList.toggle('hidden');
    });

    // Initialize dark mode
    if (localStorage.theme === 'dark') {
        html.classList.add('dark');
    }
</script>

</body>
</html>
