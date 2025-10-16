
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String activePage = "doctors";
%>
<%@ include file="layouts/header.jsp" %>
<%@ include file="layouts/sidebar.jsp" %>

<!-- Main Content -->
<div class="lg:ml-64 pb-16">
    <%@ include file="layouts/mainHeader.jsp"%>

    <main class="p-6">
        <!-- Title and Add Button -->
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">Manage Doctors</h2>
            <button type="button" onclick="showDoctorForm()"
                    class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">
                + Add Doctor
            </button>
        </div>

        <!-- Filter & Search -->
        <form class="flex gap-4 mb-6" method="get" action="">
            <div>
                <input type="text" name="q" value="${fn:escapeXml(param.q)}" placeholder="Search by name or email"
                       class="w-[350px] border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all" />
            </div>
            <button type="submit" class="bg-green-600 text-white px-6 py-3 rounded-lg hover:bg-green-700 font-medium shadow-lg transition-all transform hover:scale-105">
                Search
            </button>
        </form>

        <!-- Doctors Table -->
        <div class="overflow-x-auto bg-white dark:bg-gray-800 rounded-xl shadow border border-gray-200 dark:border-gray-700">
            <table class="min-w-full text-sm text-left text-gray-500 dark:text-gray-400">
                <thead class="text-xs uppercase bg-gray-50 dark:bg-gray-700 text-gray-700 dark:text-gray-300">
                <tr>
                    <th class="px-6 py-3">ID</th>
                    <th class="px-6 py-3">Full Name</th>
                    <th class="px-6 py-3">Email</th>
                    <th class="px-6 py-3">Matricule</th>
                    <th class="px-6 py-3">Speciality</th>
                    <th class="px-6 py-3">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="doctor" items="${doctorList}">
                    <tr class="border-t border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-700">
                        <td class="px-6 py-4">${doctor.id}</td>
                        <td class="px-6 py-4">${doctor.fullName}</td>
                        <td class="px-6 py-4">${doctor.email}</td>
                        <td class="px-6 py-4">${doctor.matricule}</td>
                        <td class="px-6 py-4">
                            <c:forEach var="spec" items="${specialiteList}">
                                <c:if test="${spec.id == doctor.specialiteId}">
                                    ${spec.name}
                                </c:if>
                            </c:forEach>
                        </td>
                        <td class="px-6 py-4 flex space-x-3">
                            <button onclick="showEditDoctorForm('${doctor.id}', '${doctor.fullName}', '${doctor.email}', '${doctor.matricule}', '${doctor.specialiteId}')"
                                    class="text-blue-600 hover:underline">Edit</button>
                            <button onclick="confirmDeleteDoctor('${doctor.id}', '${doctor.fullName}')"
                                    class="text-red-600 hover:underline">Delete</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</div>

<!-- Doctor Modal -->
<div id="doctorModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm hidden z-50 overflow-y-auto py-8">
    <div class="bg-white dark:bg-gray-800 rounded-2xl p-8 w-[800px] shadow-2xl my-8 mx-auto transform scale-95 animate-scale-in">
        <div class="text-center mb-6">
            <div class="w-16 h-16 bg-gradient-to-br from-green-500 to-green-600 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                </svg>
            </div>
            <h3 id="modalTitleDoctor" class="text-2xl font-bold text-gray-900 dark:text-white">Add New Doctor</h3>
        </div>
        <form id="doctorForm" action="${pageContext.request.contextPath}/admin/doctors/save" method="post" class="space-y-4">
            <input type="hidden" name="action" id="formActionDoctor" value="add">
            <input type="hidden" name="id" id="doctorId">
            <div class="grid grid-cols-3 gap-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Full Name</label>
                    <input type="text" name="fullName" id="doctorFullName" placeholder="Enter full name" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Matricule</label>
                    <input type="text" name="matricule" id="doctorMatricule" placeholder="Enter matricule" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Speciality</label>
                    <select name="specialiteId" id="doctorSpecialite" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all" required>
                        <option value="">-- Choose Speciality --</option>
                        <c:forEach var="spec" items="${specialiteList}">
                            <option value="${spec.id}">${spec.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-span-2">
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Email</label>
                    <input type="email" name="email" id="doctorEmail" placeholder="doctor@example.com" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                        Password <span class="text-gray-500 text-sm" id="passwordLabel">(required)</span>
                    </label>
                    <input type="password" name="password" id="doctorPassword" placeholder="password" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all" required>
                </div>
            </div>
            <div class="flex justify-end gap-3 pt-4">
                <button type="button" onclick="closeDoctorModal()" class="px-6 py-2.5 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg font-medium transition-colors">Cancel</button>
                <button type="submit" id="submitButtonDoctor" class="px-6 py-2.5 bg-gradient-to-r from-green-600 to-green-700 text-white rounded-lg hover:from-green-700 hover:to-green-800 font-medium shadow-lg transition-all transform hover:scale-105">Save Doctor</button>
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
    function showDoctorForm() {
        document.getElementById('doctorForm').reset();
        document.getElementById('formActionDoctor').value = 'add';
        document.getElementById('modalTitleDoctor').textContent = 'Add New Doctor';
        document.getElementById('submitButtonDoctor').textContent = 'Save Doctor';
        document.getElementById('doctorId').value = '';
        document.getElementById('passwordLabel').textContent = '(required)';
        document.getElementById('doctorPassword').required = true;

        document.getElementById('doctorModal').classList.remove('hidden');
    }

    function showEditDoctorForm(id, fullName, email, matricule, specialiteId) {
        document.getElementById('doctorId').value = id;
        document.getElementById('doctorFullName').value = fullName;
        document.getElementById('doctorEmail').value = email;
        document.getElementById('doctorMatricule').value = matricule;
        document.getElementById('doctorSpecialite').value = specialiteId;
        document.getElementById('doctorPassword').value = '';

        document.getElementById('formActionDoctor').value = 'edit';
        document.getElementById('modalTitleDoctor').textContent = 'Update Doctor';
        document.getElementById('submitButtonDoctor').textContent = 'Update Doctor';
        document.getElementById('passwordLabel').textContent = '(leave blank to keep current)';
        document.getElementById('doctorPassword').required = false;

        document.getElementById('doctorModal').classList.remove('hidden');
    }

    function closeDoctorModal() {
        document.getElementById('doctorModal').classList.add('hidden');
    }

    function confirmDeleteDoctor(id, fullName) {
        const escapedName = fullName.replace(/'/g, "\\'").replace(/"/g, '&quot;');

        Swal.fire({
            title: 'Are you sure?',
            html: `You are about to delete doctor: <strong>${escapedName}</strong>`,
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
                    text: 'Please wait while we delete the doctor',
                    allowOutsideClick: false,
                    didOpen: () => { Swal.showLoading(); }
                });
                window.location.href = '${pageContext.request.contextPath}/admin/doctors?action=delete&id=' + id;
            }
        });
    }

    document.addEventListener('click', function(e) {
        const modal = document.getElementById('doctorModal');
        if (e.target === modal) closeDoctorModal();
    });

    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') closeDoctorModal();
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