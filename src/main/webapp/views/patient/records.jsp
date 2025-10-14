<%
    String activePage = "records";
%>
<%@ include file="layouts/header.jsp" %>
<%@ include file="layouts/sidebar.jsp" %>

<!-- Main -->
<div class="lg:ml-64">
    <header class="h-16 bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 flex items-center justify-between px-6">
        <div>
            <h1 class="text-xl font-semibold text-gray-900 dark:text-white">Medical Records</h1>
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
        <!-- Health Summary -->
        <div class="grid md:grid-cols-4 gap-6 mb-6">
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-sm text-gray-600 dark:text-gray-400 mb-1">Blood Type</p>
                <p class="text-2xl font-bold text-gray-900 dark:text-white">A+</p>
            </div>
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-sm text-gray-600 dark:text-gray-400 mb-1">Height</p>
                <p class="text-2xl font-bold text-gray-900 dark:text-white">175 cm</p>
            </div>
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-sm text-gray-600 dark:text-gray-400 mb-1">Weight</p>
                <p class="text-2xl font-bold text-gray-900 dark:text-white">70 kg</p>
            </div>
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <p class="text-sm text-gray-600 dark:text-gray-400 mb-1">Allergies</p>
                <p class="text-2xl font-bold text-gray-900 dark:text-white">None</p>
            </div>
        </div>

        <!-- Records List -->
        <div class="space-y-4">
            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <div class="flex items-start justify-between mb-4">
                    <div class="flex items-start space-x-4">
                        <div class="w-12 h-12 bg-green-100 dark:bg-green-900/30 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                                <path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/>
                            </svg>
                        </div>
                        <div>
                            <h3 class="font-semibold text-gray-900 dark:text-white">Blood Test Results</h3>
                            <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">Dr. Sarah Johnson • Oct 5, 2025</p>
                            <p class="text-sm text-gray-600 dark:text-gray-400 mt-2">Complete blood count, cholesterol levels, glucose test</p>
                        </div>
                    </div>
                    <span class="px-3 py-1 bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400 text-xs rounded-full">Normal</span>
                </div>
                <div class="flex gap-3">
                    <button class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">View Report</button>
                    <button class="px-4 py-2 border border-gray-200 dark:border-gray-700 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-700">Download PDF</button>
                </div>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <div class="flex items-start justify-between mb-4">
                    <div class="flex items-start space-x-4">
                        <div class="w-12 h-12 bg-blue-100 dark:bg-blue-900/30 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4z" clip-rule="evenodd"/>
                            </svg>
                        </div>
                        <div>
                            <h3 class="font-semibold text-gray-900 dark:text-white">X-Ray Report - Chest</h3>
                            <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">Dr. Michael Chen • Sep 28, 2025</p>
                            <p class="text-sm text-gray-600 dark:text-gray-400 mt-2">Chest X-ray examination, no abnormalities detected</p>
                        </div>
                    </div>
                    <span class="px-3 py-1 bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-400 text-xs rounded-full">Reviewed</span>
                </div>
                <div class="flex gap-3">
                    <button class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">View Images</button>
                    <button class="px-4 py-2 border border-gray-200 dark:border-gray-700 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-700">Download</button>
                </div>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 p-6">
                <div class="flex items-start justify-between mb-4">
                    <div class="flex items-start space-x-4">
                        <div class="w-12 h-12 bg-purple-100 dark:bg-purple-900/30 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-purple-600" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
                            </svg>
                        </div>
                        <div>
                            <h3 class="font-semibold text-gray-900 dark:text-white">ECG Report</h3>
                            <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">Dr. Sarah Johnson • Sep 20, 2025</p>
                            <p class="text-sm text-gray-600 dark:text-gray-400 mt-2">Electrocardiogram test results, normal sinus rhythm</p>
                        </div>
                    </div>
                    <span class="px-3 py-1 bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400 text-xs rounded-full">Normal</span>
                </div>
                <div class="flex gap-3">
                    <button class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">View Details</button>
                    <button class="px-4 py-2 border border-gray-200 dark:border-gray-700 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-700">Download</button>
                </div>
            </div>
        </div>
    </main>
</div>

<%@ include file="layouts/footer.jsp" %>