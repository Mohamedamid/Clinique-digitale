<%@ page contentType="text/html;charset=UTF-8" %>

<script>
    const themeToggle = document.getElementById('themeToggle');
    const html = document.documentElement;
    if (themeToggle) {
        themeToggle.addEventListener('click', () => {
            html.classList.toggle('dark');
            localStorage.theme = html.classList.contains('dark') ? 'dark' : 'light';
        });
    }
</script>
</body>
</html>
