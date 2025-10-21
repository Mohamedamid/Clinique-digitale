<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String activePage = "appointments";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard - Digital Clinic</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .doctor-card {
            transition: all 0.3s ease;
        }
        .doctor-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.1);
        }
        .search-highlight {
            animation: slideIn 0.3s ease;
        }
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .gradient-avatar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .sidebar-active {
            background-color: rgb(219, 234, 254);
            color: rgb(37, 99, 235);
        }
        .dark .sidebar-active {
            background-color: rgba(30, 58, 138, 0.2);
            color: rgb(96, 165, 250);
        }
    </style>
    <script>
        tailwind.config = { darkMode: 'class' }

        function initDarkMode() {
            if (localStorage.getItem('theme') === 'dark') {
                document.documentElement.classList.add('dark');
            }
        }

        function toggleDarkMode() {
            document.documentElement.classList.toggle('dark');
            localStorage.setItem('theme', document.documentElement.classList.contains('dark') ? 'dark' : 'light');
        }

        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('overlay');
            sidebar.classList.toggle('-translate-x-full');
            overlay.classList.toggle('hidden');
        }

        function searchDoctors() {
            const searchTerm = document.getElementById('search-input').value.toLowerCase();
            const specialty = document.getElementById('specialty-filter').value.toLowerCase();
            const cards = document.querySelectorAll('.doctor-card');
            let visibleCount = 0;

            cards.forEach(card => {
                const name = card.querySelector('.doctor-name').textContent.toLowerCase();
                const doctorSpecialty = card.querySelector('.doctor-specialty').textContent.toLowerCase();

                const matchesSearch = name.includes(searchTerm) || searchTerm === '';
                const matchesSpecialty = specialty === 'all' || doctorSpecialty.includes(specialty);

                if (matchesSearch && matchesSpecialty) {
                    card.classList.remove('hidden');
                    card.classList.add('search-highlight');
                    visibleCount++;
                } else {
                    card.classList.add('hidden');
                    card.classList.remove('search-highlight');
                }
            });

            updateResultCount(visibleCount, cards.length);
        }

        function updateResultCount(visible, total) {
            const countEl = document.getElementById('result-count');
            if (visible === 0) {
                countEl.textContent = 'No doctors found';
            } else {
                countEl.textContent = visible + ' of ' + total + ' doctors';
            }
        }

        function updateClock() {
            const now = new Date();
            const options = {
                weekday: 'short',
                year: 'numeric',
                month: 'short',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            };
            document.getElementById('current-time').textContent = now.toLocaleDateString('en-US', options);
        }

        setInterval(updateClock, 1000);

        document.addEventListener('DOMContentLoaded', function() {
            initDarkMode();
            updateClock();
            document.getElementById('search-input').addEventListener('input', searchDoctors);
            document.getElementById('specialty-filter').addEventListener('change', searchDoctors);
            updateResultCount(document.querySelectorAll('.doctor-card:not(.hidden)').length, document.querySelectorAll('.doctor-card').length);
        });
    </script>
</head>
<body class="bg-gray-50 dark:bg-gray-900 transition-colors">
<%@include file="layouts/sidebar.jsp"%>

<!-- Mobile Overlay -->
<div id="overlay" class="fixed inset-0 bg-black bg-opacity-50 z-40 lg:hidden hidden" onclick="toggleSidebar()"></div>

