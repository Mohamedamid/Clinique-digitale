<%@ page import="java.util.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String activePage = "users";
%>
<%@ include file="layouts/header.jsp" %>
<%@ include file="layouts/sidebar.jsp" %>

<!-- Main Content -->
<div class="lg:ml-64 pb-16">
    <%@ include file="layouts/mainHeader.jsp"%>

    <main class="p-6">
        <!-- Title and Add Button -->
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">Manage Users</h2>
            <button type="button" onclick="openUserTypeModal()"
                    class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">
                + Add User
            </button>
        </div>

        <!-- Filter & Search -->
        <form class="flex gap-4 mb-6" method="get" action="">
            <div>
                <select name="role" class="w-[150px] border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all">
                    <option value="">All Roles</option>
                    <option value="ADMIN" ${param.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                    <option value="DOCTOR" ${param.role == 'DOCTOR' ? 'selected' : ''}>Doctor</option>
                    <option value="STAFF" ${param.role == 'STAFF' ? 'selected' : ''}>Staff</option>
                    <option value="PATIENT" ${param.role == 'PATIENT' ? 'selected' : ''}>Patient</option>
                </select>
            </div>
            <div >
                <input type="text" name="q" value="${fn:escapeXml(param.q)}" placeholder="Search by name or email"
                       class="w-[350px] border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" />
            </div>
            <button type="submit" class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 font-medium shadow-lg transition-all transform hover:scale-105">
                Filter
            </button>
        </form>

        <!-- Users Table -->
        <div class="overflow-x-auto bg-white dark:bg-gray-800 rounded-xl shadow border border-gray-200 dark:border-gray-700">
            <table class="min-w-full text-sm text-left text-gray-500 dark:text-gray-400">
                <thead class="text-xs uppercase bg-gray-50 dark:bg-gray-700 text-gray-700 dark:text-gray-300">
                <tr>
                    <th class="px-6 py-3">ID</th>
                    <th class="px-6 py-3">Full Name</th>
                    <th class="px-6 py-3">Email</th>
                    <th class="px-6 py-3">Role</th>
                    <th class="px-6 py-3">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${userList}">
                    <tr class="border-t border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-700">
                        <td class="px-6 py-4">${user.id}</td>
                        <td class="px-6 py-4">${user.fullName}</td>
                        <td class="px-6 py-4">${user.email}</td>
                        <td class="px-6 py-4">
                            <span class="px-2 py-1 rounded text-xs font-medium
                                <c:choose>
                                    <c:when test="${user.role eq 'ADMIN'}">bg-purple-100 text-purple-700</c:when>
                                    <c:when test="${user.role eq 'DOCTOR'}">bg-green-100 text-green-700</c:when>
                                    <c:when test="${user.role eq 'STAFF'}">bg-blue-100 text-blue-700</c:when>
                                    <c:otherwise>bg-pink-100 text-pink-700</c:otherwise>
                                </c:choose>">
                                    ${user.role}
                            </span>
                        </td>
                        <td class="px-6 py-4 flex space-x-3">
                            <button onclick="showEditUserForm('${user.id}', '${user.fullName}', '${user.email}', '${user.role}')"
                                    class="text-blue-600 hover:underline">Edit</button>
                            <button onclick="confirmDeleteUser('${user.id}', '${user.fullName}', '${user.role}')"
                                    class="text-red-600 hover:underline">Delete</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</div>

<!-- ===================== -->
<!--      MODALS AREA      -->
<!-- ===================== -->

<!-- Choose User Type Modal -->
<div id="userTypeModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center hidden z-50 animate-fade-in">
    <div class="bg-white dark:bg-gray-800 rounded-2xl p-8 w-[420px] shadow-2xl transform scale-95 animate-scale-in">
        <div class="text-center mb-6">
            <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-purple-600 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                </svg>
            </div>
            <h3 class="text-2xl font-bold text-gray-900 dark:text-white">Choose User Type</h3>
            <p class="text-gray-600 dark:text-gray-400 mt-2">Select the type of user you want to add</p>
        </div>
        <div class="space-y-3">
            <button onclick="showUserForm('doctor')" class="w-full bg-gradient-to-r from-green-600 to-green-700 text-white py-3 rounded-xl hover:from-green-700 hover:to-green-800 transform hover:scale-105 transition-all duration-200 font-semibold shadow-lg flex items-center justify-center gap-2">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                </svg>
                Doctor
            </button>
            <button onclick="showUserForm('staff')" class="w-full bg-gradient-to-r from-blue-600 to-blue-700 text-white py-3 rounded-xl hover:from-blue-700 hover:to-blue-800 transform hover:scale-105 transition-all duration-200 font-semibold shadow-lg flex items-center justify-center gap-2">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                </svg>
                Staff
            </button>
            <button onclick="showUserForm('patient')" class="w-full bg-gradient-to-r from-purple-600 to-purple-700 text-white py-3 rounded-xl hover:from-purple-700 hover:to-purple-800 transform hover:scale-105 transition-all duration-200 font-semibold shadow-lg flex items-center justify-center gap-2">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                </svg>
                Patient
            </button>
        </div>
        <button onclick="closeUserTypeModal()" class="mt-6 text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white w-full text-center py-2 font-medium transition-colors">Cancel</button>
    </div>
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
        <form id="doctorForm" action="${pageContext.request.contextPath}/admin/users/doctors/save" method="post" class="space-y-4">
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
                        Password <span class="text-gray-500 text-sm">(leave blank to keep current)</span>
                    </label>
                    <input type="password" name="password" id="doctorPassword" placeholder="••••••••" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all">
                </div>
            </div>
            <div class="flex justify-end gap-3 pt-4">
                <button type="button" onclick="closeAllModals()" class="px-6 py-2.5 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg font-medium transition-colors">Cancel</button>
                <button type="submit" id="submitButtonDoctor" class="px-6 py-2.5 bg-gradient-to-r from-green-600 to-green-700 text-white rounded-lg hover:from-green-700 hover:to-green-800 font-medium shadow-lg transition-all transform hover:scale-105">Save Doctor</button>
            </div>
        </form>
    </div>
</div>

<!-- Staff Modal -->
<div id="staffModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center hidden z-50 overflow-y-auto py-8">
    <div class="bg-white dark:bg-gray-800 rounded-2xl p-8 w-[800px] shadow-2xl my-8 transform scale-95 animate-scale-in">
        <div class="text-center mb-6">
            <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-blue-600 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                </svg>
            </div>
            <h3 id="modalTitleStaff" class="text-2xl font-bold text-gray-900 dark:text-white">Add New Staff</h3>
        </div>
        <form id="staffForm" action="${pageContext.request.contextPath}/admin/users/add?role=STAFF" method="post" class="space-y-4">
            <input type="hidden" name="action" id="formActionStaff" value="add">
            <input type="hidden" name="id" id="staffId">
            <div class="grid grid-cols-4 gap-4">
                <div class="col-span-2">
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Full Name</label>
                    <input type="text" name="fullName" id="staffFullName" placeholder="Enter full name" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" required>
                </div>
                <div class="col-span-2">
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Position</label>
                    <input type="text" name="position" id="staffPosition" placeholder="Enter position" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" required>
                </div>
                <div class="col-span-2">
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Email</label>
                    <input type="email" name="email" id="staffEmail" placeholder="staff@example.com" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" required>
                </div>
                <div class="col-span-2">
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                        Password <span class="text-gray-500 text-sm">(leave blank to keep current)</span>
                    </label>
                    <input type="password" name="password" id="staffPassword" placeholder="••••••••" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all">
                </div>
            </div>
            <div class="flex justify-end gap-3 pt-4">
                <button type="button" onclick="closeAllModals()" class="px-6 py-2.5 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg font-medium transition-colors">Cancel</button>
                <button type="submit" id="submitButtonStaff" class="px-6 py-2.5 bg-gradient-to-r from-blue-600 to-blue-700 text-white rounded-lg hover:from-blue-700 hover:to-blue-800 font-medium shadow-lg transition-all transform hover:scale-105">Save Staff</button>
            </div>
        </form>
    </div>
</div>

<!-- Patient Modal -->
<div id="patientModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center hidden z-50 overflow-y-auto py-8">
    <div class="bg-white dark:bg-gray-800 rounded-2xl p-8 w-[800px] shadow-2xl my-8 transform scale-95 animate-scale-in">
        <div class="text-center mb-6">
            <div class="w-16 h-16 bg-gradient-to-br from-purple-500 to-purple-600 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                </svg>
            </div>
            <h3 id="modalTitlePatient" class="text-2xl font-bold text-gray-900 dark:text-white">Add New Patient</h3>
        </div>
        <form id="patientForm" action="${pageContext.request.contextPath}/admin/users/add?role=PATIENT" method="post" class="space-y-4">
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
                        Password <span class="text-gray-500 text-sm">(leave blank to keep current)</span>
                    </label>
                    <input type="password" name="password" id="patientPassword" placeholder="••••••••" class="w-full border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
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
                <button type="button" onclick="closeAllModals()" class="px-6 py-2.5 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg font-medium transition-colors">Cancel</button>
                <button type="submit" id="submitButtonPatient" class="px-6 py-2.5 bg-gradient-to-r from-purple-600 to-purple-700 text-white rounded-lg hover:from-purple-700 hover:to-purple-800 font-medium shadow-lg transition-all transform hover:scale-105">Save Patient</button>
            </div>
        </form>
    </div>
</div>

<!-- SweetAlert2 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- Include Footer -->
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
</style>

<!-- JavaScript for Modal Control -->
<script>
    function openUserTypeModal() {
        document.getElementById('userTypeModal').classList.remove('hidden');
    }

    function closeUserTypeModal() {
        document.getElementById('userTypeModal').classList.add('hidden');
    }

    function showUserForm(type) {
        closeUserTypeModal();
        closeAllModals();
        // Reset form to add mode
        resetFormToAdd(type);
        document.getElementById(type + 'Modal').classList.remove('hidden');
    }

    function closeAllModals() {
        ['userTypeModal','doctorModal','staffModal','patientModal'].forEach(id => {
            document.getElementById(id).classList.add('hidden');
        });
    }

    // دالة لعرض نموذج التعديل حسب نوع المستخدم
    function showEditUserForm(id, fullName, email, role) {
        closeAllModals();

        if (role === 'DOCTOR') {
            showEditDoctorForm(id, fullName, email);
        } else if (role === 'STAFF') {
            showEditStaffForm(id, fullName, email);
        } else if (role === 'PATIENT') {
            showEditPatientForm(id, fullName, email);
        } else {
            alert('Edit feature for ' + role + ' is not implemented yet');
        }
    }

    // دالة لعرض نموذج تعديل الدكتور
    function showEditDoctorForm(id, fullName, email) {
        document.getElementById('doctorId').value = id;
        document.getElementById('doctorFullName').value = fullName;
        document.getElementById('doctorEmail').value = email;

        // Reset other fields (you can fetch real data from server here)
        document.getElementById('doctorMatricule').value = '';
        document.getElementById('doctorSpecialite').value = '';
        document.getElementById('doctorPassword').value = '';

        // Update form for edit mode
        document.getElementById('formActionDoctor').value = 'edit';
        document.getElementById('modalTitleDoctor').textContent = 'Update Doctor';
        document.getElementById('submitButtonDoctor').textContent = 'Update Doctor';

        // Show modal
        document.getElementById('doctorModal').classList.remove('hidden');
    }

    // دالة لعرض نموذج تعديل الموظف
    function showEditStaffForm(id, fullName, email) {
        document.getElementById('staffId').value = id;
        document.getElementById('staffFullName').value = fullName;
        document.getElementById('staffEmail').value = email;

        // Reset other fields
        document.getElementById('staffPosition').value = '';
        document.getElementById('staffPassword').value = '';

        // Update form for edit mode
        document.getElementById('formActionStaff').value = 'edit';
        document.getElementById('modalTitleStaff').textContent = 'Update Staff';
        document.getElementById('submitButtonStaff').textContent = 'Update Staff';

        // Show modal
        document.getElementById('staffModal').classList.remove('hidden');
    }

    // دالة لعرض نموذج تعديل المريض
    function showEditPatientForm(id, fullName, email) {
        document.getElementById('patientId').value = id;
        document.getElementById('patientFullName').value = fullName;
        document.getElementById('patientEmail').value = email;

        // Reset other fields
        document.getElementById('patientCin').value = '';
        document.getElementById('patientDateOfBirth').value = '';
        document.getElementById('patientPassword').value = '';
        document.getElementById('patientGender').value = '';
        document.getElementById('patientBloodType').value = '';
        document.getElementById('patientInsuranceNumber').value = '';

        // Update form for edit mode
        document.getElementById('formActionPatient').value = 'edit';
        document.getElementById('modalTitlePatient').textContent = 'Update Patient';
        document.getElementById('submitButtonPatient').textContent = 'Update Patient';

        // Show modal
        document.getElementById('patientModal').classList.remove('hidden');
    }

    // دالة لإعادة تعيين النموذج لوضع الإضافة
    function resetFormToAdd(type) {
        const form = document.getElementById(type + 'Form');
        if (form) {
            form.reset();
            document.getElementById('formAction' + type.charAt(0).toUpperCase() + type.slice(1)).value = 'add';
            document.getElementById('modalTitle' + type.charAt(0).toUpperCase() + type.slice(1)).textContent = 'Add New ' + type.charAt(0).toUpperCase() + type.slice(1);
            document.getElementById('submitButton' + type.charAt(0).toUpperCase() + type.slice(1)).textContent = 'Save ' + type.charAt(0).toUpperCase() + type.slice(1);
            document.getElementById(type + 'Id').value = '';
        }
    }

    // دالة SweetAlert للحذف
    function confirmDeleteUser(id, fullName, role) {
        const escapedName = fullName.replace(/'/g, "\\'").replace(/"/g, '&quot;');

        Swal.fire({
            title: 'Are you sure?',
            html: `You are about to delete ${role.toLowerCase()}: <strong>${escapedName}</strong>`,
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
                Swal.fire({
                    title: 'Deleting...',
                    text: 'Please wait while we delete the user',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });

                window.location.href = '${pageContext.request.contextPath}/admin/users/delete?id=' + id;
            }
        });
    }

    // Close modal when clicking outside
    document.addEventListener('click', function(e) {
        const modals = ['userTypeModal', 'doctorModal', 'staffModal', 'patientModal'];
        modals.forEach(modalId => {
            const modal = document.getElementById(modalId);
            if (e.target === modal) {
                closeAllModals();
            }
        });
    });

    // Close modal with Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeAllModals();
        }
    });

    // Show success/error messages
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