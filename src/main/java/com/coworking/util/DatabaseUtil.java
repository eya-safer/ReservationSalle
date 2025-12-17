package com.coworking.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/reservation_salle?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    private DatabaseUtil() {
    }

    static {
        try {
            Class.forName(DRIVER);
            System.out.println("Driver MySQL chargé avec succès");
        } catch (ClassNotFoundException e) {
            System.err.println(" Erreur: Driver MySQL non trouvé");
            e.printStackTrace();
            throw new RuntimeException("Driver MySQL non disponible", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            return conn;
        } catch (SQLException e) {
            System.err.println("❌ Erreur de connexion à la base de données");
            System.err.println("URL: " + URL);
            System.err.println("Message: " + e.getMessage());
            throw e;
        }
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println(" Erreur lors de la fermeture de la connexion");
                e.printStackTrace();
            }
        }
    }

    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            System.out.println(" Connexion à la base de données réussie");
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println(" Échec de connexion à la base de données");
            e.printStackTrace();
            return false;
        }
    }
}
