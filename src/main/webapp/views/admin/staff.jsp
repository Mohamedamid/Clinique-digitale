<%@ page import="java.util.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String activePage = "staff";
%>
<%@ include file="layouts/header.jsp" %>
<%@ include file="layouts/sidebar.jsp" %>

<!-- Main Content -->
<div class="lg:ml-64 pb-16">
    <%@ include file="layouts/mainHeader.jsp"%>

    <main class="p-6">
        <!-- Title and Add Button -->
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">Manage Staff</h2>
            <button type="button" onclick="showStaffForm()"
                    class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">
                + Add Staff
            </button>
        </div>

        <!-- Filter & Search -->
        <form class="flex gap-4 mb-6" method="get" action="">
            <div>
                <input type="text" name="q" value="${fn:escapeXml(param.q)}" placeholder="Search by name or email"
                       class="w-[350px] border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" />
            </div>
            <button type="submit" class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 font-medium shadow-lg transition-all transform hover:scale-105">
                Search
            </button>
        </form>

        <!-- Staff Table -->
        <div class="overflow-x-auto bg-white dark:bg-gray-800 rounded-xl shadow border border-gray-200 dark:border-gray-700">
            <table class="min-w-full text-sm text-left text-gray-500 dark:text-gray-400">
                <thead class="text-xs uppercase bg-gray-50 dark:bg-gray-700 text-gray-700 dark:text-gray-300">
                <tr>
                    <th class="px-6 py-3">ID</th>
                    <th class="px-6 py-3">Full Name</th>
                    <th class="px-6 py-3">Email</th>
                    <th class="px-6 py-3">Position</th>
                    <th class="px-6 py-3">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="staff" items="${staffList}">
                    <tr class="border-t border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-700">
                        <td class="px-6 py-4">${staff.id}</td>
                        <td class="px-6 py-4">${staff.fullName}</td>
                        <td class="px-6 py-4">${staff.email}</td>
                        <td class="px-6 py-4">${staff.position}</td>
                        <td class="px-6 py-4 flex space-x-3">
                            <button onclick="showEditStaffForm('${staff.id}', '${staff.fullName}', '${staff.email}', '${staff.position}')"
                                    class="text-blue-600 hover:underline">Edit</button>
                            <button onclick="confirmDeleteStaff('${staff.id}', '${staff.fullName}')"
                                    class="text-red-600 hover:underline">Delete</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</div>

<!-- Staff Modal -->
<div id="staffModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm hidden z-50 overflow-y-auto py-8">
    <div class="bg-white dark:bg-gray-800 rounded-2xl p-8 w-[800px] shadow-2xl my-8 mx-auto transform scale-95 animate-scale-in">
        <div class="text-center mb-6">
            <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-blue-600 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                </svg>
            </div>
            <h3 id="modalTitleStaff" class="text-2xl font-bold text-gray-900 dark:text-white">Add New Staff</h3>
        </div>
        <form id="staffForm" action="${pageContext.request.contextPath}/admin/staff/save" method="post" class="space-y-4">
            <input type="hidden" name="action" id="formActionStaff" value="add">
            <input type="hidden" name="id" id="staffId">
            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Full Name</label>
                    <input type="text" name="fullName" id="staffFullName" placeholder="Enter full name" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Position</label>
                    <input type="text" name="position" id="staffPosition" placeholder="Enter position" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Email</label>
                    <input type="email" name="email" id="staffEmail" placeholder="staff@example.com" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                        Password <span class="text-gray-500 text-sm" id="passwordLabelStaff">(required)</span>
                    </label>
                    <input type="password" name="password" id="staffPassword" placeholder="••••••••" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" required>
                </div>
            </div>
            <div class="flex justify-end gap-3 pt-4">
                <button type="button" onclick="closeStaffModal()" class="px-6 py-2.5 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg font-medium transition-colors">Cancel</button>
                <button type="submit" id="submitButtonStaff" class="px-6 py-2.5 bg-gradient-to-r from-blue-600 to-blue-700 text-white rounded-lg hover:from-blue-700 hover:to-blue-800 font-medium shadow-lg transition-all transform hover:scale-105">Save Staff</button>
            </div>
        </form>
    </div>
</div>

<!-- SweetAlert2 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<%@ include file="layouts/footer.jsp" %>

<style>
    @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    @keyframes scaleIn { from { opacity: 0; transform: scale(0.95); } to { opacity: 1; transform: scale(1); } }
    .animate-fade-in { animation: fadeIn 0.3s ease-out; }
    .animate-scale-in { animation: scaleIn 0.3s ease-out; }
</style>

<script>
    function showStaffForm() {
        document.getElementById('staffForm').reset();
        document.getElementById('formActionStaff').value = 'add';
        document.getElementById('modalTitleStaff').textContent = 'Add New Staff';
        document.getElementById('submitButtonStaff').textContent = 'Save Staff';
        document.getElementById('staffId').value = '';
        document.getElementById('passwordLabelStaff').textContent = '(required)';
        document.getElementById('staffPassword').required = true;

        document.getElementById('staffModal').classList.remove('hidden');
    }

    function showEditStaffForm(id, fullName, email, position) {
        document.getElementById('staffId').value = id;
        document.getElementById('staffFullName').value = fullName;
        document.getElementById('staffEmail').value = email;
        document.getElementById('staffPosition').value = position;
        document.getElementById('staffPassword').value = '';

        document.getElementById('formActionStaff').value = 'edit';
        document.getElementById('modalTitleStaff').textContent = 'Update Staff';
        document.getElementById('submitButtonStaff').textContent = 'Update Staff';
        document.getElementById('passwordLabelStaff').textContent = '(leave blank to keep current)';
        document.getElementById('staffPassword').required = false;

        document.getElementById('staffModal').classList.remove('hidden');
    }

    function closeStaffModal() {
        document.getElementById('staffModal').classList.add('hidden');
    }

    function confirmDeleteStaff(id, fullName) {
        const escapedName = fullName.replace(/'/g, "\\'").replace(/"/g, '&quot;');

        Swal.fire({
            title: 'Are you sure?',
            html: `You are about to delete staff: <strong>${escapedName}</strong>`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'Cancel'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: 'Deleting...',
                    text: 'Please wait while we delete the staff',
                    allowOutsideClick: false,
                    didOpen: () => { Swal.showLoading(); }
                });
                window.location.href = '${pageContext.request.contextPath}/admin/staff/delete?action=delete&id=' + id;
            }
        });
    }

    document.addEventListener('click', function(e) {
        const modal = document.getElementById('staffModal');
        if (e.target === modal) closeStaffModal();
    });

    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') closeStaffModal();
    });

    // Show messages
    <c:if test="${not empty success}">
    Swal.fire({
        title: 'Success!',
        text: '${success}',
        icon: 'success',
        confirmButtonColor: '#3085d6'
    });
    </c:if>

    <c:if test="${not empty errors}">
    Swal.fire({
        title: 'Error!',
        html: `<ul class="text-left">
            <c:forEach var="error" items="${errors}">
                <li>${error.value}</li>
            </c:forEach>
        </ul>`,
        icon: 'error',
        confirmButtonColor: '#d33'
    });
    </c:if>
</script>