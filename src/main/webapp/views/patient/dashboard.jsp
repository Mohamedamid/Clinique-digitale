<%
    String activePage = "dashboard";
%>
<%@ include file="layouts/header.jsp" %>
<%@ include file="layouts/sidebar.jsp" %>

<!-- Main -->
<div class="lg:ml-64">

    <!-- Header -->
    <header class="h-16 bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 flex items-center justify-between px-6">
        <div>
            <h1 class="text-xl font-semibold text-gray-900 dark:text-white">Dashboard</h1>
        </div>
        <div class="flex items-center space-x-4">
            <button id="themeToggle" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700">
                <svg class="w-5 h-5 hidden dark:block" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"/>
                </svg>
                <svg class="w-5 h-5 dark:hidden" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" clip-rule="evenodd"/>
                </svg>
            </button>
        </div>
    </header>

    <!-- Content -->
    <main class="p-6">

        <!-- Welcome -->
        <div class="mb-8">
            <h2 class="text-2xl font-bold text-gray-900 dark:text-white mb-1">Welcome back, ${userName}</h2>
            <p class="text-sm text-gray-600 dark:text-gray-400">${currentDate}</p>
        </div>

        <!-- Stats -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-2">3</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Appointments</p>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-2">12</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Records</p>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-2">5</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Prescriptions</p>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-2">2</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Messages</p>
            </div>
        </div>

        <!-- Next Appointment -->
        <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6 mb-6">
            <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Next Appointment</h3>

            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-4">
                    <div class="w-12 h-12 bg-blue-600 rounded-full flex items-center justify-center">
                        <span class="text-white font-semibold">SJ</span>
                    </div>
                    <div>
                        <p class="font-semibold text-gray-900 dark:text-white">Dr. Sarah Johnson</p>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Cardiology • Oct 15, 10:30 AM</p>
                    </div>
                </div>
                <button class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">
                    Join Call
                </button>
            </div>
        </div>

        <!-- Upcoming -->
        <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
            <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Upcoming</h3>

            <div class="space-y-3">
                <div class="flex items-center justify-between p-4 bg-gray-50 dark:bg-gray-700 rounded-lg">
                    <div class="flex items-center space-x-3">
                        <div class="w-10 h-10 bg-green-600 rounded-full flex items-center justify-center">
                            <span class="text-white text-sm font-semibold">MC</span>
                        </div>
                        <div>
                            <p class="font-medium text-gray-900 dark:text-white">Dr. Michael Chen</p>
                            <p class="text-sm text-gray-600 dark:text-gray-400">Oct 18, 2:00 PM</p>
                        </div>
                    </div>
                    <span class="text-xs px-3 py-1 bg-yellow-100 dark:bg-yellow-900/30 text-yellow-700 dark:text-yellow-400 rounded-full">Pending</span>
                </div>

                <div class="flex items-center justify-between p-4 bg-gray-50 dark:bg-gray-700 rounded-lg">
                    <div class="flex items-center space-x-3">
                        <div class="w-10 h-10 bg-purple-600 rounded-full flex items-center justify-center">
                            <span class="text-white text-sm font-semibold">EM</span>
                        </div>
                        <div>
                            <p class="font-medium text-gray-900 dark:text-white">Dr. Emily Martinez</p>
                            <p class="text-sm text-gray-600 dark:text-gray-400">Oct 22, 11:00 AM</p>
                        </div>
                    </div>
                    <span class="text-xs px-3 py-1 bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-400 rounded-full">Scheduled</span>
                </div>
            </div>
        </div>
    </main>
</div>

<%@ include file="layouts/footer.jsp" %>