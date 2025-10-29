# Hospital Management System - SQLutions Inc.

A comprehensive hospital management system with MySQL database and Adminer web interface.

## Quick Start

This project uses Docker Compose to run MySQL and Adminer.

### Prerequisites
- Docker Desktop (or Docker Engine + Docker Compose)
- Git

### Running the Application

1. **Start the services:**
   ```bash
   docker-compose up -d
   ```

2. **Access Adminer (Database Management UI):**
   - Open your browser and go to: http://localhost:8080
   - Login with:
     - **System:** MySQL
     - **Server:** mysql
     - **Username:** hospital_user
     - **Password:** hospital_password
     - **Database:** hospital_db

3. **Connect directly to MySQL (optional):**
   ```bash
   mysql -h 127.0.0.1 -P 3306 -u hospital_user -phospital_password hospital_db
   ```

4. **Stop the services:**
   ```bash
   docker-compose down
   ```

5. **Stop and remove all data:**
   ```bash
   docker-compose down -v
   ```

## File Structure

- `docker-compose.yml` - Docker configuration for MySQL and Adminer
- `schema.sql` - PostgreSQL-compatible schema (original)
- `schema_mysql.sql` - MySQL-compatible schema (used by Docker)
- `seed.sql` - Database seed data (to be populated)

## Database Schema

The database includes:
- Departments, Rooms, Employees
- Patient management (Patients, Appointments, Medical History)
- Lab Tests and Results
- Prescriptions and Pharmacy Stock
- Invoicing and Billing

## Notes

- The original `schema.sql` uses PostgreSQL-specific features
- `schema_mysql.sql` has been converted to use MySQL ENUM types and syntax
- Row Level Security (RLS) is not supported in MySQL (removed from MySQL schema)

## Environment Variables

You can customize database credentials by editing `docker-compose.yml`:
- `MYSQL_ROOT_PASSWORD`
- `MYSQL_DATABASE`
- `MYSQL_USER`
- `MYSQL_PASSWORD`

## Troubleshooting

- If port 3306 or 8080 is already in use, modify the ports in `docker-compose.yml`
- View logs: `docker-compose logs -f`
- Check container status: `docker-compose ps`
