<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clinique Digitale - Professional Healthcare Solutions</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            darkMode: 'class',
        }
    </script>
    <style>
        * {
            font-family: 'Inter', sans-serif;
        }

        .fade-in {
            animation: fadeIn 1s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .hover-lift {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .hover-lift:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        }

        /* Mobile menu animation */
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .mobile-menu-enter {
            animation: slideDown 0.2s ease-out;
        }
    </style>
    <script>
        if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            document.documentElement.classList.add('dark')
        }
    </script>
</head>
<body class="bg-white dark:bg-gray-900 text-gray-900 dark:text-white antialiased">

<!-- Navigation -->
<nav class="fixed w-full top-0 z-50 bg-white/95 dark:bg-gray-900/95 backdrop-blur-md shadow-sm transition-all duration-300">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16 md:h-20">
            <a href="${pageContext.request.contextPath}/" class="flex items-center space-x-3">
                <div class="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
                    <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"/>
                    </svg>
                </div>
                <div>
                    <h1 class="text-lg font-bold text-gray-900 dark:text-white">Clinique Digitale</h1>
                    <p class="text-xs text-gray-500 dark:text-gray-400">Healthcare Platform</p>
                </div>
            </a>

            <div class="hidden md:flex items-center space-x-6 lg:space-x-8">
                <a href="#home" class="text-sm font-medium text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 transition-colors">Home</a>
                <a href="#services" class="text-sm font-medium text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 transition-colors">Services</a>
                <a href="#about" class="text-sm font-medium text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 transition-colors">About</a>
                <a href="#contact" class="text-sm font-medium text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 transition-colors">Contact</a>

                <button id="themeToggle" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
                    <svg class="w-5 h-5 hidden dark:block" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"/>
                    </svg>
                    <svg class="w-5 h-5 dark:hidden" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" clip-rule="evenodd"/>
                    </svg>
                </button>

                <a href="${pageContext.request.contextPath}/login" class="text-sm font-medium text-gray-700 dark:text-gray-300 hover:text-blue-600 transition-colors">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="bg-blue-600 text-white px-4 lg:px-6 py-2 rounded-lg text-sm font-medium hover:bg-blue-700 transition-colors">Register</a>
            </div>

            <div class="flex items-center space-x-2 md:hidden">
                <button id="themeToggleMobile" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800">
                    <svg class="w-5 h-5 hidden dark:block" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"/>
                    </svg>
                    <svg class="w-5 h-5 dark:hidden" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" clip-rule="evenodd"/>
                    </svg>
                </button>
                <button id="mobileMenuBtn" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
                    </svg>
                </button>
            </div>
        </div>

        <div id="mobileMenu" class="hidden md:hidden pb-4 space-y-3 mobile-menu-enter border-t dark:border-gray-800">
            <a href="#home" class="block py-2 text-sm font-medium text-gray-700 dark:text-gray-300 hover:text-blue-600">Home</a>
            <a href="#services" class="block py-2 text-sm font-medium text-gray-700 dark:text-gray-300 hover:text-blue-600">Services</a>
            <a href="#about" class="block py-2 text-sm font-medium text-gray-700 dark:text-gray-300 hover:text-blue-600">About</a>
            <a href="#contact" class="block py-2 text-sm font-medium text-gray-700 dark:text-gray-300 hover:text-blue-600">Contact</a>
            <a href="${pageContext.request.contextPath}/login" class="block py-2 text-sm font-medium text-gray-700 dark:text-gray-300">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="block bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-medium text-center">Register</a>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section id="home" class="pt-20 md:pt-32 pb-12 md:pb-20 px-4 bg-gradient-to-b from-gray-50 to-white dark:from-gray-900 dark:to-gray-800">
    <div class="max-w-7xl mx-auto">
        <div class="grid lg:grid-cols-2 gap-8 md:gap-12 items-center">
            <div class="space-y-6 md:space-y-8 fade-in text-center lg:text-left">
                <div class="inline-flex items-center space-x-2 bg-blue-50 dark:bg-blue-900/20 px-3 md:px-4 py-2 rounded-full mx-auto lg:mx-0">
                    <span class="w-2 h-2 bg-blue-600 rounded-full animate-pulse"></span>
                    <span class="text-xs md:text-sm font-medium text-blue-600 dark:text-blue-400">Professional Healthcare Platform</span>
                </div>

                <h1 class="text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-bold leading-tight">
                    Advanced Healthcare
                    <span class="block text-blue-600">Management System</span>
                </h1>

                <p class="text-base md:text-lg text-gray-600 dark:text-gray-400 leading-relaxed max-w-2xl mx-auto lg:mx-0">
                    Streamline your healthcare operations with our comprehensive digital platform.
                    Secure, efficient, and designed for modern medical practices.
                </p>

                <div class="flex flex-col sm:flex-row gap-3 md:gap-4 justify-center lg:justify-start">
                    <a href="${pageContext.request.contextPath}/register" class="inline-flex items-center justify-center bg-blue-600 text-white px-6 md:px-8 py-3 rounded-lg font-medium hover:bg-blue-700 transition-colors text-sm md:text-base">
                        Get Started
                        <svg class="w-4 h-4 md:w-5 md:h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"/>
                        </svg>
                    </a>
                    <a href="#services" class="inline-flex items-center justify-center border-2 border-gray-300 dark:border-gray-700 px-6 md:px-8 py-3 rounded-lg font-medium hover:border-blue-600 transition-colors text-sm md:text-base">
                        Learn More
                    </a>
                </div>

                <div class="flex flex-wrap items-center justify-center lg:justify-start gap-4 md:gap-8 pt-4">
                    <div class="text-center">
                        <p class="text-2xl md:text-3xl font-bold text-blue-600">1000+</p>
                        <p class="text-xs md:text-sm text-gray-600 dark:text-gray-400">Providers</p>
                    </div>
                    <div class="h-8 md:h-12 w-px bg-gray-300 dark:bg-gray-700"></div>
                    <div class="text-center">
                        <p class="text-2xl md:text-3xl font-bold text-blue-600">50K+</p>
                        <p class="text-xs md:text-sm text-gray-600 dark:text-gray-400">Patients</p>
                    </div>
                    <div class="h-8 md:h-12 w-px bg-gray-300 dark:bg-gray-700"></div>
                    <div class="text-center">
                        <p class="text-2xl md:text-3xl font-bold text-blue-600">24/7</p>
                        <p class="text-xs md:text-sm text-gray-600 dark:text-gray-400">Support</p>
                    </div>
                </div>
            </div>

            <div class="relative hidden lg:block">
                <div class="relative bg-white dark:bg-gray-800 rounded-2xl shadow-2xl p-6 md:p-8">
                    <div class="absolute -top-3 md:-top-4 -right-3 md:-right-4 bg-blue-600 text-white px-3 md:px-4 py-2 rounded-lg text-xs md:text-sm font-medium">
                        Secure & Compliant
                    </div>

                    <div class="space-y-4 md:space-y-6">
                        <div class="flex items-center space-x-3 md:space-x-4 p-3 md:p-4 bg-gray-50 dark:bg-gray-700 rounded-xl">
                            <div class="w-10 h-10 md:w-12 md:h-12 bg-blue-100 dark:bg-blue-900/30 rounded-lg flex items-center justify-center flex-shrink-0">
                                <svg class="w-5 h-5 md:w-6 md:h-6 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                            <div class="flex-1 min-w-0">
                                <p class="font-semibold text-xs md:text-sm truncate">Appointment Management</p>
                                <p class="text-xs text-gray-600 dark:text-gray-400 truncate">Efficient scheduling</p>
                            </div>
                        </div>

                        <div class="flex items-center space-x-3 md:space-x-4 p-3 md:p-4 bg-gray-50 dark:bg-gray-700 rounded-xl">
                            <div class="w-10 h-10 md:w-12 md:h-12 bg-green-100 dark:bg-green-900/30 rounded-lg flex items-center justify-center flex-shrink-0">
                                <svg class="w-5 h-5 md:w-6 md:h-6 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                                    <path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                            <div class="flex-1 min-w-0">
                                <p class="font-semibold text-xs md:text-sm truncate">Medical Records</p>
                                <p class="text-xs text-gray-600 dark:text-gray-400 truncate">Secure digital storage</p>
                            </div>
                        </div>

                        <div class="grid grid-cols-2 gap-3 md:gap-4 pt-2 md:pt-4">
                            <div class="text-center p-3 md:p-4 border-2 border-gray-200 dark:border-gray-700 rounded-lg">
                                <p class="text-xl md:text-2xl font-bold text-blue-600">99.9%</p>
                                <p class="text-xs text-gray-600 dark:text-gray-400 mt-1">Uptime</p>
                            </div>
                            <div class="text-center p-3 md:p-4 border-2 border-gray-200 dark:border-gray-700 rounded-lg">
                                <p class="text-xl md:text-2xl font-bold text-blue-600">HIPAA</p>
                                <p class="text-xs text-gray-600 dark:text-gray-400 mt-1">Compliant</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Services Section -->
