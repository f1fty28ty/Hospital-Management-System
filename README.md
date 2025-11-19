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
   - Open your browser and go to: **http://localhost:8080**
   - **Login credentials (fill from top to bottom):**
     1. **System:** Select `MySQL` from the dropdown
     2. **Server:** `mysql` ⚠️ **NOT** `localhost` or `127.0.0.1`! (this is the Docker service name)
     3. **Username:** `hmsAdmin`
     4. **Password:** `hmsPass`
     5. **Database:** `hmsDB` (or leave blank to see all databases)

3. **Connect directly to MySQL (optional):**
   ```bash
   mysql -h 127.0.0.1 -P 3306 -u hmsAdmin -phmsPass hmsDB
   ```
   
   Or using Docker exec:
   ```bash
   docker exec -it hmsMySQL mysql -u hmsAdmin -phmsPass hmsDB
   ```

4. **Stop the services:**
   ```bash
   docker-compose down
   ```

5. **Stop and remove all data:**
   ```bash
   docker-compose down -v
   ```

## Database Credentials Summary

| Purpose | Host/Server | Port | Username | Password | Database |
|---------|-------------|------|----------|----------|----------|
| **Adminer Web UI** | `mysql` | `8080` | `hmsAdmin` | `hmsPass` | `hmsDB` |
| **Direct MySQL Connection** | `127.0.0.1` or `localhost` | `3306` | `hmsAdmin` | `hmsPass` | `hmsDB` |
| **MySQL Root Access** | `127.0.0.1` or `localhost` | `3306` | `root` | `hmsRoot` | `hmsDB` |

**Note:** For Adminer, access via browser at `http://localhost:8080`, but use `mysql` as the Server field inside the login form.

## File Structure

- `docker-compose.yml` - Docker configuration for MySQL and Adminer
- `schema_mysql.sql` - MySQL-compatible schema (auto-loaded on startup)
- `seed.sql` - Database seed data (auto-loaded on startup)
- `demo.sql` - Demonstration script with DDL and DML examples
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
- `MYSQL_ROOT_PASSWORD` - Root user password (default: `hmsRoot`)
- `MYSQL_DATABASE` - Database name (default: `hmsDB`)
- `MYSQL_USER` - Application user (default: `hmsAdmin`)
- `MYSQL_PASSWORD` - Application user password (default: `hmsPass`)

## Troubleshooting

### Adminer Login Issues

**Problem:** Cannot connect to database through Adminer

**Solutions:**
- ✅ **Access Adminer at http://localhost:8080** in your browser
- ✅ **Server field MUST be `mysql`** (the Docker service name), NOT `localhost` or `127.0.0.1`
- ✅ Verify credentials: Username = `hmsAdmin`, Password = `hmsPass`, Database = `hmsDB`
- ✅ Check containers are running: `docker-compose ps`
- ✅ Both `hmsMySQL` and `hmsAdminer` should show "Up" status

**Test the MySQL connection directly:**
```bash
docker exec -it hmsMySQL mysql -u hmsAdmin -phmsPass hmsDB -e "SELECT 1;"
```

If this works but Adminer doesn't, the issue is with the Server field in Adminer (use `mysql`).

### Other Common Issues

**Ports already in use:**
- If ports 3306 or 8080 are already in use, modify them in `docker-compose.yml`
- Example: Change `"3306:3306"` to `"3307:3306"` for MySQL
- Example: Change `"8080:8080"` to `"8081:8080"` for Adminer (then access at http://localhost:8081)

**Database not initializing:**
- Ensure `schema_mysql.sql` and `seed.sql` are in the project directory
- Check logs: `docker-compose logs -f mysql`
- Rebuild from scratch: `docker-compose down -v && docker-compose up -d`

### Useful Commands

- **View logs:** `docker-compose logs -f`
- **Check container status:** `docker-compose ps`
- **Restart services:** `docker-compose restart`
- **Rebuild from scratch:** `docker-compose down -v && docker-compose up -d`
- **Test MySQL connection:** `docker exec -it hmsMySQL mysql -u hmsAdmin -phmsPass hmsDB -e "SHOW TABLES;"`
- **Access MySQL shell:** `docker exec -it hmsMySQL mysql -u hmsAdmin -phmsPass hmsDB`
- **View MySQL error log:** `docker-compose logs mysql`

## License

BSD 3-Clause License - See LICENSE file for details