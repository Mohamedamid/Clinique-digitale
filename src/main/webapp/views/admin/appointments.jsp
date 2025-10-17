<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%
    String activePage = "appointments";
%>

<%@ include file="layouts/header.jsp" %>
<%@ include file="layouts/sidebar.jsp" %>

<div class="lg:ml-64 pb-16">
    <%@ include file="layouts/mainHeader.jsp" %>

    <main class="p-6">
        <!-- Title and Add Button -->
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">Manage Appointments</h2>
            <button type="button" onclick="showAppointmentForm()"
                    class="bg-purple-600 text-white px-4 py-2 rounded-lg hover:bg-purple-700">
                + Add Appointment
            </button>
        </div>

        <!-- Filter & Search -->
        <form class="flex gap-4 mb-6" method="get" action="">
            <div>
                <input type="text" name="q" placeholder="Search by patient or doctor"
                       class="w-[350px] border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700
                       text-gray-900 dark:text-white p-3 rounded-lg focus:ring-2 focus:ring-purple-500
                       focus:border-transparent transition-all" />
            </div>
            <button type="submit"
                    class="bg-purple-600 text-white px-6 py-3 rounded-lg hover:bg-purple-700 font-medium shadow-lg
                    transition-all transform hover:scale-105">
                Search
            </button>
        </form>

        <!-- Appointments Table -->
        <div class="overflow-x-auto bg-white dark:bg-gray-800 rounded-xl shadow border border-gray-200 dark:border-gray-700">
            <table class="min-w-full text-sm text-left text-gray-500 dark:text-gray-400">
                <thead class="text-xs uppercase bg-gray-50 dark:bg-gray-700 text-gray-700 dark:text-gray-300">
                <tr>
                    <th class="px-6 py-3">ID</th>
                    <th class="px-6 py-3">Patient</th>
                    <th class="px-6 py-3">Doctor</th>
                    <th class="px-6 py-3">Date</th>
                    <th class="px-6 py-3">Time</th>
                    <th class="px-6 py-3">Status</th>
                    <th class="px-6 py-3">Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    // 🔹 Static dummy data for testing
                    class Appointment {
                        int id; String patient; String doctor; String date; String time; String status;
                        Appointment(int id, String p, String d, String date, String time, String status) {
                            this.id = id; this.patient = p; this.doctor = d; this.date = date; this.time = time; this.status = status;
                        }
                    }
                    List<Appointment> appointments = Arrays.asList(
                            new Appointment(1, "John Doe", "Dr. Smith", "2025-10-16", "10:30 AM", "CONFIRMED"),
                            new Appointment(2, "Jane Roe", "Dr. Brown", "2025-10-17", "02:00 PM", "PENDING"),
                            new Appointment(3, "Ali Hassan", "Dr. Ahmed", "2025-10-18", "09:00 AM", "CANCELLED")
                    );
                    for (Appointment app : appointments) {
                %>
                <tr class="border-t border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-700">
                    <td class="px-6 py-4"><%= app.id %></td>
                    <td class="px-6 py-4"><%= app.patient %></td>
                    <td class="px-6 py-4"><%= app.doctor %></td>
                    <td class="px-6 py-4"><%= app.date %></td>
                    <td class="px-6 py-4"><%= app.time %></td>
                    <td class="px-6 py-4">
                        <span class="px-3 py-1 rounded-full text-xs font-medium
                            <%= "CONFIRMED".equals(app.status) ? "bg-green-100 text-green-700" :
                                "PENDING".equals(app.status) ? "bg-yellow-100 text-yellow-700" :
                                "bg-red-100 text-red-700" %>">
                            <%= app.status %>
                        </span>
                    </td>
                    <td class="px-6 py-4 flex space-x-3">
                        <button onclick="showEditAppointment(<%= app.id %>)" class="text-blue-600 hover:underline">Edit</button>
                        <button onclick="confirmDeleteAppointment(<%= app.id %>)" class="text-red-600 hover:underline">Delete</button>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </main>
</div>

<!-- Appointment Modal -->
<div id="appointmentModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm hidden z-50 overflow-y-auto py-8">
    <div class="bg-white dark:bg-gray-800 rounded-2xl p-8 w-[700px] shadow-2xl my-8 mx-auto transform scale-95 animate-scale-in">
        <h3 id="modalTitleAppointment" class="text-2xl font-bold text-gray-900 dark:text-white mb-6">Add Appointment</h3>
        <form id="appointmentForm" class="space-y-4">
            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Patient</label>
                    <input type="text" class="w-full border border-gray-300 dark:border-gray-600 p-3 rounded-lg"
                           placeholder="Patient name">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Doctor</label>
                    <input type="text" class="w-full border border-gray-300 dark:border-gray-600 p-3 rounded-lg"
                           placeholder="Doctor name">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Date</label>
                    <input type="date" class="w-full border border-gray-300 dark:border-gray-600 p-3 rounded-lg">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Time</label>
                    <input type="time" class="w-full border border-gray-300 dark:border-gray-600 p-3 rounded-lg">
                </div>
            </div>
            <div class="flex justify-end gap-3 pt-4">
                <button type="button" onclick="closeAppointmentModal()"
                        class="px-6 py-2.5 text-gray-700 dark:text-gray-300 hover:bg-gray-100 rounded-lg font-medium transition-colors">
                    Cancel
                </button>
                <button type="submit"
                        class="px-6 py-2.5 bg-gradient-to-r from-purple-600 to-purple-700 text-white rounded-lg hover:from-purple-700 hover:to-purple-800 font-medium shadow-lg transition-all transform hover:scale-105">
                    Save
                </button>
            </div>
        </form>
    </div>
</div>

<!-- SweetAlert2 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    function showAppointmentForm() {
        document.getElementById('appointmentModal').classList.remove('hidden');
    }
    function closeAppointmentModal() {
        document.getElementById('appointmentModal').classList.add('hidden');
    }
    function confirmDeleteAppointment(id) {
        Swal.fire({
            title: 'Are you sure?',
            text: 'You are about to delete appointment #' + id,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, delete it!'
        });
    }
</script>

<%@ include file="layouts/footer.jsp" %>