<section id="services" class="py-12 md:py-20 px-4 bg-white dark:bg-gray-800">
    <div class="max-w-7xl mx-auto">
        <div class="text-center mb-10 md:mb-16">
            <h2 class="text-2xl md:text-3xl lg:text-4xl font-bold mb-3 md:mb-4">Comprehensive Healthcare Solutions</h2>
            <p class="text-base md:text-lg text-gray-600 dark:text-gray-400 max-w-2xl mx-auto px-4">
                Enterprise-grade features designed for modern healthcare providers
            </p>
        </div>

        <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-8">
            <div class="hover-lift bg-gray-50 dark:bg-gray-700 p-6 md:p-8 rounded-xl">
                <div class="w-12 h-12 md:w-14 md:h-14 bg-blue-100 dark:bg-blue-900/30 rounded-lg flex items-center justify-center mb-4 md:mb-6">
                    <svg class="w-6 h-6 md:w-7 md:h-7 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <h3 class="text-lg md:text-xl font-bold mb-2 md:mb-3">Patient Management</h3>
                <p class="text-sm md:text-base text-gray-600 dark:text-gray-400 leading-relaxed">
                    Complete patient lifecycle management with advanced tracking and reporting.
                </p>
            </div>

            <div class="hover-lift bg-gray-50 dark:bg-gray-700 p-6 md:p-8 rounded-xl">
                <div class="w-12 h-12 md:w-14 md:h-14 bg-green-100 dark:bg-green-900/30 rounded-lg flex items-center justify-center mb-4 md:mb-6">
                    <svg class="w-6 h-6 md:w-7 md:h-7 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <h3 class="text-lg md:text-xl font-bold mb-2 md:mb-3">Appointment Scheduling</h3>
                <p class="text-sm md:text-base text-gray-600 dark:text-gray-400 leading-relaxed">
                    Intelligent scheduling with automated reminders and conflict resolution.
                </p>
            </div>

            <div class="hover-lift bg-gray-50 dark:bg-gray-700 p-6 md:p-8 rounded-xl sm:col-span-2 lg:col-span-1">
                <div class="w-12 h-12 md:w-14 md:h-14 bg-purple-100 dark:bg-purple-900/30 rounded-lg flex items-center justify-center mb-4 md:mb-6">
                    <svg class="w-6 h-6 md:w-7 md:h-7 text-purple-600" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <h3 class="text-lg md:text-xl font-bold mb-2 md:mb-3">Security & Compliance</h3>
                <p class="text-sm md:text-base text-gray-600 dark:text-gray-400 leading-relaxed">
                    Enterprise-grade security with full HIPAA and GDPR compliance.
                </p>
            </div>
        </div>
    </div>
