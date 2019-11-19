-- USE tienda;

-- DESCRIBE Cliente;

-- a. Inserción de 5 clientes (uno deberás ser tú)
INSERT INTO Cliente(Nombre, Apellido1, Apellido2, RFC) VALUES
('Ángel', 'De Santiago', 'Guerrero', 'SAGL93120471A'),
('Luis', 'Martínez', 'Mendónza', 'LMM9782143L'),
('Wendy', 'Magaña', 'Argente', 'WEMA97852W'),
('Guadalupe', 'Espinoza', 'Ramírez', 'GER1978453G'),
('Mariane', 'Córdova', 'Guerrero', 'MCG798541M')
;

-- SELECT *
--   FROM Cliente;

-- b. Inserción de 5 productos
INSERT INTO Producto(Nombre, Descripcion, Precioventa, Stock) VALUES
('Moto E', 'Teléfono celular Motorola', 3000.00, 1),
('A10110', 'Teléfono celular Samsung', 1500.00, 1),
('Moto One', 'Teléfono celular Motorola', 8000.00, 1),
('Iphone X', 'Teléfono celular Apple', 15000.00, 1),
('Hisense F19', 'Teléfono celular Hisense', 3500.00, 1)
;

-- SELECT *
--   FROM Producto;

-- INSERCIÓN DE 3 COMPRAS CON TRES PRODUCTOS

-- Inserción de proveedores
INSERT INTO Proveedor(Nombre, Calle, Numero, Colonia, CodigoPostal, RFC) VALUES
('FLORES RAYA BENJAMIN', 'Lamas Carbajal', '41800', 'Sanlúcar la Mayor', '32613', 'FORB7807097L7'),
('FLORES ADAME JORGE LUIS', 'Enxertos', '86', 'Villasrubias', '26359', 'FOAJ780210EJ4'),
('VAZQUEZ BAILON IOEL', 'Quevedo', '20', 'Cesuras', '28864', 'VABI820909QM4'),
('SOLIS DIAZ NELBA IRIS', 'Atamaria', '55', 'Valga', '32850', 'SODN800819FZ3'),
('SANCHEZ ARELLANO MARIA DEL ROCIO', 'Salzillo', '95', 'Oímbra', '48800', 'SAAR800617PI2');

-- Se registra la orden de compra para un proveedor en específico
INSERT INTO Compra(IdProveedor, Fecha)
SELECT IdProveedor      AS IdProveedor,
       '2019-10-10'     AS Fecha
  FROM Proveedor        AS P
 WHERE P.Nombre = 'SOLIS DIAZ NELBA IRIS';
 
INSERT INTO Compra(IdProveedor, Fecha)
SELECT IdProveedor      AS IdProveedor,
       NOW()            AS Fecha
  FROM Proveedor        AS P
 WHERE P.Nombre = 'SANCHEZ ARELLANO MARIA DEL ROCIO';
 
INSERT INTO Compra(IdProveedor, Fecha)
SELECT IdProveedor      AS IdProveedor,
       NOW()            AS Fecha
  FROM Proveedor        AS P
 WHERE P.Nombre = 'FLORES RAYA BENJAMIN';



-- Luego se registra en la compraInventario, 
-- para conocer el total de productos que se comprarán

-- VARIABLES
-- [ ] Nombre del proveedor
-- [ ] Fecha de compra
-- [ ] Nombre del producto
-- [ ] Cantidad
INSERT INTO CompraInventario (IdCompra, IdProducto, PrecioUnitario, Cantidad) VALUES 
(
    -- IdCompra
    (SELECT COM.IdCompra            AS IdCompra
       FROM Compra                  AS COM
      INNER JOIN Proveedor          AS PROV
         ON PROV.IdProveedor = COM.IdProveedor
        AND PROV.Nombre = 'SOLIS DIAZ NELBA IRIS'
        AND COM.Fecha = '2019-10-10'
    ),
    -- IdProducto
    (SELECT PROD.IdProducto         AS IdProducto
       FROM Producto                AS PROD
      WHERE PROD.Nombre = 'Moto One'
    ),
    -- Precio Unitario
    (SELECT PROD.PrecioVenta - (PROD.PrecioVenta * 0.15)            AS PrecioUnitario
       FROM Producto                                                AS PROD
      WHERE PROD.Nombre = 'Moto One'
    ),
    -- Cantidad
    10
);

