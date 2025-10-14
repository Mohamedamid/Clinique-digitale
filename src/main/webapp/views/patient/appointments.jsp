<%
    String activePage = "appointments";
%>
<%@ include file="layouts/header.jsp" %>
<%@ include file="layouts/sidebar.jsp" %>

<!-- Main -->
<div class="lg:ml-64">
    <header class="h-16 bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 flex items-center justify-between px-6">
        <div>
            <h1 class="text-xl font-semibold text-gray-900 dark:text-white">My Appointments</h1>
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
            <button class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">
                Book Appointment
            </button>
        </div>
    </header>

    <main class="p-6">
        <!-- Filters -->
        <div class="flex gap-3 mb-6">
            <button class="px-4 py-2 bg-blue-600 text-white rounded-lg">All</button>
            <button class="px-4 py-2 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg">Upcoming</button>
            <button class="px-4 py-2 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg">Past</button>
            <button class="px-4 py-2 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg">Cancelled</button>
        </div>

        <!-- Appointments List -->
        <div class="space-y-4">
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <div class="flex items-start justify-between mb-4">
                    <div class="flex items-start space-x-4">
                        <div class="w-14 h-14 bg-blue-600 rounded-full flex items-center justify-center">
                            <span class="text-white font-semibold text-lg">SJ</span>
                        </div>
                        <div>
                            <h3 class="font-semibold text-lg text-gray-900 dark:text-white">Dr. Sarah Johnson</h3>
                            <p class="text-sm text-gray-600 dark:text-gray-400">Cardiology</p>
                            <div class="flex items-center gap-4 mt-2 text-sm text-gray-600 dark:text-gray-400">
                                <span>📅 Oct 15, 2025</span>
                                <span>🕐 10:30 AM</span>
                                <span>📍 Video Call</span>
                            </div>
                        </div>
                    </div>
                    <span class="px-3 py-1 bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400 text-xs rounded-full">Confirmed</span>
                </div>
                <div class="flex gap-3">
                    <button class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Join Call</button>
                    <button class="px-4 py-2 border border-gray-200 dark:border-gray-700 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-700">Reschedule</button>
                    <button class="px-4 py-2 border border-red-200 dark:border-red-700 text-red-600 rounded-lg hover:bg-red-50 dark:hover:bg-red-900/20">Cancel</button>
                </div>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <div class="flex items-start justify-between mb-4">
                    <div class="flex items-start space-x-4">
                        <div class="w-14 h-14 bg-green-600 rounded-full flex items-center justify-center">
                            <span class="text-white font-semibold text-lg">MC</span>
                        </div>
                        <div>
                            <h3 class="font-semibold text-lg text-gray-900 dark:text-white">Dr. Michael Chen</h3>
                            <p class="text-sm text-gray-600 dark:text-gray-400">General Medicine</p>
                            <div class="flex items-center gap-4 mt-2 text-sm text-gray-600 dark:text-gray-400">
                                <span>📅 Oct 18, 2025</span>
                                <span>🕐 2:00 PM</span>
                                <span>📍 In Person</span>
                            </div>
                        </div>
                    </div>
                    <span class="px-3 py-1 bg-yellow-100 dark:bg-yellow-900/30 text-yellow-700 dark:text-yellow-400 text-xs rounded-full">Pending</span>
                </div>
                <div class="flex gap-3">
                    <button class="px-4 py-2 border border-gray-200 dark:border-gray-700 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-700">View Details</button>
                    <button class="px-4 py-2 border border-red-200 dark:border-red-700 text-red-600 rounded-lg hover:bg-red-50 dark:hover:bg-red-900/20">Cancel</button>
                </div>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <div class="flex items-start justify-between mb-4">
                    <div class="flex items-start space-x-4">
                        <div class="w-14 h-14 bg-purple-600 rounded-full flex items-center justify-center">
                            <span class="text-white font-semibold text-lg">EM</span>
                        </div>
                        <div>
                            <h3 class="font-semibold text-lg text-gray-900 dark:text-white">Dr. Emily Martinez</h3>
                            <p class="text-sm text-gray-600 dark:text-gray-400">Dermatology</p>
                            <div class="flex items-center gap-4 mt-2 text-sm text-gray-600 dark:text-gray-400">
                                <span>📅 Oct 5, 2025</span>
                                <span>🕐 11:00 AM</span>
                                <span>📍 Video Call</span>
                            </div>
                        </div>
                    </div>
                    <span class="px-3 py-1 bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-400 text-xs rounded-full">Completed</span>
                </div>
                <div class="flex gap-3">
                    <button class="px-4 py-2 border border-gray-200 dark:border-gray-700 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-700">View Report</button>
                    <button class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Book Again</button>
                </div>
            </div>
        </div>
    </main>
</div>

<%@ include file="layouts/footer.jsp" %>
