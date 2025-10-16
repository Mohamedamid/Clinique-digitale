<%@ page import="java.util.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String activePage = "patients";
%>
<%@ include file="layouts/header.jsp" %>
<%@ include file="layouts/sidebar.jsp" %>

<!-- Main Content -->
<div class="lg:ml-64 pb-16">
    <%@ include file="layouts/mainHeader.jsp"%>

    <main class="p-6">
        <!-- Title and Add Button -->
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">Manage Patients</h2>
            <button type="button" onclick="showPatientForm()"
                    class="bg-purple-600 text-white px-4 py-2 rounded-lg hover:bg-purple-700">
                + Add Patient
            </button>
        </div>

        <!-- Filter & Search -->
        <form class="flex gap-4 mb-6" method="get" action="">
            <div>
                <input type="text" name="q" value="${fn:escapeXml(param.q)}" placeholder="Search by name or email"
                       class="w-[350px] border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all" />
            </div>
            <button type="submit" class="bg-purple-600 text-white px-6 py-3 rounded-lg hover:bg-purple-700 font-medium shadow-lg transition-all transform hover:scale-105">
                Search
            </button>
        </form>

        <!-- Patients Table -->
        <div class="overflow-x-auto bg-white dark:bg-gray-800 rounded-xl shadow border border-gray-200 dark:border-gray-700">
            <table class="min-w-full text-sm text-left text-gray-500 dark:text-gray-400">
                <thead class="text-xs uppercase bg-gray-50 dark:bg-gray-700 text-gray-700 dark:text-gray-300">
                <tr>
                    <th class="px-6 py-3">ID</th>
                    <th class="px-6 py-3">Full Name</th>
                    <th class="px-6 py-3">Email</th>
                    <th class="px-6 py-3">CIN</th>
                    <th class="px-6 py-3">dateOfBirth</th>
                    <th class="px-6 py-3">Gender</th>
                    <th class="px-6 py-3">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="patient" items="${patientList}">
                    <tr class="border-t border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-700">
                        <td class="px-6 py-4">${patient.id}</td>
                        <td class="px-6 py-4">${patient.fullName}</td>
                        <td class="px-6 py-4">${patient.email}</td>
                        <td class="px-6 py-4">${patient.cin}</td>
                        <td class="px-6 py-4">${patient.birthDate}</td>
                        <td class="px-6 py-4">${patient.gender}</td>
                        <td class="px-6 py-4 flex space-x-3">
                            <button onclick="showEditPatientForm('${patient.id}', '${patient.fullName}', '${patient.email}', '${patient.cin}', '${patient.birthDate}', '${patient.gender}', '${patient.bloodType}', '${patient.insuranceNumber}')"
                                    class="text-blue-600 hover:underline">Edit</button>
                            <button onclick="confirmDeletePatient('${patient.id}', '${patient.fullName}')"
                                    class="text-red-600 hover:underline">Delete</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</div>