INSERT INTO CompraInventario (IdCompra, IdProducto, PrecioUnitario, Cantidad) VALUES 
(
    -- IdCompra
    (SELECT COM.IdCompra            AS IdCompra
       FROM Compra                  AS COM
      INNER JOIN Proveedor          AS PROV
         ON PROV.IdProveedor = COM.IdProveedor
        AND PROV.Nombre = 'SANCHEZ ARELLANO MARIA DEL ROCIO'
        AND COM.Fecha = '2019-11-19'
    ),
    -- IdProducto
    (SELECT PROD.IdProducto         AS IdProducto
       FROM Producto                AS PROD
      WHERE PROD.Nombre = 'Hisense F19'
    ),
    -- Precio Unitario
    (SELECT PROD.PrecioVenta - (PROD.PrecioVenta * 0.15)            AS PrecioUnitario
       FROM Producto                                                AS PROD
      WHERE PROD.Nombre = 'Hisense F19'
    ),
    -- Cantidad
    5
);

INSERT INTO CompraInventario (IdCompra, IdProducto, PrecioUnitario, Cantidad) VALUES 
(
    -- IdCompra
    (SELECT COM.IdCompra            AS IdCompra
       FROM Compra                  AS COM
      INNER JOIN Proveedor          AS PROV
         ON PROV.IdProveedor = COM.IdProveedor
        AND PROV.Nombre = 'FLORES RAYA BENJAMIN'
        AND COM.Fecha = '2019-11-19'
    ),
    -- IdProducto
    (SELECT PROD.IdProducto         AS IdProducto
       FROM Producto                AS PROD
      WHERE PROD.Nombre = 'Moto E'
    ),
    -- Precio Unitario
    (SELECT PROD.PrecioVenta - (PROD.PrecioVenta * 0.15)            AS PrecioUnitario
       FROM Producto                                                AS PROD
      WHERE PROD.Nombre = 'Moto E'
    ),
    -- Cantidad
    15
);

-- INSERCIÓN DE 3 VENTAS

-- Se registra primero la orden de venta 1
INSERT INTO Venta(IdCliente, Fecha)
SELECT CLI.IdCliente            AS IdCliente,
       NOW()                    AS Fecha
  FROM Cliente                  AS CLI
 WHERE CLI.Nombre       = 'Ángel'
   AND CLI.Apellido1    = 'De Santiago'
   AND CLI.Apellido2    = 'Guerrero';

-- Se registra primero la orden de venta 2
INSERT INTO Venta(IdCliente, Fecha)
SELECT CLI.IdCliente            AS IdCliente,
       NOW()                    AS Fecha
  FROM Cliente                  AS CLI
 WHERE CLI.Nombre       = 'Wendy'
   AND CLI.Apellido1    = 'Magaña'
   AND CLI.Apellido2    = 'Argente';

-- Se registra primero la orden de venta 3
INSERT INTO Venta(IdCliente, Fecha)
SELECT CLI.IdCliente            AS IdCliente,
       NOW()                    AS Fecha
  FROM Cliente                  AS CLI
 WHERE CLI.Nombre       = 'Guadalupe'
   AND CLI.Apellido1    = 'Espinoza'
   AND CLI.Apellido2    = 'Ramírez';

