package com.coworking.util;

public class PasswordUtil {

    public static String hashPassword(String plainPassword) {
        System.out.println("AVERTISSEMENT : Les mots de passe ne sont pas réellement hachés !");
        return plainPassword;
    }

    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        return plainPassword.equals(hashedPassword);
    }
}
