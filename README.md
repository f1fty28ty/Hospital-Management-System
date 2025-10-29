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
     - **System:** MySQL (select from dropdown)
     - **Server:** mysql ⚠️ **NOT** localhost or 127.0.0.1!
     - **Username:** hmsAdmin
     - **Password:** hmsPass
     - **Database:** hmsDB

3. **Connect directly to MySQL (optional):**
   ```bash
   mysql -h 127.0.0.1 -P 3306 -u hmsAdmin -phmsPass hmsDB
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
- `schema_mysql.sql` - MySQL-compatible schema (auto-loaded on startup)
- `seed.sql` - Database seed data (auto-loaded on startup)
- `ADMINER_CREDENTIALS.md` - Quick reference for Adminer login credentials
- `schema.sql` - PostgreSQL-compatible schema (original, not used)

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

### Common Login Issues
- **Wrong Server name:** Use `mysql` NOT `localhost` or `127.0.0.1`
- **Credentials:** See the updated credentials in Section 2 above
- **Check container names:** Containers should be named `hmsMySQL` and `hmsAdminer`

### Other Commands

- **View logs:** `docker-compose logs -f`
- **Check container status:** `docker-compose ps`
- **Restart services:** `docker-compose restart`
- **Rebuild from scratch:** `docker-compose down -v && docker-compose up -d`
- **Test MySQL connection:** `docker exec -it hmsMySQL mysql -u hmsAdmin -phmsPass hmsDB -e "SHOW TABLES;"`
- **If ports 3306 or 8080 are in use:** Modify the ports in `docker-compose.yml`
