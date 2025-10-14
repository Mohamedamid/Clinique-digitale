<%
    String activePage = "doctors";
%>
<%@ include file="layouts/header.jsp" %>
<%@ include file="layouts/sidebar.jsp" %>

<!-- Main -->
<div class="lg:ml-64">
    <header class="h-16 bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 flex items-center justify-between px-6">
        <div>
            <h1 class="text-xl font-semibold text-gray-900 dark:text-white">Find a Doctor</h1>
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
        <!-- Search & Filters -->
        <div class="mb-6 space-y-4">
            <input type="text" placeholder="Search doctors by name or specialty..." class="w-full px-4 py-3 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600">

            <div class="flex gap-3 overflow-x-auto pb-2">
                <button class="px-4 py-2 bg-blue-600 text-white rounded-lg whitespace-nowrap">All</button>
                <button class="px-4 py-2 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg whitespace-nowrap">Cardiology</button>
                <button class="px-4 py-2 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg whitespace-nowrap">Dermatology</button>
                <button class="px-4 py-2 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg whitespace-nowrap">General</button>
                <button class="px-4 py-2 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg whitespace-nowrap">Pediatrics</button>
            </div>
        </div>

        <!-- Doctors Grid -->
        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <div class="flex items-start space-x-4 mb-4">
                    <div class="w-16 h-16 bg-blue-600 rounded-full flex items-center justify-center">
                        <span class="text-white font-bold text-xl">SJ</span>
                    </div>
                    <div class="flex-1">
                        <h3 class="font-semibold text-lg text-gray-900 dark:text-white">Dr. Sarah Johnson</h3>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Cardiology</p>
                        <div class="flex items-center mt-1">
                            <span class="text-yellow-500">⭐</span>
                            <span class="text-sm ml-1 font-semibold">4.9</span>
                            <span class="text-sm text-gray-500 ml-1">(127 reviews)</span>
                        </div>
                    </div>
                </div>
                <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">15 years experience • Video & In-person consultations available</p>
                <button class="w-full px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Book Appointment</button>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <div class="flex items-start space-x-4 mb-4">
                    <div class="w-16 h-16 bg-green-600 rounded-full flex items-center justify-center">
                        <span class="text-white font-bold text-xl">MC</span>
                    </div>
                    <div class="flex-1">
                        <h3 class="font-semibold text-lg text-gray-900 dark:text-white">Dr. Michael Chen</h3>
                        <p class="text-sm text-gray-600 dark:text-gray-400">General Medicine</p>
                        <div class="flex items-center mt-1">
                            <span class="text-yellow-500">⭐</span>
                            <span class="text-sm ml-1 font-semibold">4.8</span>
                            <span class="text-sm text-gray-500 ml-1">(98 reviews)</span>
                        </div>
                    </div>
                </div>
                <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">12 years experience • Accepts most insurance plans</p>
                <button class="w-full px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Book Appointment</button>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <div class="flex items-start space-x-4 mb-4">
                    <div class="w-16 h-16 bg-purple-600 rounded-full flex items-center justify-center">
                        <span class="text-white font-bold text-xl">EM</span>
                    </div>
                    <div class="flex-1">
                        <h3 class="font-semibold text-lg text-gray-900 dark:text-white">Dr. Emily Martinez</h3>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Dermatology</p>
                        <div class="flex items-center mt-1">
                            <span class="text-yellow-500">⭐</span>
                            <span class="text-sm ml-1 font-semibold">5.0</span>
                            <span class="text-sm text-gray-500 ml-1">(145 reviews)</span>
                        </div>
                    </div>
                </div>
                <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">10 years experience • Specializes in skin conditions</p>
                <button class="w-full px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Book Appointment</button>
            </div>
        </div>
    </main>
</div>

<%@ include file="layouts/footer.jsp" %>