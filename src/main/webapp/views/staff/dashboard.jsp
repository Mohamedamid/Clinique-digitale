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
    <title>Staff Dashboard - Clinique Digitale</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <script>
        tailwind.config = { darkMode: 'class' }
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

<!-- Sidebar -->
<aside class="fixed left-0 top-0 h-screen w-64 bg-white dark:bg-gray-800 border-r border-gray-200 dark:border-gray-700 hidden lg:block">
    <div class="flex flex-col h-full">
        <div class="h-16 px-6 flex items-center border-b border-gray-200 dark:border-gray-700">
            <div class="flex items-center space-x-3">
                <div class="w-8 h-8 bg-blue-600 rounded-lg flex items-center justify-center">
                    <svg class="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"/>
                    </svg>
                </div>
                <span class="font-semibold text-gray-900 dark:text-white">Clinique Digitale</span>
            </div>
        </div>

        <nav class="flex-1 p-4">
            <a href="${pageContext.request.contextPath}/staff/dashboard" class="flex items-center px-4 py-3 mb-1 bg-blue-50 dark:bg-blue-900/20 text-blue-600 rounded-lg">
                <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"/>
                </svg>
                <span class="font-medium">Dashboard</span>
            </a>

            <a href="${pageContext.request.contextPath}/staff/appointments" class="flex items-center px-4 py-3 mb-1 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg">
                <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"/>
                </svg>
                <span class="font-medium">Manage Appointments</span>
            </a>

            <a href="${pageContext.request.contextPath}/staff/patients" class="flex items-center px-4 py-3 mb-1 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg">
                <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/>
                </svg>
                <span class="font-medium">Patients</span>
            </a>

            <a href="${pageContext.request.contextPath}/staff/waitlist" class="flex items-center px-4 py-3 mb-1 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg">
                <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                    <path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/>
                </svg>
                <span class="font-medium">Waiting List</span>
            </a>

            <a href="${pageContext.request.contextPath}/staff/schedule" class="flex items-center px-4 py-3 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg">
                <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd"/>
                </svg>
                <span class="font-medium">Global Schedule</span>
            </a>
        </nav>

        <div class="p-4 border-t border-gray-200 dark:border-gray-700">
            <div class="flex items-center">
                <div class="w-10 h-10 bg-blue-600 rounded-full flex items-center justify-center">
                    <span class="text-white font-semibold">${userName.substring(0, 1).toUpperCase()}</span>
                </div>
                <div class="ml-3 flex-1">
                    <p class="text-sm font-semibold text-gray-900 dark:text-white">${userName}</p>
                    <p class="text-xs text-gray-500 dark:text-gray-400">Staff</p>
                </div>
                <a href="${pageContext.request.contextPath}/logout">
                    <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                    </svg>
                </a>
            </div>
        </div>
    </div>
</aside>

