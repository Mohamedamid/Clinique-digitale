<%@ page contentType="text/html;charset=UTF-8" %>
<aside class="fixed left-0 top-0 h-screen w-64 bg-white dark:bg-gray-800 border-r border-gray-200 dark:border-gray-700 hidden lg:block">
    <div class="flex flex-col h-full">
        <!-- Logo -->
        <div class="h-16 px-6 flex items-center border-b border-gray-200 dark:border-gray-700">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="flex items-center space-x-3">
                <div class="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
                    <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"/>
                    </svg>
                </div>
                <div>
                    <h1 class="text-lg font-bold text-gray-900 dark:text-white">Clinique Digitale</h1>
                </div>
            </a>
        </div>

        <!-- Navigation -->
        <nav class="flex-1 p-4">
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="flex items-center px-4 py-3 mb-1 rounded-lg
         <%= "dashboard".equals(activePage) ? "bg-blue-50 dark:bg-blue-900/20 text-blue-600" : "text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700" %>">
                🏠 <span class="ml-3 font-medium">Dashboard</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/doctors"
               class="flex items-center px-4 py-3 mb-1 rounded-lg
         <%= "doctors".equals(activePage) ? "bg-blue-50 dark:bg-blue-900/20 text-blue-600" : "text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700" %>">
                🩺 <span class="ml-3 font-medium">Doctors</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/staff"
               class="flex items-center px-4 py-3 mb-1 rounded-lg
         <%= "staff".equals(activePage) ? "bg-blue-50 dark:bg-blue-900/20 text-blue-600" : "text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700" %>">
                💼 <span class="ml-3 font-medium">Staff</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/patients"
               class="flex items-center px-4 py-3 mb-1 rounded-lg
         <%= "patients".equals(activePage) ? "bg-blue-50 dark:bg-blue-900/20 text-blue-600" : "text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700" %>">
                🧑‍ <span class="ml-3 font-medium">Patients</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/departments"
               class="flex items-center px-4 py-3 mb-1 rounded-lg
         <%= "departments".equals(activePage) ? "bg-blue-50 dark:bg-blue-900/20 text-blue-600" : "text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700" %>">
                🏢 <span class="ml-3 font-medium">Departments</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/specialites"
               class="flex items-center px-4 py-3 mb-1 rounded-lg
         <%= "specialties".equals(activePage) ? "bg-blue-50 dark:bg-blue-900/20 text-blue-600" : "text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700" %>">
                🔬 <span class="ml-3 font-medium">Specialites</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/appointments"
               class="flex items-center px-4 py-3 mb-1 rounded-lg
         <%= "appointments".equals(activePage) ? "bg-blue-50 dark:bg-blue-900/20 text-blue-600" : "text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700" %>">
                📅 <span class="ml-3 font-medium">Appointments</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/settings"
               class="flex items-center px-4 py-3 mb-1 rounded-lg
         <%= "settings".equals(activePage) ? "bg-blue-50 dark:bg-blue-900/20 text-blue-600" : "text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700" %>">
                ⚙️ <span class="ml-3 font-medium">Settings</span>
            </a>
        </nav>

        <!-- User -->
        <div class="p-4 border-t border-gray-200 dark:border-gray-700">
            <div class="flex items-center">
                <div class="w-10 h-10 bg-blue-600 rounded-full flex items-center justify-center">
                    <span class="text-white font-semibold">${userName.substring(0, 1).toUpperCase()}</span>
                </div>
                <div class="ml-3 flex-1">
                    <p class="text-sm font-semibold text-gray-900 dark:text-white">${userName}</p>
                    <p class="text-xs text-gray-500 dark:text-gray-400">Admin</p>
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
