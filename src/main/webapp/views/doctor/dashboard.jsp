<%
    String activePage = "dashboard";
%>
<%@ include file="layouts/header.jsp"%>
<!-- Sidebar -->
<%@ include file="layouts/sidebar.jsp"%>
<!-- Main -->
<div class="lg:ml-64">
    <%@ include file="layouts/mainHeader.jsp"%>
    <main class="p-6">
        <!-- Welcome -->
        <div class="mb-8">
            <h2 class="text-2xl font-bold text-gray-900 dark:text-white mb-1">Welcome back, Dr. ${userName}</h2>
            <p class="text-sm text-gray-600 dark:text-gray-400">${currentDate} • ${currentTime}</p>
        </div>

        <!-- Stats -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-2">8</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Today's Appointments</p>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-2">45</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Total Patients</p>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-2">12</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Pending Notes</p>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-2">5</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Available Slots</p>
            </div>
        </div>

        <!-- Today's Schedule -->
        <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6 mb-6">
            <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Today's Schedule</h3>

            <div class="space-y-4">
                <div class="flex items-center justify-between p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg border-l-4 border-blue-600">
                    <div class="flex items-center space-x-4">
                        <div class="text-center">
                            <p class="text-sm font-semibold text-blue-600">09:00</p>
                            <p class="text-xs text-gray-600 dark:text-gray-400">30 min</p>
                        </div>
                        <div>
                            <p class="font-semibold text-gray-900 dark:text-white">John Smith</p>
                            <p class="text-sm text-gray-600 dark:text-gray-400">Annual Checkup • In Progress</p>
                        </div>
                    </div>
                    <button class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Add Note</button>
                </div>

                <div class="flex items-center justify-between p-4 bg-gray-50 dark:bg-gray-700 rounded-lg">
                    <div class="flex items-center space-x-4">
                        <div class="text-center">
                            <p class="text-sm font-semibold text-gray-900 dark:text-white">10:00</p>
                            <p class="text-xs text-gray-600 dark:text-gray-400">30 min</p>
                        </div>
                        <div>
                            <p class="font-semibold text-gray-900 dark:text-white">Sarah Johnson</p>
                            <p class="text-sm text-gray-600 dark:text-gray-400">Follow-up • Scheduled</p>
                        </div>
                    </div>
                    <button class="px-4 py-2 border border-gray-200 dark:border-gray-600 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600">View</button>
                </div>

                <div class="flex items-center justify-between p-4 bg-gray-50 dark:bg-gray-700 rounded-lg">
                    <div class="flex items-center space-x-4">
                        <div class="text-center">
                            <p class="text-sm font-semibold text-gray-900 dark:text-white">11:00</p>
                            <p class="text-xs text-gray-600 dark:text-gray-400">30 min</p>
                        </div>
                        <div>
                            <p class="font-semibold text-gray-900 dark:text-white">Michael Chen</p>
                            <p class="text-sm text-gray-600 dark:text-gray-400">Consultation • Scheduled</p>
                        </div>
                    </div>
                    <button class="px-4 py-2 border border-gray-200 dark:border-gray-600 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600">View</button>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="grid md:grid-cols-3 gap-6">
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <h3 class="font-semibold text-gray-900 dark:text-white mb-4">Quick Actions</h3>
                <div class="space-y-3">
                    <button class="w-full text-left px-4 py-3 bg-blue-50 dark:bg-blue-900/20 text-blue-600 rounded-lg hover:bg-blue-100 dark:hover:bg-blue-900/30">
                        Set Availability
                    </button>
                    <button class="w-full text-left px-4 py-3 bg-gray-50 dark:bg-gray-700 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600">
                        View All Patients
                    </button>
                    <button class="w-full text-left px-4 py-3 bg-gray-50 dark:bg-gray-700 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600">
                        Pending Notes (12)
                    </button>
                </div>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <h3 class="font-semibold text-gray-900 dark:text-white mb-4">This Week</h3>
                <div class="space-y-3">
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Monday</span>
                        <span class="text-sm font-semibold text-gray-900 dark:text-white">8 appointments</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Tuesday</span>
                        <span class="text-sm font-semibold text-gray-900 dark:text-white">6 appointments</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Wednesday</span>
                        <span class="text-sm font-semibold text-gray-900 dark:text-white">10 appointments</span>
                    </div>
                </div>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <h3 class="font-semibold text-gray-900 dark:text-white mb-4">Specialization</h3>
                <div class="space-y-3">
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Department</p>
                        <p class="font-semibold text-gray-900 dark:text-white">Cardiology</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Years of Experience</p>
                        <p class="font-semibold text-gray-900 dark:text-white">15 years</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Rating</p>
                        <p class="font-semibold text-gray-900 dark:text-white">⭐ 4.9 (127 reviews)</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<%@ include file="layouts/footer.jsp"%>