</section>

<!-- About Section -->
<section id="about" class="py-12 md:py-20 px-4 bg-gray-50 dark:bg-gray-900">
    <div class="max-w-7xl mx-auto">
        <div class="grid lg:grid-cols-2 gap-8 md:gap-12 items-center">
            <div>
                <h2 class="text-2xl md:text-3xl lg:text-4xl font-bold mb-4 md:mb-6">Why Choose Clinique Digitale?</h2>
                <p class="text-base md:text-lg text-gray-600 dark:text-gray-400 mb-6 md:mb-8 leading-relaxed">
                    We provide healthcare institutions with cutting-edge technology solutions.
                </p>

                <div class="space-y-4 md:space-y-6">
                    <div class="flex items-start space-x-3 md:space-x-4">
                        <div class="w-5 h-5 md:w-6 md:h-6 bg-blue-600 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5 md:mt-1">
                            <svg class="w-3 h-3 md:w-4 md:h-4 text-white" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                            </svg>
                        </div>
                        <div>
                            <h3 class="font-semibold text-sm md:text-base mb-1">Enterprise-Grade Security</h3>
                            <p class="text-sm md:text-base text-gray-600 dark:text-gray-400">Bank-level encryption and multi-factor authentication</p>
                        </div>
                    </div>

                    <div class="flex items-start space-x-3 md:space-x-4">
                        <div class="w-5 h-5 md:w-6 md:h-6 bg-blue-600 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5 md:mt-1">
                            <svg class="w-3 h-3 md:w-4 md:h-4 text-white" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                            </svg>
                        </div>
                        <div>
                            <h3 class="font-semibold text-sm md:text-base mb-1">24/7 Professional Support</h3>
                            <p class="text-sm md:text-base text-gray-600 dark:text-gray-400">Dedicated support team available round the clock</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="bg-white dark:bg-gray-800 rounded-xl shadow-xl p-6 md:p-8">
                <h3 class="text-xl md:text-2xl font-bold mb-4 md:mb-6">Trusted by Healthcare Leaders</h3>
                <div class="space-y-4 md:space-y-6">
                    <div class="border-l-4 border-blue-600 pl-3 md:pl-4">
                        <p class="text-sm md:text-base text-gray-600 dark:text-gray-400 italic mb-2">
                            "Clinique Digitale has transformed how we manage our practice."
                        </p>
                        <p class="font-semibold text-sm md:text-base">Dr. Ahmed Benani</p>
                        <p class="text-xs md:text-sm text-gray-500">CMO, Casablanca Medical Center</p>
                    </div>
                </div>

                <div class="grid grid-cols-3 gap-3 md:gap-4 mt-6 md:mt-8 pt-6 md:pt-8 border-t dark:border-gray-700">
                    <div class="text-center">
                        <p class="text-xl md:text-2xl font-bold text-blue-600">50+</p>
                        <p class="text-xs text-gray-600 dark:text-gray-400">Hospitals</p>
                    </div>
                    <div class="text-center">
                        <p class="text-xl md:text-2xl font-bold text-blue-600">200+</p>
                        <p class="text-xs text-gray-600 dark:text-gray-400">Clinics</p>
                    </div>
                    <div class="text-center">
                        <p class="text-xl md:text-2xl font-bold text-blue-600">98%</p>
                        <p class="text-xs text-gray-600 dark:text-gray-400">Satisfaction</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Contact Section -->
