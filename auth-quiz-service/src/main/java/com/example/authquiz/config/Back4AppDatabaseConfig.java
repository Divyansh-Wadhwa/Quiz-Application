package com.example.authquiz.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import javax.sql.DataSource;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.net.URI;
import java.net.URISyntaxException;

/**
 * Database configuration for Back4App deployment
 * Handles both DATABASE_URL format and individual environment variables
 */
@Configuration
@Profile("back4app")
public class Back4AppDatabaseConfig {

    @Bean
    public DataSource dataSource() {
        String databaseUrl = System.getenv("DATABASE_URL");
        
        HikariConfig config = new HikariConfig();
        
        if (databaseUrl != null && !databaseUrl.isEmpty() && !databaseUrl.startsWith("${")) {
            // Parse DATABASE_URL format: postgres://username:password@host:port/database
            try {
                URI uri = new URI(databaseUrl);
                
                String jdbcUrl = "jdbc:postgresql://" + uri.getHost() + ":" + uri.getPort() + uri.getPath() + "?sslmode=require";
                config.setJdbcUrl(jdbcUrl);
                
                String userInfo = uri.getUserInfo();
                if (userInfo != null) {
                    String[] userParts = userInfo.split(":");
                    config.setUsername(userParts[0]);
                    if (userParts.length > 1) {
                        config.setPassword(userParts[1]);
                    }
                }
                
                System.out.println("Using DATABASE_URL format: " + jdbcUrl);
                
            } catch (URISyntaxException e) {
                throw new RuntimeException("Invalid DATABASE_URL format: " + databaseUrl, e);
            }
        } else {
            // Use individual environment variables with SSL parameters
            String host = System.getenv().getOrDefault("DB_HOST", "localhost");
            String port = System.getenv().getOrDefault("DB_PORT", "5432");
            String database = System.getenv().getOrDefault("DB_NAME", "quiz_db");
            String username = System.getenv().getOrDefault("DB_USER", "postgres");
            String password = System.getenv().getOrDefault("DB_PASSWORD", "password");
            
            String jdbcUrl = "jdbc:postgresql://" + host + ":" + port + "/" + database + "?sslmode=require&ssl=true";
            config.setJdbcUrl(jdbcUrl);
            config.setUsername(username);
            config.setPassword(password);
            
            System.out.println("Using individual env vars: " + jdbcUrl);
            System.out.println("Username: " + username);
            System.out.println("Host: " + host);
        }
        
        config.setDriverClassName("org.postgresql.Driver");
        config.setMaximumPoolSize(3);  // Reduced for Supabase free tier
        config.setMinimumIdle(1);
        config.setConnectionTimeout(30000);  // Increased timeout
        config.setIdleTimeout(300000);  // 5 minutes
        config.setMaxLifetime(600000);  // 10 minutes
        
        // Add SSL configuration for Supabase
        config.addDataSourceProperty("sslmode", "require");
        config.addDataSourceProperty("ssl", "true");
        config.addDataSourceProperty("sslfactory", "org.postgresql.ssl.NonValidatingFactory");
        
        // Add additional connection properties for cloud databases
        config.addDataSourceProperty("tcpKeepAlive", "true");
        config.addDataSourceProperty("socketTimeout", "30");
        
        return new HikariDataSource(config);
    }
}
