<%
    String activePage = "departments";
%>
<%@ include file="layouts/header.jsp" %>
<%@ include file="layouts/sidebar.jsp" %>

<!-- Main Content -->
<div class="lg:ml-64 pb-16">
    <%@ include file="layouts/mainHeader.jsp"%>

    <main class="p-6">
        <!-- Title and Add Button -->
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">Manage Departments</h2>
            <button type="button" onclick="showDepartmentForm()"
                    class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">
                + Add Department
            </button>
        </div>

        <!-- Departments Table -->
        <div class="overflow-x-auto bg-white dark:bg-gray-800 rounded-xl shadow border border-gray-200 dark:border-gray-700">
            <table class="min-w-full text-sm text-left text-gray-500 dark:text-gray-400">
                <thead class="text-xs uppercase bg-gray-50 dark:bg-gray-700 text-gray-700 dark:text-gray-300">
                <tr>
                    <th class="px-6 py-3">ID</th>
                    <th class="px-6 py-3">Name</th>
                    <th class="px-6 py-3">Description</th>
                    <th class="px-6 py-3">Active</th>
                    <th class="px-6 py-3">Created At</th>
                    <th class="px-6 py-3">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="dept" items="${departmentList}">
                    <tr class="border-b border-gray-100 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-700 transition">
                        <td class="px-6 py-3">${dept.id}</td>
                        <td class="px-6 py-3">${dept.name}</td>
                        <td class="px-6 py-3">${dept.description}</td>
                        <td class="px-6 py-3">
                            <c:choose>
                                <c:when test="${dept.active}">
                                    <span class="text-green-600 font-semibold">Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-red-600 font-semibold">Inactive</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="px-6 py-3">
                            <fmt:parseDate value="${dept.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                        </td>
                        <td class="px-6 py-4 flex space-x-3">
                            <button onclick="showEditDepartmentForm('${dept.id}', '${dept.name}', '${dept.description}', ${dept.active})"
                                    class="text-blue-600 hover:underline">Edit</button>
                            <button onclick="confirmDeleteDepartment('${dept.id}', '${dept.name}')"
                                    class="text-red-600 hover:underline">Delete</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</div>

<!-- Department Modal -->
<div id="departmentModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center hidden z-50 overflow-y-auto py-8">
    <div class="bg-white dark:bg-gray-800 rounded-2xl p-8 w-[600px] shadow-2xl my-8 transform scale-95 animate-scale-in">
        <div class="text-center mb-6">
            <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-blue-600 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
                </svg>
            </div>
            <h3 id="modalTitle" class="text-2xl font-bold text-gray-900 dark:text-white">Add New Department</h3>
        </div>
        <form id="departmentForm" action="${pageContext.request.contextPath}/admin/departments/save" method="post" class="space-y-4">
            <input type="hidden" name="action" id="formAction" value="add">
            <input type="hidden" name="id" id="departmentId">

            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Department Name</label>
                    <input type="text" name="name" id="departmentName" placeholder="Department Name"
                           class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg"
                           required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Active?</label>
                    <select name="is_active" id="departmentActive" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg" required>
                        <option value="true">Yes</option>
                        <option value="false">No</option>
                    </select>
                </div>
                <div class="col-span-2">
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Description</label>
                    <textarea name="description" id="departmentDescription" rows="3" placeholder="Department description"
                              class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg"></textarea>
                </div>
            </div>
            <div class="flex justify-end gap-3 pt-4">
                <button type="button" onclick="closeDepartmentModal()"
                        class="px-6 py-2.5 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg font-medium transition-colors">
                    Cancel
                </button>
                <button type="submit" id="submitButton"
                        class="px-6 py-2.5 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-medium shadow-lg transition-all">
                    Save
                </button>
            </div>
        </form>
    </div>
</div>

<!-- SweetAlert2 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<%@ include file="layouts/footer.jsp" %>

