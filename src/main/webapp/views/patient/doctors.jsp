<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dr. ${doctor.user.fullName} - Profile | Digital Clinic</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <style>
        .hero-gradient {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .avatar-gradient {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .stat-card {
            transition: all 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-4px);
        }
        .info-badge {
            animation: slideIn 0.4s ease;
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

        function submitBooking(e) {
            e.preventDefault();
            const selectedDate = document.getElementById('selected-date').value;
            
            if (!selectedDate) {
                alert('Please select a date');
                return;
            }

            document.getElementById('appointment-form').submit();
        }

        document.addEventListener('DOMContentLoaded', function() {
            initDarkMode();

            const availableDays = [
                <c:forEach var="day" items="${availableDays}" varStatus="status">
                "${day}"<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ];

            if (availableDays.length > 0) {
                flatpickr("#calendar", {
                    dateFormat: "Y-m-d",
                    enable: availableDays,
                    altInput: true,
                    altFormat: "D, d M Y",
                    minDate: "today",
                    locale: {
                        firstDayOfWeek: 1
                    },
                    onChange: function(selectedDates, dateStr) {
                        document.getElementById('selected-date').value = dateStr;
                        document.getElementById('date-display').textContent = new Date(dateStr).toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
                    }
                });
            }
        });
    </script>
</head>
<body class="bg-gray-50 dark:bg-gray-900 transition-colors">
<!-- Header -->
<header class="bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 sticky top-0 z-40">
    <div class="max-w-7xl mx-auto px-4 lg:px-8 py-4 flex items-center justify-between">
        <a href="${pageContext.request.contextPath}/patient/index" class="flex items-center gap-2 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
            </svg>
            <span>Back</span>
        </a>
        <button onclick="toggleDarkMode()" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700 transition">
            <svg class="w-5 h-5 hidden dark:block" fill="currentColor" viewBox="0 0 20 20">
                <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"/>
            </svg>
            <svg class="w-5 h-5 dark:hidden" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" clip-rule="evenodd"/>
            </svg>
        </button>
    </div>
</header>

<main class="max-w-6xl mx-auto px-4 lg:px-8 py-8">
    <!-- Success Message -->
    <c:if test="${not empty sessionScope.success}">
        <div class="mb-6 p-4 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-lg text-green-800 dark:text-green-300">
                ${sessionScope.success}
        </div>
        <%session.removeAttribute("success");%>
    </c:if>

    <!-- Doctor Header -->
    <div class="bg-white dark:bg-gray-800 rounded-2xl shadow-sm border border-gray-200 dark:border-gray-700 p-8 mb-8">
        <div class="flex flex-col md:flex-row gap-8">
            <!-- Avatar -->
            <div class="flex-shrink-0">
                <div class="w-40 h-40 avatar-gradient rounded-2xl flex items-center justify-center text-white shadow-lg">
                    <span class="text-6xl font-bold">${fn:substring(doctor.user.fullName, 0, 1)}</span>
                </div>
            </div>

            <!-- Info -->
            <div class="flex-1">
                <h1 class="text-4xl font-bold text-gray-900 dark:text-white mb-2">
                    Dr. ${doctor.user.fullName}
                </h1>
                <c:if test="${not empty doctor.specialite.name}">
                    <p class="text-xl text-blue-600 dark:text-blue-400 font-semibold mb-4">
                            ${doctor.specialite.name}
                    </p>
                </c:if>

                <!-- Rating -->
                <div class="flex items-center gap-2 mb-6">
                    <div class="flex gap-1">
                        <c:forEach var="i" begin="1" end="5">
                            <svg class="w-5 h-5 text-yellow-400 fill-current" viewBox="0 0 20 20">
                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                            </svg>
                        </c:forEach>
                    </div>
                    <span class="text-lg font-bold text-gray-900 dark:text-white">4.8</span>
                    <span class="text-sm text-gray-600 dark:text-gray-400">(238 reviews)</span>
                </div>

                <!-- Stats -->
                <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                    <div class="stat-card p-4 bg-gray-50 dark:bg-gray-700 rounded-lg">
                        <p class="text-xs text-gray-600 dark:text-gray-400 mb-1">Experience</p>
                        <p class="text-lg font-bold text-gray-900 dark:text-white">15+ years</p>
                    </div>
                    <div class="stat-card p-4 bg-gray-50 dark:bg-gray-700 rounded-lg">
                        <p class="text-xs text-gray-600 dark:text-gray-400 mb-1">Patients</p>
                        <p class="text-lg font-bold text-gray-900 dark:text-white">3,200+</p>
                    </div>
                    <div class="stat-card p-4 bg-gray-50 dark:bg-gray-700 rounded-lg">
                        <p class="text-xs text-gray-600 dark:text-gray-400 mb-1">Verified</p>
                        <p class="text-lg font-bold text-green-600 dark:text-green-400">100%</p>
                    </div>
                    <div class="stat-card p-4 bg-gray-50 dark:bg-gray-700 rounded-lg">
                        <p class="text-xs text-gray-600 dark:text-gray-400 mb-1">Consultation</p>
                        <p class="text-lg font-bold text-gray-900 dark:text-white">$150</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Left Column - About -->
        <div class="lg:col-span-2 space-y-8">
            <!-- About -->
            <div class="bg-white dark:bg-gray-800 rounded-2xl shadow-sm border border-gray-200 dark:border-gray-700 p-8">
                <h2 class="text-2xl font-bold text-gray-900 dark:text-white mb-4">About</h2>
                <p class="text-gray-700 dark:text-gray-300 leading-relaxed mb-4">
                    Dr. ${doctor.user.fullName} is a highly experienced and compassionate healthcare professional with a passion for delivering exceptional patient care. With over 15 years of clinical experience, they have established themselves as a trusted expert in their field.
                </p>
                <p class="text-gray-700 dark:text-gray-300 leading-relaxed">
                    Known for their thorough approach and excellent bedside manner, they take time to understand each patient's unique needs and concerns, ensuring personalized treatment plans and the best possible outcomes.
                </p>
            </div>

            <!-- Qualifications -->
            <div class="bg-white dark:bg-gray-800 rounded-2xl shadow-sm border border-gray-200 dark:border-gray-700 p-8">
                <h2 class="text-2xl font-bold text-gray-900 dark:text-white mb-6">Qualifications</h2>
                <div class="space-y-4">
                    <div class="flex gap-4">
                        <div class="w-12 h-12 bg-blue-100 dark:bg-blue-900/50 rounded-lg flex items-center justify-center flex-shrink-0">
                            <svg class="w-6 h-6 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C6.5 6.253 2 10.998 2 17.25m20-11.002c5.5 0 10 4.747 10 11.002M15 6.253v13"/>
                            </svg>
                        </div>
                        <div>
                            <p class="text-sm text-gray-600 dark:text-gray-400">Medical Degree</p>
                            <p class="font-semibold text-gray-900 dark:text-white">M.D. - Harvard Medical School</p>
                        </div>
                    </div>
                    <div class="flex gap-4">
                        <div class="w-12 h-12 bg-green-100 dark:bg-green-900/50 rounded-lg flex items-center justify-center flex-shrink-0">
                            <svg class="w-6 h-6 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                        <div>
                            <p class="text-sm text-gray-600 dark:text-gray-400">Specialization</p>
                            <c:if test="${not empty doctor.specialite.name}">
                                <p class="font-semibold text-gray-900 dark:text-white">${doctor.specialite.name}</p>
                            </c:if>
                        </div>
                    </div>
                    <div class="flex gap-4">
                        <div class="w-12 h-12 bg-purple-100 dark:bg-purple-900/50 rounded-lg flex items-center justify-center flex-shrink-0">
                            <svg class="w-6 h-6 text-purple-600 dark:text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 00.948-.684l1.498-4.493a1 1 0 011.502-.684l1.498 4.493a1 1 0 00.948.684H19a2 2 0 012 2v2a2 2 0 01-2 2H5a2 2 0 01-2-2V5z"/>
                            </svg>
                        </div>
                        <div>
                            <p class="text-sm text-gray-600 dark:text-gray-400">Languages</p>
                            <p class="font-semibold text-gray-900 dark:text-white">English, Spanish, French, Arabic</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column - Booking -->
        <div class="lg:col-span-1">
            <div class="bg-white dark:bg-gray-800 rounded-2xl shadow-sm border border-gray-200 dark:border-gray-700 p-8 sticky top-24">
                <h3 class="text-2xl font-bold text-gray-900 dark:text-white mb-6">Book Appointment</h3>

                <form id="appointment-form" action="${pageContext.request.contextPath}/patient/appointments" method="post" onsubmit="submitBooking(event)" class="space-y-5">
                    <input type="hidden" name="doctorId" value="${doctor.id}">
                    <input type="hidden" id="selected-date" name="date">

                    <!-- Calendar -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Select Date</label>
                        <input id="calendar" type="text" placeholder="Pick a date..."
                               class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent dark:bg-gray-700 dark:text-white transition">
                    </div>

                    <!-- Selected Date Display -->
                    <div class="p-3 bg-blue-50 dark:bg-blue-900/20 rounded-lg border border-blue-200 dark:border-blue-800">
                        <p class="text-xs text-gray-600 dark:text-gray-400 mb-1">Selected Date</p>
                        <p id="date-display" class="font-semibold text-blue-900 dark:text-blue-300">Not selected</p>
                    </div>

                    <!-- Submit -->
                    <button type="submit"
                            class="w-full px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white rounded-lg transition font-semibold shadow-md hover:shadow-lg">
                        Confirm Booking
                    </button>
                </form>

                <!-- Info -->
                <div class="mt-4 p-3 bg-green-50 dark:bg-green-900/20 rounded-lg border border-green-200 dark:border-green-800">
                    <p class="text-xs text-green-800 dark:text-green-300 text-center">
                        ✓ Free cancellation up to 24 hours before
                    </p>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>