<!-- Patient Modal -->
<div id="patientModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm hidden z-50 overflow-y-auto py-8">
    <div class="bg-white dark:bg-gray-800 rounded-2xl p-8 w-[800px] shadow-2xl my-8 mx-auto transform scale-95 animate-scale-in">
        <div class="text-center mb-6">
            <div class="w-16 h-16 bg-gradient-to-br from-purple-500 to-purple-600 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                </svg>
            </div>
            <h3 id="modalTitlePatient" class="text-2xl font-bold text-gray-900 dark:text-white">Add New Patient</h3>
        </div>
        <form id="patientForm" action="${pageContext.request.contextPath}/admin/patients/save" method="post" class="space-y-4">
            <input type="hidden" name="action" id="formActionPatient" value="add">
            <input type="hidden" name="id" id="patientId">
            <div class="grid grid-cols-3 gap-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Full Name</label>
                    <input type="text" name="fullName" id="patientFullName" placeholder="Enter full name" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">CIN</label>
                    <input type="text" name="cin" id="patientCin" placeholder="CIN" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Date of Birth</label>
                    <input type="date" name="dateOfBirth" id="patientDateOfBirth" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all" required>
                </div>
                <div class="col-span-2">
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Email</label>
                    <input type="email" name="email" id="patientEmail" placeholder="patient@example.com" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                        Password <span class="text-gray-500 text-sm" id="passwordLabelPatient">(required)</span>
                    </label>
                    <input type="password" name="password" id="patientPassword" placeholder="••••••••" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Gender</label>
                    <select name="gender" id="patientGender" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all" required>
                        <option value="">-- Select Gender --</option>
                        <option value="MALE">Male</option>
                        <option value="FEMALE">Female</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Blood Type</label>
                    <select name="bloodType" id="patientBloodType" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all" required>
                        <option value="">-- Select Blood Type --</option>
                        <option value="A_POSITIVE">A+</option>
                        <option value="A_NEGATIVE">A-</option>
                        <option value="B_POSITIVE">B+</option>
                        <option value="B_NEGATIVE">B-</option>
                        <option value="AB_POSITIVE">AB+</option>
                        <option value="AB_NEGATIVE">AB-</option>
                        <option value="O_POSITIVE">O+</option>
                        <option value="O_NEGATIVE">O-</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Insurance Number</label>
                    <input type="text" name="insuranceNumber" id="patientInsuranceNumber" placeholder="Insurance number (optional)" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                </div>
            </div>
            <div class="flex justify-end gap-3 pt-4">
                <button type="button" onclick="closePatientModal()" class="px-6 py-2.5 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg font-medium transition-colors">Cancel</button>
                <button type="submit" id="submitButtonPatient" class="px-6 py-2.5 bg-gradient-to-r from-purple-600 to-purple-700 text-white rounded-lg hover:from-purple-700 hover:to-purple-800 font-medium shadow-lg transition-all transform hover:scale-105">Save Patient</button>
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
    function showPatientForm() {
        document.getElementById('patientForm').reset();
        document.getElementById('formActionPatient').value = 'add';
        document.getElementById('modalTitlePatient').textContent = 'Add New Patient';
        document.getElementById('submitButtonPatient').textContent = 'Save Patient';
        document.getElementById('patientId').value = '';
        document.getElementById('passwordLabelPatient').textContent = '(required)';
        document.getElementById('patientPassword').required = true;

        document.getElementById('patientModal').classList.remove('hidden');
    }

    function showEditPatientForm(id, fullName, email, cin, dateOfBirth, gender, bloodType, insuranceNumber) {
        document.getElementById('patientId').value = id;
        document.getElementById('patientFullName').value = fullName;
        document.getElementById('patientEmail').value = email;
        document.getElementById('patientCin').value = cin;
        document.getElementById('patientDateOfBirth').value = dateOfBirth;
        document.getElementById('patientGender').value = gender;
        document.getElementById('patientBloodType').value = bloodType;
        document.getElementById('patientInsuranceNumber').value = insuranceNumber || '';
        document.getElementById('patientPassword').value = '';

        document.getElementById('formActionPatient').value = 'edit';
        document.getElementById('modalTitlePatient').textContent = 'Update Patient';
        document.getElementById('submitButtonPatient').textContent = 'Update Patient';
        document.getElementById('passwordLabelPatient').textContent = '(leave blank to keep current)';
        document.getElementById('patientPassword').required = false;

        document.getElementById('patientModal').classList.remove('hidden');
    }

    function closePatientModal() {
        document.getElementById('patientModal').classList.add('hidden');
    }

    function confirmDeletePatient(id, fullName) {
        const escapedName = fullName.replace(/'/g, "\\'").replace(/"/g, '&quot;');

        Swal.fire({
            title: 'Are you sure?',
            html: `You are about to delete patient: <strong>${escapedName}</strong>`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'Cancel'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = '${pageContext.request.contextPath}/admin/patients/delete?action=delete&id=' + id;
            }
        });
    }

    document.addEventListener('click', function(e) {
        const modal = document.getElementById('patientModal');
        if (e.target === modal) closePatientModal();
    });

    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') closePatientModal();
    });

    <c:if test="${not empty success}">
    Swal.fire({
        title: 'Success!',
        text: '${success}',
        icon: 'success',
        confirmButtonColor: '#3085d6',
        confirmButtonText: 'OK'
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
        confirmButtonColor: '#d33',
        confirmButtonText: 'OK'
    });
    </c:if>
</script>