<!-- Main Content -->
<div class="lg:ml-64">
    <!-- Header -->
    <header class="bg-white dark:bg-gray-800 shadow-sm sticky top-0 z-30 border-b border-gray-200 dark:border-gray-700">
        <div class="flex items-center justify-between px-4 lg:px-8 py-4">
            <div class="flex items-center gap-4">
                <button onclick="toggleSidebar()" class="lg:hidden p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700 transition">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
                    </svg>
                </button>
                <div>
                    <h2 class="text-2xl font-bold text-gray-900 dark:text-white">Welcome back</h2>
                    <p class="text-sm text-gray-600 dark:text-gray-400">${userName}</p>
                </div>
            </div>
            <div class="flex items-center gap-4">
                <span id="current-time" class="text-sm text-gray-600 dark:text-gray-400 hidden sm:block"></span>
                <button onclick="toggleDarkMode()" class="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-700 transition">
                    <svg class="w-5 h-5 hidden dark:block" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"/>
                    </svg>
                    <svg class="w-5 h-5 dark:hidden" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" clip-rule="evenodd"/>
                    </svg>
                </button>
            </div>
        </div>
    </header>

    <main class="p-4 lg:p-8 max-w-7xl mx-auto">
        <!-- Search Section -->
        <div class="bg-white dark:bg-gray-800 rounded-2xl shadow-sm border border-gray-200 dark:border-gray-700 p-6 mb-8">
            <h2 class="text-lg font-bold text-gray-900 dark:text-white mb-6">Find Your Doctor</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <!-- Search Input -->
                <div class="md:col-span-2">
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Search by Name</label>
                    <div class="relative">
                        <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                        <input type="text" id="search-input" placeholder="Search doctor by name..."
                               class="w-full pl-10 pr-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent dark:bg-gray-700 dark:text-white transition">
                    </div>
                </div>

                <!-- Specialty Filter -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Specialty</label>
                    <select id="specialty-filter" class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent dark:bg-gray-700 dark:text-white transition">
                        <option value="all">All Specialties</option>
                        <c:forEach var="specialty" items="${specialties}">
                            <option value="${specialty.name}">${specialty.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <!-- Results Count -->
            <div class="mt-4 flex items-center justify-between">
                <p id="result-count" class="text-sm text-gray-600 dark:text-gray-400"></p>
                <button onclick="document.getElementById('search-input').value=''; document.getElementById('specialty-filter').value='all'; searchDoctors();"
                        class="text-sm text-blue-600 dark:text-blue-400 hover:text-blue-700 font-medium transition">
                    Clear Filters
                </button>
            </div>
        </div>

        <!-- Available Doctors -->
        <div class="bg-white dark:bg-gray-800 rounded-2xl shadow-sm border border-gray-200 dark:border-gray-700 p-6">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-lg font-bold text-gray-900 dark:text-white">Available Doctors</h2>
                <a href="${pageContext.request.contextPath}/patient/appointments" class="text-blue-600 dark:text-blue-400 hover:text-blue-700 text-sm font-medium transition">
                    My Appointments →
                </a>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                <!-- Doctor Cards -->
                <c:forEach var="doctor" items="${doctors}">
                    <div class="doctor-card bg-gray-50 dark:bg-gray-700 rounded-xl border border-gray-200 dark:border-gray-600 p-5 hover:border-blue-500 dark:hover:border-blue-400">
                        <!-- Avatar -->
                        <div class="w-14 h-14 gradient-avatar rounded-xl flex items-center justify-center text-white font-bold text-lg mb-4">
                            <c:choose>
                                <c:when test="${not empty doctor.fullName}">
                                    ${fn:substring(doctor.fullName,0,1)}
                                </c:when>
                                <c:otherwise>Dr</c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Info -->
                        <h3 class="doctor-name text-base font-bold text-gray-900 dark:text-white mb-1">Dr. ${doctor.fullName}</h3>
                        <p class="doctor-specialty text-xs text-blue-600 dark:text-blue-400 font-semibold mb-4">
                            <c:choose>
                                <c:when test="${not empty doctor.specialiteName}">
                                    ${doctor.specialiteName}
                                </c:when>
                                <c:otherwise>General Practitioner</c:otherwise>
                            </c:choose>
                        </p>

                        <!-- Button -->
                        <a href="${pageContext.request.contextPath}/patient/doctors/${doctor.id}"
                           class="w-full px-3 py-2 bg-blue-600 hover:bg-blue-700 text-white text-sm rounded-lg transition font-medium text-center block">
                            Book Now
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>
</div>
</body>
</html>