-- Registro de ventas en el inventario
INSERT INTO VentaInventario(IdVenta, IdProducto, PrecioVentaUnitario, Cantidad) VALUES
(
    -- IdVenta
    (SELECT V.IdVenta           AS IdVenta
       FROM Venta               AS V
      INNER JOIN Cliente        AS C
         ON V.IdCliente = C.IdCliente
      WHERE C.Nombre    = 'Ángel'
        AND C.Apellido1 = 'De Santiago'
        AND C.Apellido2 = 'Guerrero'
        AND V.Fecha     = '2019-11-19'
    ),
    -- IdProducto
    (SELECT P.IdProducto            AS IdProducto
       FROM Producto                AS P
      WHERE P.Nombre = 'Iphone X'
    ),
    -- PrecioVentaUnitario
    (SELECT P.PrecioVenta           AS PrecioVentaUnitario
       FROM Producto                AS P
      WHERE P.Nombre = 'Iphone X'
    ),
    -- Cantidad
    5
);

INSERT INTO VentaInventario(IdVenta, IdProducto, PrecioVentaUnitario, Cantidad) VALUES
(
    -- IdVenta
    (SELECT V.IdVenta           AS IdVenta
       FROM Venta               AS V
      INNER JOIN Cliente        AS C
         ON V.IdCliente = C.IdCliente
      WHERE C.Nombre    = 'Wendy'
        AND C.Apellido1 = 'Magaña'
        AND C.Apellido2 = 'Argente'
        AND V.Fecha     = '2019-11-19'
    ),
    -- IdProducto
    (SELECT P.IdProducto            AS IdProducto
       FROM Producto                AS P
      WHERE P.Nombre = 'Hisense F19'
    ),
    -- PrecioVentaUnitario
    (SELECT P.PrecioVenta           AS PrecioVentaUnitario
       FROM Producto                AS P
      WHERE P.Nombre = 'Hisense F19'
    ),
    -- Cantidad
    3
);

INSERT INTO VentaInventario(IdVenta, IdProducto, PrecioVentaUnitario, Cantidad) VALUES
(
    -- IdVenta
    (SELECT V.IdVenta           AS IdVenta
       FROM Venta               AS V
      INNER JOIN Cliente        AS C
         ON V.IdCliente = C.IdCliente
      WHERE C.Nombre    = 'Guadalupe'
        AND C.Apellido1 = 'Espinoza'
        AND C.Apellido2 = 'Ramírez'
        AND V.Fecha     = '2019-11-19'
    ),
    -- IdProducto
    (SELECT P.IdProducto            AS IdProducto
       FROM Producto                AS P
      WHERE P.Nombre = 'Moto E'
    ),
    -- PrecioVentaUnitario
    (SELECT P.PrecioVenta           AS PrecioVentaUnitario
       FROM Producto                AS P
      WHERE P.Nombre = 'Moto E'
    ),
    -- Cantidad
    6
);

-- Actualizar el precio de 3 productos
UPDATE Producto
   SET PrecioVenta = 20000
 WHERE Nombre = 'Iphone X';

UPDATE Producto
   SET PrecioVenta = 4000
 WHERE Nombre = 'Hisense F19';

UPDATE Producto
   SET PrecioVenta = 5000
 WHERE Nombre = 'Moto E';

-- Elimina un artículo de venta
-- 1. Primero se debe de eliminar el registro del inventario ya que es una
--    Constraint de tipo Foreign Key
DELETE FROM VentaInventario
 WHERE IdProducto = (SELECT P.IdProducto            AS IdProducto
                       FROM Producto                AS P
                      WHERE P.Nombre = 'Iphone X')
   AND IdVenta = (SELECT V.IdVenta          AS IdVenta
                    FROM Venta              AS V
                   INNER JOIN Cliente       AS C
                      ON C.IdCliente = V.IdCliente
                   WHERE C.Nombre       = 'Ángel'
                     AND C.Apellido1    = 'De Santiago'
                     AND C.Apellido2    = 'Guerrero'
                     AND V.Fecha        = '2019-11-19');
-- 2. Ahora es posible eliminar registro de la tabla Venta
--
DELETE FROM Venta
 WHERE IdCliente = (SELECT C.IdCliente          AS IdCliente
                      FROM Cliente              AS C
                     WHERE C.Nombre       = 'Ángel'
                       AND C.Apellido1    = 'De Santiago'
                       AND C.Apellido2    = 'Guerrero')
  AND Fecha = '2019-11-19';