<!-- Main -->
<div class="lg:ml-64">
    <header class="h-16 bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 flex items-center justify-between px-6">
        <div>
            <h1 class="text-xl font-semibold text-gray-900 dark:text-white">Staff Dashboard</h1>
        </div>
        <button id="themeToggle" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">
            <svg class="w-5 h-5 hidden dark:block" fill="currentColor" viewBox="0 0 20 20">
                <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"/>
            </svg>
            <svg class="w-5 h-5 dark:hidden" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" clip-rule="evenodd"/>
            </svg>
        </button>
    </header>

    <main class="p-6">
        <!-- Welcome -->
        <div class="mb-8">
            <h2 class="text-2xl font-bold text-gray-900 dark:text-white mb-1">Welcome back, ${userName}</h2>
            <p class="text-sm text-gray-600 dark:text-gray-400">${currentDate} • ${currentTime}</p>
        </div>

        <!-- Stats -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-2">24</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Today's Appointments</p>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-2">7</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Waiting List</p>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-2">3</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Cancellations</p>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-2">156</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Total Patients</p>
            </div>
        </div>

        <!-- Pending Actions -->
        <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6 mb-6">
            <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Pending Actions</h3>

            <div class="space-y-4">
                <div class="flex items-center justify-between p-4 bg-yellow-50 dark:bg-yellow-900/20 rounded-lg border-l-4 border-yellow-600">
                    <div>
                        <p class="font-semibold text-gray-900 dark:text-white">Reschedule Request</p>
                        <p class="text-sm text-gray-600 dark:text-gray-400">John Smith - Oct 15, 10:00 AM</p>
                    </div>
                    <div class="flex gap-2">
                        <button class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Process</button>
                        <button class="px-4 py-2 border border-gray-200 dark:border-gray-600 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">View</button>
                    </div>
                </div>

                <div class="flex items-center justify-between p-4 bg-red-50 dark:bg-red-900/20 rounded-lg border-l-4 border-red-600">
                    <div>
                        <p class="font-semibold text-gray-900 dark:text-white">Cancellation</p>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Sarah Johnson - Oct 16, 2:00 PM</p>
                    </div>
                    <div class="flex gap-2">
                        <button class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Reassign Slot</button>
                        <button class="px-4 py-2 border border-gray-200 dark:border-gray-600 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">View</button>
                    </div>
                </div>

                <div class="flex items-center justify-between p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg border-l-4 border-blue-600">
                    <div>
                        <p class="font-semibold text-gray-900 dark:text-white">New Patient Registration</p>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Michael Chen - Needs first appointment</p>
                    </div>
                    <div class="flex gap-2">
                        <button class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Book Appointment</button>
                        <button class="px-4 py-2 border border-gray-200 dark:border-gray-600 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">View Profile</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="grid md:grid-cols-3 gap-6">
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <h3 class="font-semibold text-gray-900 dark:text-white mb-4">Quick Book</h3>
                <button class="w-full px-4 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 mb-3">
                    Book New Appointment
                </button>
                <button class="w-full px-4 py-3 border border-gray-200 dark:border-gray-600 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">
                    Check Availability
                </button>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <h3 class="font-semibold text-gray-900 dark:text-white mb-4">Today's Summary</h3>
                <div class="space-y-3">
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Completed</span>
                        <span class="text-sm font-semibold text-green-600">12</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Pending</span>
                        <span class="text-sm font-semibold text-yellow-600">8</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Cancelled</span>
                        <span class="text-sm font-semibold text-red-600">3</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600 dark:text-gray-400">No-show</span>
                        <span class="text-sm font-semibold text-gray-600 dark:text-gray-400">1</span>
                    </div>
                </div>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <h3 class="font-semibold text-gray-900 dark:text-white mb-4">Waiting List</h3>
                <div class="space-y-3">
                    <div class="p-3 bg-gray-50 dark:bg-gray-700 rounded-lg">
                        <p class="font-semibold text-sm text-gray-900 dark:text-white">Dr. Sarah Johnson</p>
                        <p class="text-xs text-gray-600 dark:text-gray-400">3 patients waiting</p>
                    </div>
                    <div class="p-3 bg-gray-50 dark:bg-gray-700 rounded-lg">
                        <p class="font-semibold text-sm text-gray-900 dark:text-white">Dr. Michael Chen</p>
                        <p class="text-xs text-gray-600 dark:text-gray-400">2 patients waiting</p>
                    </div>
                    <div class="p-3 bg-gray-50 dark:bg-gray-700 rounded-lg">
                        <p class="font-semibold text-sm text-gray-900 dark:text-white">Dr. Emily Martinez</p>
                        <p class="text-xs text-gray-600 dark:text-gray-400">2 patients waiting</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<script>
    const themeToggle = document.getElementById('themeToggle');
    const html = document.documentElement;
    themeToggle.addEventListener('click', () => {
        html.classList.toggle('dark');
        localStorage.theme = html.classList.contains('dark') ? 'dark' : 'light';
    });
    if (localStorage.theme === 'dark') html.classList.add('dark');
</script>

</body>
</html>