<!-- Custom CSS Animations -->
<style>
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    @keyframes scaleIn {
        from {
            opacity: 0;
            transform: scale(0.95);
        }
        to {
            opacity: 1;
            transform: scale(1);
        }
    }

    .animate-fade-in {
        animation: fadeIn 0.3s ease-out;
    }

    .animate-scale-in {
        animation: scaleIn 0.3s ease-out;
    }

    table *{
        text-align: center;
    }
</style>

<!-- JavaScript for Modal and SweetAlert -->
<script>
    // دالة لعرض نموذج الإضافة
    function showDepartmentForm() {
        // إعادة تعيين النموذج
        document.getElementById('departmentForm').reset();
        document.getElementById('formAction').value = 'add';
        document.getElementById('modalTitle').textContent = 'Add New Department';
        document.getElementById('submitButton').textContent = 'Save';
        document.getElementById('departmentId').value = '';

        // عرض المودال
        document.getElementById('departmentModal').classList.remove('hidden');
    }

    // دالة لعرض نموذج التعديل
    function showEditDepartmentForm(id, name, description, isActive) {
        // تعبئة البيانات في النموذج
        document.getElementById('departmentId').value = id;
        document.getElementById('departmentName').value = name;
        document.getElementById('departmentDescription').value = description;
        document.getElementById('departmentActive').value = isActive.toString();

        // تحديث النموذج لوضع التعديل
        document.getElementById('formAction').value = 'edit';
        document.getElementById('modalTitle').textContent = 'Update Department';
        document.getElementById('submitButton').textContent = 'Update';

        // عرض المودال
        document.getElementById('departmentModal').classList.remove('hidden');
    }

    // دالة لإغلاق المودال
    function closeDepartmentModal() {
        document.getElementById('departmentModal').classList.add('hidden');
    }

    // دالة SweetAlert للحذف
    function confirmDeleteDepartment(id, name) {
        // Escape special characters for JavaScript
        const escapedName = name.replace(/'/g, "\\'").replace(/"/g, '&quot;');

        Swal.fire({
            title: 'Are you sure?',
            html: `You are about to delete department: <strong>${escapedName}</strong>`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'Cancel',
            backdrop: true,
            allowOutsideClick: false,
            allowEscapeKey: true,
            allowEnterKey: false
        }).then((result) => {
            if (result.isConfirmed) {
                // Show loading state
                Swal.fire({
                    title: 'Deleting...',
                    text: 'Please wait while we delete the department',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });

                // Redirect to delete URL
                window.location.href = '${pageContext.request.contextPath}/admin/departments?action=delete&id=' + id;
            }
        });
    }

    // إغلاق المودال عند النقر خارج المحتوى أو زر Escape
    document.addEventListener('click', function(e) {
        const modal = document.getElementById('departmentModal');
        if (e.target === modal) closeDepartmentModal();
    });

    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') closeDepartmentModal();
    });

    // منع الإرسال المزدوج للنموذج
    document.getElementById('departmentForm').addEventListener('submit', function(e) {
        const submitButton = document.getElementById('submitButton');
        submitButton.disabled = true;
        submitButton.innerHTML = 'Processing...';

        // إعادة تمكين الزر بعد 3 ثواني في حالة وجود خطأ
        setTimeout(() => {
            submitButton.disabled = false;
            submitButton.innerHTML = document.getElementById('formAction').value === 'add' ? 'Save' : 'Update';
        }, 3000);
    });

    // Show success message from backend if exists
    <c:if test="${not empty success}">
    Swal.fire({
        title: 'Success!',
        text: '${success}',
        icon: 'success',
        confirmButtonColor: '#3085d6',
        confirmButtonText: 'OK'
    });
    </c:if>

    // Show error messages from backend if exist
    <c:if test="${not empty errors}">
    Swal.fire({
        title: 'Error!',
        html: `<ul class="text-left">
            <c:forEach var="error" items="${errors}">
                <li>${error.value}</li>
            </c:forEach>
        </ul>`,
        icon: 'error',
        confirmButtonColor: '#d33',
        confirmButtonText: 'OK'
    });
    </c:if>
</script>