<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String activePage = "availability";
%>
<!DOCTYPE html>
<html lang="en" class="h-full bg-gray-50 dark:bg-gray-900">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Availability - Clinique Digitale</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="h-full font-sans">
<div class="flex">
    <%@ include file="layouts/sidebar.jsp"%>

    <div class="flex-1 lg:ml-64">
        <main class="p-6">
            <div class="max-w-7xl mx-auto">
                <!-- Page Header -->
                <div class="mb-8">
                    <h1 class="text-3xl font-bold text-gray-900 dark:text-white">My Availability</h1>
                    <p class="text-gray-600 dark:text-gray-400 mt-2">Manage your working hours and availability</p>
                </div>

                <!-- Flash Messages -->
                <c:if test="${not empty success}">
                    <div class="mb-6 p-4 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-lg">
                        <p class="text-green-800 dark:text-green-200">${success}</p>
                    </div>
                </c:if>
                <c:if test="${not empty errors}">
                    <div class="mb-6 p-4 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-lg">
                        <c:forEach var="error" items="${errors}">
                            <p class="text-red-800 dark:text-red-200">${error.value}</p>
                        </c:forEach>
                    </div>
                </c:if>

                <!-- Main Container -->
                <div class="bg-gradient-to-br from-slate-800 to-slate-900 rounded-lg shadow-md border border-slate-700">
                    <!-- Tabs Navigation -->
                    <div class="flex border-b border-slate-700 overflow-x-auto bg-slate-900">
                        <button onclick="switchTab('schedule')" id="tab-schedule"
                                class="tab-btn px-6 py-4 font-medium text-blue-600 border-b-2 border-blue-600 transition-colors flex items-center">
                            <i class="fas fa-calendar-alt mr-2"></i> Set Schedule
                        </button>
                        <button onclick="switchTab('current')" id="tab-current"
                                class="tab-btn px-6 py-4 font-medium text-gray-400 border-b-2 border-transparent hover:border-blue-500 transition-colors flex items-center">
                            <i class="fas fa-clock mr-2"></i> Current Availability
                        </button>
                    </div>

                    <!-- Tab Content -->
                    <div class="p-8 bg-gradient-to-br from-slate-800 to-slate-850">

                        <!-- Tab 1: Set Schedule -->
                        <div id="content-schedule" class="tab-content">
                            <form action="${pageContext.request.contextPath}/doctor/availability/save" method="post" id="availabilityForm">
                                <div class="space-y-8">

                                    <!-- Date Range -->
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                        <div>
                                            <label class="block text-sm font-semibold text-gray-200 mb-3">Start Date</label>
                                            <input type="date" name="start_date" required
                                                   class="w-full px-4 py-3 border border-slate-600 rounded-lg bg-slate-700 text-white text-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        </div>
                                        <div>
                                            <label class="block text-sm font-semibold text-gray-200 mb-3">End Date</label>
                                            <input type="date" name="end_date" required
                                                   class="w-full px-4 py-3 border border-slate-600 rounded-lg bg-slate-700 text-white text-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        </div>
                                    </div>

                                    <!-- Days Configuration -->
                                    <div>
                                        <h3 class="text-lg font-semibold text-white mb-6">Configure Days</h3>
                                        <div class="grid grid-cols-1 md:grid-cols-1 gap-4">
                                            <%
                                                String[] days = {"MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"};
                                                String[] dayLabels = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
                                                for(int i = 0; i < days.length; i++){
                                                    String day = days[i];
                                                    String dayLabel = dayLabels[i];
                                            %>
                                            <div class="p-5 border-2 border-slate-600 rounded-lg day-container bg-slate-700/50 transition-all" data-day="<%= day %>">
                                                <div class="flex items-center justify-between mb-4">
                                                    <span class="font-semibold text-lg text-white"><%= dayLabel %></span>
                                                    <input type="hidden" name="<%= day %>_is_available" value="false" id="hidden_<%= day %>">
                                                    <button type="button"
                                                            class="toggle-btn px-4 py-1 text-sm rounded-full font-semibold transition-all duration-200 bg-slate-600 text-gray-300 hover:bg-slate-500"
                                                            data-day="<%= day %>"
                                                            data-active="false"
                                                            onclick="toggleDay(this)">
                                                        Off
                                                    </button>
                                                </div>
                                                <div class="time-details hidden" id="times_<%= day %>">
                                                    <div class="flex flex-col sm:flex-row items-center gap-4">
                                                        <div class="flex-1">
                                                            <label class="text-xs font-medium text-gray-300">Start</label>
                                                            <input type="time" name="<%= day %>_start_time" value="08:00"
                                                                   class="w-full px-3 py-2 border border-slate-600 rounded bg-slate-600 text-white text-sm time-input mt-1 opacity-50"
                                                                   disabled>
                                                        </div>
                                                        <div class="flex-1">
                                                            <label class="text-xs font-medium text-gray-300">End</label>
                                                            <input type="time" name="<%= day %>_end_time" value="17:00"
                                                                   class="w-full px-3 py-2 border border-slate-600 rounded bg-slate-600 text-white text-sm time-input mt-1 opacity-50"
                                                                   disabled>
                                                        </div>
                                                        <div class="flex-1">
                                                            <label class="text-xs font-medium text-gray-300">Slot (min)</label>
                                                            <input type="number" name="<%= day %>_slot_duration" value="30" min="15" step="15"
                                                                   class="w-full px-3 py-2 border border-slate-600 rounded bg-slate-600 text-white text-sm time-input mt-1 opacity-50"
                                                                   disabled>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <% } %>
                                        </div>
                                    </div>

                                    <div class="flex justify-end">
                                        <button type="submit"
                                                class="w-52 bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white py-3 px-4 rounded-lg font-semibold transition-all duration-200 shadow-lg">
                                            Save Schedule
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Tab 2: Current Availability -->
                        <div id="content-current" class="mt-6 hidden tab-content">
                            <c:if test="${empty availabilities}">
                                <p class="text-gray-500 italic">No availability configured</p>
                            </c:if>

                            <c:if test="${not empty availabilities}">
                                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                                    <c:forEach var="avail" items="${availabilities}">
                                        <div class="relative p-6 rounded-xl shadow-lg bg-gradient-to-r from-gray-800 to-gray-700 text-white hover:scale-105 transition-transform duration-300">

                                            <!-- Day -->
                                            <h3 class="text-xl font-semibold mb-2 flex items-center">
                                                <i class="fa-solid fa-calendar-days mr-2 text-blue-400"></i>
                                                    ${avail.dayOfWeek}
                                            </h3>

                                            <!-- Time -->
                                            <p class="text-gray-300 mb-2 flex items-center">
                                                <i class="fa-regular fa-clock mr-1"></i>
                                                    ${avail.startTime} - ${avail.endTime}
                                            </p>

                                            <!-- Slot Duration -->
                                            <p class="text-gray-300 mb-4 flex items-center">
                                                <i class="fa-solid fa-stopwatch mr-1"></i>
                                                    ${avail.slotDuration} min per slot
                                            </p>

                                            <!-- Status Badge -->
                                            <span class="inline-block px-3 py-1 rounded-full text-sm font-medium mb-3 shadow
                                                 ${avail.available ? 'bg-green-500 text-white' : 'bg-red-500 text-white'}">
                                                    ${avail.available ? 'Active' : 'Inactive'}
                                            </span>

                                            <!-- Action Buttons -->
                                            <div class="flex space-x-2 mt-4">
                                                <form action="${pageContext.request.contextPath}/doctor/availability/toggle" method="post" class="flex-1">
                                                    <input type="hidden" name="id" value="${avail.id}">
                                                    <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 transition-colors px-3 py-2 rounded font-medium">
                                                        Toggle
                                                    </button>
                                                </form>

                                                <form action="${pageContext.request.contextPath}/doctor/availability/delete" method="post" class="flex-1">
                                                    <input type="hidden" name="id" value="${avail.id}">
                                                    <button type="submit" class="w-full bg-red-600 hover:bg-red-700 transition-colors px-3 py-2 rounded font-medium">
                                                        Delete
                                                    </button>
                                                </form>
                                            </div>

                                            <!-- Optional icon in corner -->
                                            <i class="fa-solid fa-user-doctor absolute top-4 right-4 text-gray-400"></i>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>

                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
    // Tab switching function
    function switchTab(tabName) {
        document.querySelectorAll('.tab-content').forEach(el => el.classList.add('hidden'));
        document.querySelectorAll('.tab-btn').forEach(el => {
            el.classList.remove('text-blue-600', 'border-blue-600');
            el.classList.add('text-gray-400', 'border-transparent');
        });

        document.getElementById('content-' + tabName).classList.remove('hidden');
        const activeTab = document.getElementById('tab-' + tabName);
        activeTab.classList.remove('text-gray-400', 'border-transparent');
        activeTab.classList.add('text-blue-600', 'border-blue-600');
    }

    // Toggle day activation
    function toggleDay(button) {
        const day = button.getAttribute('data-day');
        const isActive = button.getAttribute('data-active') === 'true';
        const hiddenInput = document.getElementById('hidden_' + day);
        const container = button.closest('.day-container');
        const timeInputs = container.querySelectorAll('.time-input');
        const timeDetails = container.querySelector('.time-details');

        if (!isActive) {
            button.textContent = 'On';
            button.setAttribute('data-active', 'true');
            button.classList.remove('bg-slate-600', 'text-gray-300');
            button.classList.add('bg-green-600', 'text-white');
            hiddenInput.value = "true";
            timeInputs.forEach(input => { input.disabled = false; input.classList.remove('opacity-50'); });
            timeDetails.classList.remove('hidden');
            container.classList.add('border-green-500', 'bg-green-900/10');
        } else {
            button.textContent = 'Off';
            button.setAttribute('data-active', 'false');
            button.classList.remove('bg-green-600', 'text-white');
            button.classList.add('bg-slate-600', 'text-gray-300');
            hiddenInput.value = "false";
            timeInputs.forEach(input => { input.disabled = true; input.classList.add('opacity-50'); });
            timeDetails.classList.add('hidden');
            container.classList.remove('border-green-500', 'bg-green-900/10');
        }
    }
</script>
</body>
</html>
