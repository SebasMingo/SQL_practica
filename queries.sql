--1

SELECT TOP 200 -- Selecciona las primeras 200 filas
    DisplayName, Location, Reputation -- Selecciona las columnas DisplayName, Location y Reputation
FROM Users -- De la tabla Users
ORDER BY Reputation DESC; -- Ordena los resultados por la columna Reputation de forma descendente

--2

SELECT TOP 200 -- Selecciona las primeras 200 filas
    p.Title, u.DisplayName -- de la columna Title de la tabla Posts y la columna DisplayName de la tabla Users
FROM Posts p -- De la tabla Posts con alias 'p'
INNER JOIN Users u ON p.OwnerUserId = u.Id -- Une con la tabla Users utilizando la columna OwnerUserId de Posts y la columna Id de Users
WHERE p.OwnerUserId IS NOT NULL; -- Donde la columna OwnerUserId no es NULL

--3

SELECT TOP 200 -- Selecciona las primeras 200 filas
    Users.DisplayName, AVG(posts.Score) AS AvgScore  -- Selecciona la columna DisplayName de la tabla Users y obtiene el promedio de Score de la tabla Posts
FROM posts p -- De la tabla Posts con alias 'p'
INNER JOIN Users ON posts.OwnerUserId = Users.Id -- Une la tabla Posts con la tabla Users donde OwnerUserId coincide con Id
GROUP BY Users.DisplayName; -- Agrupa por la columna DisplayName de la tabla Users

--4

SELECT TOP 200 -- Selecciona las primeras 200 filas 
    u.DisplayName -- de la columna DisplayName de la tabla Users
FROM Users u -- De la tabla Users con alias 'u'
WHERE u.Id IN ( -- Donde la columna Id de la tabla Users se encuentra en los resultados de la subconsulta
    SELECT Comments.UserId -- Selecciona la columna UserId de la tabla Comments
    FROM Comments -- De la tabla Comments
    GROUP BY Comments.UserId -- Agrupa por la columna UserId de la tabla Comments
    HAVING COUNT(Comments.ID) > 100 -- Filtra los grupos de UserId donde el número de comentarios es mayor a 100
);

--5

UPDATE Users -- Actualiza la tabla Users
SET Location = 'Desconocido' -- Establece la columna Location a 'Desconocido'
WHERE Location IS NULL OR Location = ''; -- Donde la columna Location es NULL o está vacía

--6

BEGIN TRANSACTION; --Inicia una transaccion

DELETE FROM Comments --elimina los comentarios de la tabla Comments
WHERE UserId IN (SELECT Id FROM Users WHERE Reputation < 100); --Donde la tabla UserId se encuentran los resultados de la subconsulta(Selecciona el Id de la tabla Users donde la reputacion es menor 100)

--7

SELECT TOP 200 -- Selecciona las primeras 200 filas
    u.DisplayName, -- De la columna DisplayName de la tabla Users con alias 'u'
    COUNT(p.Id) AS TotalPosts, -- Cuenta el número de filas en la tabla Posts con alias 'p' para cada usuario
    COUNT(c.Id) AS TotalComments, -- Cuenta el número de filas en la tabla Comments con alias 'c' para cada usuario
    COUNT(b.Id) AS TotalBadges -- Cuenta el número de filas en la tabla Badges con alias 'b' para cada usuario
FROM
    Users u -- Tabla Users con alias 'u'
LEFT JOIN
    Posts p ON u.Id = p.OwnerUserId -- Unión izquierda con la tabla Posts donde Id de 'u' coincide con OwnerUserId de 'p'
LEFT JOIN
    Comments c ON u.Id = c.UserId -- Unión izquierda con la tabla Comments donde Id de 'u' coincide con UserId de 'c'
LEFT JOIN
    Badges b ON u.Id = b.UserId -- Unión izquierda con la tabla Badges donde Id de 'u' coincide con UserId de 'b'
GROUP BY
    u.DisplayName; -- Agrupa por la columna DisplayName de la tabla Users

--8

SELECT TOP 10 Title, Score -- Selecciona las 10 publicaciones con mayor puntuación, incluyendo los campos Title y Score
FROM Posts -- De la tabla Posts
ORDER BY Score DESC; -- Ordena los resultados por puntuacion en orden descendente

--9

SELECT TOP 5 Text, CreationDate -- Selecciona los 5 comentarios más recientes, incluyendo los campos Text y CreationDate
FROM Comments -- De la tabla Comments
ORDER BY CreationDate DESC; -- Ordena los resultados por CreationDate en orden descendente

