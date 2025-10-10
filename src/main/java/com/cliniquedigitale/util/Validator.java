package com.cliniquedigitale.util;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

public class Validator {

    private Map<String, String> errors = new HashMap<>();

    public void required(String field, String value, String message) {
        if (value == null || value.trim().isEmpty()) {
            errors.put(field, message);
        }
    }

    public void email(String field, String value, String message) {
        if (value == null || !Pattern.matches("^[A-Za-z0-9+_.-]+@(.+)$", value)) {
            errors.put(field, message);
        }
    }

    public void minLength(String field, String value, int length, String message) {
        if (value == null || value.length() < length) {
            errors.put(field, message);
        }
    }

    public void regex(String field, String value, String pattern, String message) {
        if (value == null || !Pattern.matches(pattern, value)) {
            errors.put(field, message);
        }
    }

    /**
     * Add custom error
     */
    public void addError(String field, String message) {
        errors.put(field, message);
    }

    public boolean hasErrors() {
        return !errors.isEmpty();
    }

    public Map<String, String> getErrors() {
        return errors;
    }
}