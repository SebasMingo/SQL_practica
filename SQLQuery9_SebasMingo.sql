SELECT TOP 5 Text, CreationDate -- Selecciona los 5 comentarios más recientes, incluyendo los campos Text y CreationDate
FROM Comments -- De la tabla Comments
ORDER BY CreationDate DESC; -- Ordena los resultados por CreationDate en orden descendentea