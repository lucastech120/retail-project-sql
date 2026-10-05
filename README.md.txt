# Proyecto Retail - Pre-entrega SQL

Esquema base del proyecto retail (`clientes`, `productos`, `ventas`) con restricciones de integridad y carga inicial de datos, en PostgreSQL.

## Contenido

- `script.sql`: crea las tablas, carga los datos iniciales (dentro de transacciones `BEGIN ... COMMIT`) y ejecuta un `UPDATE` y un `DELETE` de mantenimiento.

## Requisitos

- PostgreSQL

## Cómo ejecutarlo

1. Crear la base de datos:

```sql
   CREATE DATABASE retail_project;
```

2. Ejecutar el script sobre esa base:

```bash
   psql -U postgres -d retail_project -f script.sql
```

   También se puede abrir `script.sql` en pgAdmin, conectarse a `retail_project` y ejecutarlo completo.

El script se puede ejecutar más de una vez: al inicio elimina las tablas existentes y las vuelve a crear.