<section id="contact" class="py-12 md:py-20 px-4 bg-white dark:bg-gray-800">
    <div class="max-w-7xl mx-auto">
        <div class="text-center mb-10 md:mb-16">
            <h2 class="text-2xl md:text-3xl lg:text-4xl font-bold mb-3 md:mb-4">Get in Touch</h2>
            <p class="text-base md:text-lg text-gray-600 dark:text-gray-400">
                Our team is ready to assist you
            </p>
        </div>

        <div class="grid lg:grid-cols-2 gap-8 md:gap-12">
            <div class="space-y-6 md:space-y-8">
                <div class="flex items-start space-x-3 md:space-x-4">
                    <a href="${pageContext.request.contextPath}/" class="flex items-center space-x-3">
                        <div class="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"/>
                            </svg>
                        </div>
                        <div>
                            <h1 class="text-lg font-bold text-gray-900 dark:text-white">Clinique Digitale</h1>
                            <p class="text-xs text-gray-500 dark:text-gray-400">Healthcare Platform</p>
                        </div>
                    </a>
                    <div>
                        <h3 class="font-semibold text-sm md:text-base mb-1">Email</h3>
                        <p class="text-sm md:text-base text-gray-600 dark:text-gray-400">contact@cliniquedigitale.ma</p>
                    </div>
                </div>

                <div class="flex items-start space-x-3 md:space-x-4">
                    <div class="w-10 h-10 md:w-12 md:h-12 bg-blue-100 dark:bg-blue-900/30 rounded-lg flex items-center justify-center flex-shrink-0">
                        <svg class="w-5 h-5 md:w-6 md:h-6 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z"/>
                        </svg>
                    </div>
                    <div>
                        <h3 class="font-semibold text-sm md:text-base mb-1">Phone</h3>
                        <p class="text-sm md:text-base text-gray-600 dark:text-gray-400">+212 5 22-XX-XX-XX</p>
                    </div>
                </div>
            </div>

            <div class="bg-gray-50 dark:bg-gray-700 p-6 md:p-8 rounded-xl">
                <form class="space-y-4 md:space-y-6">
                    <div>
                        <label class="block text-sm font-medium mb-1.5 md:mb-2">Full Name</label>
                        <input type="text" class="w-full px-3 md:px-4 py-2 md:py-3 rounded-lg border border-gray-300 dark:border-gray-600 dark:bg-gray-800 focus:ring-2 focus:ring-blue-600 outline-none text-sm md:text-base" placeholder="John Doe">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-1.5 md:mb-2">Email</label>
                        <input type="email" class="w-full px-3 md:px-4 py-2 md:py-3 rounded-lg border border-gray-300 dark:border-gray-600 dark:bg-gray-800 focus:ring-2 focus:ring-blue-600 outline-none text-sm md:text-base" placeholder="john@example.com">
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-1.5 md:mb-2">Message</label>
                        <textarea rows="3" class="w-full px-3 md:px-4 py-2 md:py-3 rounded-lg border border-gray-300 dark:border-gray-600 dark:bg-gray-800 focus:ring-2 focus:ring-blue-600 outline-none text-sm md:text-base" placeholder="Your message..."></textarea>
                    </div>

                    <button type="submit" class="w-full bg-blue-600 text-white px-4 md:px-6 py-2.5 md:py-3 rounded-lg font-medium hover:bg-blue-700 transition-colors text-sm md:text-base">
                        Send Message
                    </button>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gray-900 text-white py-8 md:py-12 px-4">
    <div class="max-w-7xl mx-auto">
        <div class="grid grid-cols-2 md:grid-cols-4 gap-6 md:gap-8 mb-6 md:mb-8">
            <div class="col-span-2 md:col-span-1">
                <div class="flex items-center space-x-2 mb-3 md:mb-4">
                    <svg class="w-6 h-6 md:w-8 md:h-8 text-blue-600" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 2L2 7v10c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V7l-10-5zm0 18c-3.15-.78-6-4.42-6-8V8.3l6-3.08 6 3.08V12c0 3.58-2.85 7.22-6 8z"/>
                    </svg>
                    <span class="text-lg md:text-xl font-bold">Clinique Digitale</span>
                </div>
                <p class="text-gray-400 text-xs md:text-sm">Professional healthcare solutions</p>
            </div>

            <div>
                <h3 class="font-semibold mb-3 md:mb-4 text-sm md:text-base">Platform</h3>
                <ul class="space-y-1.5 md:space-y-2 text-xs md:text-sm text-gray-400">
                    <li><a href="#" class="hover:text-blue-400 transition-colors">Features</a></li>
                    <li><a href="#" class="hover:text-blue-400 transition-colors">Security</a></li>
                </ul>
            </div>

            <div>
                <h3 class="font-semibold mb-3 md:mb-4 text-sm md:text-base">Company</h3>
                <ul class="space-y-1.5 md:space-y-2 text-xs md:text-sm text-gray-400">
                    <li><a href="#" class="hover:text-blue-400 transition-colors">About</a></li>
                    <li><a href="#" class="hover:text-blue-400 transition-colors">Contact</a></li>
                </ul>
            </div>

            <div>
                <h3 class="font-semibold mb-3 md:mb-4 text-sm md:text-base">Legal</h3>
                <ul class="space-y-1.5 md:space-y-2 text-xs md:text-sm text-gray-400">
                    <li><a href="#" class="hover:text-blue-400 transition-colors">Privacy</a></li>
                    <li><a href="#" class="hover:text-blue-400 transition-colors">Terms</a></li>
                </ul>
            </div>
        </div>

        <div class="border-t border-gray-800 pt-6 md:pt-8 text-center">
            <p class="text-xs md:text-sm text-gray-400">&copy; 2025 Clinique Digitale. All rights reserved.</p>
        </div>
    </div>
</footer>

<script>
    // Theme Toggle
    const themeToggle = document.getElementById('themeToggle');
    const themeToggleMobile = document.getElementById('themeToggleMobile');
    const html = document.documentElement;

    function toggleTheme() {
        html.classList.toggle('dark');
        localStorage.theme = html.classList.contains('dark') ? 'dark' : 'light';
    }

    themeToggle.addEventListener('click', toggleTheme);
    themeToggleMobile.addEventListener('click', toggleTheme);

    // Mobile Menu
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const mobileMenu = document.getElementById('mobileMenu');

    mobileMenuBtn.addEventListener('click', () => {
        mobileMenu.classList.toggle('hidden');
    });

    // Smooth Scroll
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                mobileMenu.classList.add('hidden');
            }
        });
    });

    // Initialize dark mode
    if (localStorage.theme === 'dark') {
        html.classList.add('dark');
    }
</script>

</body>
</html>