-- f. Consultar todos los artículos disponibles
SELECT P.*
  FROM Producto AS P
 WHERE P.Stock = 1

-- g. Consulta de nombre y código postal de los proveedores
-- ordenados por código postal en orden descendente
SELECT P.Nombre,
       P.CodigoPostal
  FROM Proveedor            AS P
 ORDER BY P.CodigoPostal DESC;

-- h. Consulta las compras realizadas en el último mes
SELECT C.*
  FROM Compra   AS C
 WHERE C.Fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- i. Consulta los clientes cuyo nombre inicie con tu inicial
SELECT C.*
  FROM Cliente  AS C
 WHERE LOWER(C.Nombre) LIKE 'a%';

-- j. Consulta los productos cuyo precio sea mayor a 50 pesos
SELECT P.*
  FROM Producto AS P
 WHERE p.PrecioVenta > 50;

-- k. Consulta que muestre Nombre de cliente, número de compra
--    y fecha de realización
SELECT CLI.Nombre           AS "Nombre del cliente",
       VEN.IdVenta          AS "Número de compra",
       VEN.Fecha            AS "Fecha de realización"
  FROM Cliente              AS CLI
 INNER JOIN Venta           AS VEN
    ON CLI.IdCliente = VEN.IdCliente;

-- l. Consulta que muestre cantidad de artículos totales vendidos
SELECT COUNT(1)     AS "Artículos totales vendidos"
  FROM Venta;

-- m. Consulta que muestre número de compras realizadas agrupadas
-- por proveedor
SELECT P.Nombre             AS "Nombre del proveedor",
       COUNT(C.IdCompra)    AS "Compras realizadas"
  FROM Proveedor            AS P
 INNER JOIN Compra          AS C
    ON P.IdProveedor = C.IdProveedor
 GROUP BY (P.Nombre);

-- n. Consulta el producto con menor precio
SELECT P.Nombre,
       P.PrecioVenta
  FROM Producto AS P
 WHERE P.PrecioVenta <= (SELECT MIN(SP.PrecioVenta)
                           FROM Producto AS SP);

-- o. Consulta el producto con mayor precio
SELECT P.Nombre,
       P.PrecioVenta
  FROM Producto AS P
 WHERE P.PrecioVenta >= (SELECT MAX(SP.PrecioVenta)
                           FROM Producto AS SP);

-- p. Consulta el promedio de precios de productos
SELECT AVG(P.PrecioVenta)
  FROM Producto AS P;

-- q. Consulta que muestre el detalle de una compra (Nombre de producto,
-- precio unitario, cantidad y costo)
-- Variable: Fecha de la compra, nombre del producto
SELECT P.Nombre                             AS "Nombre producto"
     , CI.PrecioUnitario                    AS "Precio unitario"
     , CI.Cantidad                          AS "Cantidad"
     , (CI.PrecioUnitario * CI.Cantidad)    AS "Costo total"
  FROM CompraInventario         AS CI

 INNER JOIN Producto            AS P
    ON P.IdProducto = CI.IdProducto

 INNER JOIN Compra              AS C
    ON C.IdCompra = CI.IdCompra

 WHERE C.Fecha = '2019-10-10'
   AND P.Nombre = 'Moto One';

-- r. Consulta que muestre el costo total de una venta
SELECT P.Nombre                                     AS "Nombre del producto"
     , VI.PrecioVentaUnitario                       AS "Precio de venta"
     , VI.Cantidad                                  AS "Cantidad de productos"
     , (VI.PrecioVentaUnitario * VI.Cantidad)       AS "Costo total de venta"
  FROM VentaInventario                              AS VI

 INNER JOIN Producto                                AS P
    ON P.IdProducto = VI.IdProducto

 INNER JOIN Venta                                   AS V
    ON V.IdVenta = VI.IdVenta

 WHERE 1 = 1
   AND V.Fecha = '2019-11-19'
   AND P.Nombre = 'Hisense F19'
     ;