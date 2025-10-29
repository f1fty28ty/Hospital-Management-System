# Adminer Login Credentials

**Quick Reference for Adminer Login**

## Access Adminer
Open your browser: http://localhost:8080

## Login Form Fields (Fill from top to bottom)

1. **System:** Select `MySQL` from the dropdown
2. **Server:** Type `mysql` (this is the Docker service name)
3. **Username:** Type `hmsAdmin`
4. **Password:** Type `hmsPass`
5. **Database:** Type `hmsDB` (or leave blank to see all databases)

## Testing the Connection

If Adminer login still fails, test with command line:
```bash
docker exec -it hmsMySQL mysql -u hmsAdmin -p hmsPass hmsDB -e "SELECT 1;"
```

If that works, the issue is with the Adminer Server field (must be `mysql`).

