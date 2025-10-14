<%
    String activePage = "dashboard";
%>
<!-- Include Header -->
<%@ include file="layouts/header.jsp" %>
<!-- Include Sidebar -->
<%@ include file="layouts/sidebar.jsp" %>
<!-- Main Content -->
<div class="lg:ml-64">
    <%@ include file="layouts/mainHeader.jsp"%>

    <main class="p-6">
        <!-- Welcome -->
        <div class="mb-8">
            <h2 class="text-2xl font-bold text-gray-900 dark:text-white mb-1">Welcome back, ${userName}</h2>
            <p class="text-sm text-gray-600 dark:text-gray-400">${currentDate} ${currentTime}</p>
        </div>

        <!-- Stats Overview -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <div class="flex items-center justify-between mb-2">
                    <p class="text-sm text-gray-600 dark:text-gray-400">Total Users</p>
                    <svg class="w-5 h-5 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/>
                    </svg>
                </div>
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-1">342</p>
                <p class="text-xs text-green-600">+12% from last month</p>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <div class="flex items-center justify-between mb-2">
                    <p class="text-sm text-gray-600 dark:text-gray-400">Doctors</p>
                    <svg class="w-5 h-5 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-1">28</p>
                <p class="text-xs text-gray-600 dark:text-gray-400">Across 12 specialties</p>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <div class="flex items-center justify-between mb-2">
                    <p class="text-sm text-gray-600 dark:text-gray-400">Appointments Today</p>
                    <svg class="w-5 h-5 text-purple-600" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-1">89</p>
                <p class="text-xs text-yellow-600">15 pending confirmation</p>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <div class="flex items-center justify-between mb-2">
                    <p class="text-sm text-gray-600 dark:text-gray-400">Active Patients</p>
                    <svg class="w-5 h-5 text-orange-600" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                        <path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <p class="text-3xl font-bold text-gray-900 dark:text-white mb-1">256</p>
                <p class="text-xs text-gray-600 dark:text-gray-400">Last 30 days</p>
            </div>
        </div>

        <!-- Recent Activity & Quick Actions -->
        <div class="grid lg:grid-cols-3 gap-8 mb-8">
            <div class="lg:col-span-2 bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Recent Activity</h3>

                <div class="space-y-4">
                    <div class="flex items-start space-x-3 pb-4 border-b border-gray-200 dark:border-gray-700">
                        <div class="w-2 h-2 bg-green-500 rounded-full mt-2"></div>
                        <div class="flex-1">
                            <p class="text-sm font-medium text-gray-900 dark:text-white">New doctor registered</p>
                            <p class="text-xs text-gray-600 dark:text-gray-400 mt-1">Dr. Emily Martinez joined Cardiology department</p>
                            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">2 hours ago</p>
                        </div>
                    </div>

                    <div class="flex items-start space-x-3 pb-4 border-b border-gray-200 dark:border-gray-700">
                        <div class="w-2 h-2 bg-blue-500 rounded-full mt-2"></div>
                        <div class="flex-1">
                            <p class="text-sm font-medium text-gray-900 dark:text-white">Appointment spike detected</p>
                            <p class="text-xs text-gray-600 dark:text-gray-400 mt-1">45% increase in bookings for next week</p>
                            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">5 hours ago</p>
                        </div>
                    </div>

                    <div class="flex items-start space-x-3 pb-4 border-b border-gray-200 dark:border-gray-700">
                        <div class="w-2 h-2 bg-yellow-500 rounded-full mt-2"></div>
                        <div class="flex-1">
                            <p class="text-sm font-medium text-gray-900 dark:text-white">New specialty added</p>
                            <p class="text-xs text-gray-600 dark:text-gray-400 mt-1">Dermatology department created with 3 doctors</p>
                            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">1 day ago</p>
                        </div>
                    </div>

                    <div class="flex items-start space-x-3">
                        <div class="w-2 h-2 bg-red-500 rounded-full mt-2"></div>
                        <div class="flex-1">
                            <p class="text-sm font-medium text-gray-900 dark:text-white">System maintenance scheduled</p>
                            <p class="text-xs text-gray-600 dark:text-gray-400 mt-1">Database backup planned for Oct 15 at 2:00 AM</p>
                            <p class="text-xs text-gray-500 dark:text-gray-500 mt-1">2 days ago</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Quick Actions</h3>

                <div class="space-y-3">
                    <button class="w-full text-left px-4 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">
                        + Add New User
                    </button>
                    <button class="w-full text-left px-4 py-3 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600 transition-colors">
                        Create Department
                    </button>
                    <button class="w-full text-left px-4 py-3 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600 transition-colors">
                        Add Specialty
                    </button>
                    <button class="w-full text-left px-4 py-3 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600 transition-colors">
                        View All Statistics
                    </button>
                    <button class="w-full text-left px-4 py-3 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white rounded-lg hover:bg-gray-100 dark:hover:bg-gray-600 transition-colors">
                        System Settings
                    </button>
                </div>
            </div>
        </div>

        <!-- System Overview -->
        <div class="grid md:grid-cols-3 gap-6">
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <h3 class="font-semibold text-gray-900 dark:text-white mb-4">User Distribution</h3>
                <div class="space-y-3">
                    <div class="flex justify-between items-center">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Patients</span>
                        <span class="text-sm font-semibold text-gray-900 dark:text-white">256 (75%)</span>
                    </div>
                    <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                        <div class="bg-blue-600 h-2 rounded-full" style="width: 75%"></div>
                    </div>

                    <div class="flex justify-between items-center">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Doctors</span>
                        <span class="text-sm font-semibold text-gray-900 dark:text-white">28 (8%)</span>
                    </div>
                    <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                        <div class="bg-green-600 h-2 rounded-full" style="width: 8%"></div>
                    </div>

                    <div class="flex justify-between items-center">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Staff</span>
                        <span class="text-sm font-semibold text-gray-900 dark:text-white">45 (13%)</span>
                    </div>
                    <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                        <div class="bg-purple-600 h-2 rounded-full" style="width: 13%"></div>
                    </div>

                    <div class="flex justify-between items-center">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Admins</span>
                        <span class="text-sm font-semibold text-gray-900 dark:text-white">13 (4%)</span>
                    </div>
                    <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                        <div class="bg-orange-600 h-2 rounded-full" style="width: 4%"></div>
                    </div>
                </div>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <h3 class="font-semibold text-gray-900 dark:text-white mb-4">Appointments This Week</h3>
                <div class="space-y-3">
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Monday</span>
                        <span class="text-sm font-semibold text-gray-900 dark:text-white">78</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Tuesday</span>
                        <span class="text-sm font-semibold text-gray-900 dark:text-white">89</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Wednesday</span>
                        <span class="text-sm font-semibold text-gray-900 dark:text-white">92</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Thursday</span>
                        <span class="text-sm font-semibold text-gray-900 dark:text-white">67</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600 dark:text-gray-400">Friday</span>
                        <span class="text-sm font-semibold text-gray-900 dark:text-white">54</span>
                    </div>
                    <div class="pt-3 border-t border-gray-200 dark:border-gray-700">
                        <div class="flex justify-between">
                            <span class="text-sm font-semibold text-gray-900 dark:text-white">Total</span>
                            <span class="text-sm font-bold text-blue-600">380</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <h3 class="font-semibold text-gray-900 dark:text-white mb-4">Top Departments</h3>
                <div class="space-y-3">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-3">
                            <div class="w-10 h-10 bg-blue-100 dark:bg-blue-900/30 rounded-lg flex items-center justify-center">
                                <span class="text-blue-600 font-bold text-sm">1</span>
                            </div>
                            <div>
                                <p class="text-sm font-semibold text-gray-900 dark:text-white">Cardiology</p>
                                <p class="text-xs text-gray-600 dark:text-gray-400">145 appointments</p>
                            </div>
                        </div>
                    </div>

                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-3">
                            <div class="w-10 h-10 bg-green-100 dark:bg-green-900/30 rounded-lg flex items-center justify-center">
                                <span class="text-green-600 font-bold text-sm">2</span>
                            </div>
                            <div>
                                <p class="text-sm font-semibold text-gray-900 dark:text-white">General</p>
                                <p class="text-xs text-gray-600 dark:text-gray-400">123 appointments</p>
                            </div>
                        </div>
                    </div>

                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-3">
                            <div class="w-10 h-10 bg-purple-100 dark:bg-purple-900/30 rounded-lg flex items-center justify-center">
                                <span class="text-purple-600 font-bold text-sm">3</span>
                            </div>
                            <div>
                                <p class="text-sm font-semibold text-gray-900 dark:text-white">Dermatology</p>
                                <p class="text-xs text-gray-600 dark:text-gray-400">98 appointments</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Include Footer -->
<%@ include file="layouts/footer.jsp" %>
