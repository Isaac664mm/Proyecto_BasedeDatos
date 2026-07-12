CREATE DATABASE IF NOT EXISTS TiendaOnline;
USE TiendaOnline;

-- 1. ESTRUCTURA DE TABLAS
CREATE TABLE Categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),
    stock INT NOT NULL CHECK (stock >= 0),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    correo VARCHAR(150) UNIQUE NOT NULL,
    direccion TEXT NOT NULL,
    telefono VARCHAR(20)
);

CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('pendiente', 'enviado', 'entregado') DEFAULT 'pendiente',
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Detalle_Pedidos (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

CREATE TABLE Resenas (
    id_resena INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    id_cliente INT,
    calificacion INT NOT NULL CHECK (calificacion BETWEEN 1 AND 5),
    comment TEXT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- 2. ÍNDICES DE OPTIMIZACIÓN
CREATE INDEX idx_producto_categoria ON Productos(id_categoria);
CREATE INDEX idx_pedido_cliente ON Pedidos(id_cliente);
CREATE INDEX idx_pedido_estado ON Pedidos(estado);
CREATE INDEX idx_resena_producto ON Resenas(id_producto);

-- 3. DATOS DE PRUEBA 
USE TiendaOnline;

-- 1. POBLAR CATEGORÍAS (5 registros)
INSERT INTO Categorias (nombre, descripcion) VALUES
('Laptops', 'Computadoras portátiles para trabajo, estudio y gaming.'),
('Teléfonos', 'Smartphones de última generación y dispositivos móviles.'),
('Accesorios', 'Teclados, mouse, cargadores y complementos informáticos.'),
('Audio', 'Auriculares, altavoces y dispositivos de sonido profesional.'),
('Componentes', 'Tarjetas gráficas, procesadores y memoria RAM para PC.');

-- 2. POBLAR CLIENTES (15 registros)
INSERT INTO Clientes (nombre, correo, direccion, telefono) VALUES
('Carlos Mendoza', 'carlos.mendoza@email.com', 'Av. Reforma 405, CDMX', '555-0192'),
('María Rodriguez', 'maria.rod@email.com', 'Calle Primula 12, Guadalajara', '333-4455'),
('Juan Pablo Duarte', 'jp.duarte@email.com', 'Calle 10, Colonia Centro, Monterrey', '811-9988'),
('Ana Sofía Gómez', 'ana.gomez@email.com', 'Blvd. Las Torres 789, Puebla', '222-3344'),
('Diego Fernandez', 'diego.f@email.com', 'Av. Juárez 102, Querétaro', '442-1122'),
('Laura Chim', 'laura.chim@email.com', 'Calle 60 x 55, Mérida', '999-8877'),
('Jorge Luis Borges', 'jorge.borges@email.com', 'Pasaje Belgrano 45, San Luis', '555-4321'),
('Elena Poniatowska', 'elena.p@email.com', 'Chimalistac 23, Coyoacán', '555-7766'),
('Gabriel García', 'gabo.marquez@email.com', 'Calle del Status, Cartagena', '555-8899'),
('Lucía Méndez', 'lucia.m@email.com', 'Av. Vallarta 3200, Zapopan', '333-7711'),
('Roberto Gómez', 'chespirito@email.com', 'Vecindad 72, lomas altas', '555-0011'),
('Carmen Aristegui', 'carmen.a@email.com', 'Polanco Block B, CDMX', '555-3344'),
('Alejandro González', 'alextopo@email.com', 'Col. Condesa, Mex', '555-6677'),
('Patricia Quintana', 'patty.q@email.com', 'Av. Paz 450, Guadalajara', '333-9900'),
('Guillermo del Toro', 'memo.toro@email.com', 'Avenida de los Monstruos 666, Zapopan', '333-6660');

-- 3. POBLAR PRODUCTOS (30 registros)
INSERT INTO Productos (nombre, descripcion, precio, stock, id_categoria) VALUES
-- Laptops (Cat 1)
('Laptop Asus Vivobook', 'Intel Core i5, 8GB RAM, 512GB SSD', 750.00, 12, 1),
('MacBook Air M2', 'Pantalla Retina 13 pulgadas, 256GB SSD', 1199.00, 8, 1),
('Laptop Lenovo ThinkPad', 'AMD Ryzen 7, 16GB RAM, 1TB SSD', 950.00, 15, 1),
('Laptop Dell Inspiron', 'Intel i3, 8GB RAM, 256GB SSD', 450.00, 4, 1), -- Stock bajo para reporte
('Laptop HP Pavilion', 'AMD Ryzen 5, 16GB RAM, 512GB SSD', 680.00, 3, 1),  -- Stock bajo para reporte
('Laptop MSI Gaming', 'Intel i7, RTX 4060, 16GB RAM', 1400.00, 6, 1),
-- Teléfonos (Cat 2)
('iPhone 15 Pro', 'Pantalla Super Retina, 128GB, Titanio', 1099.00, 14, 2),
('Samsung Galaxy S24', 'Pantalla Dynamic AMOLED, 256GB', 899.00, 20, 2),
('Xiaomi Redmi Note 13', 'Pantalla 120Hz, 128GB, 8GB RAM', 250.00, 25, 2),
('Google Pixel 8', 'Cámara avanzada Pixel, 128GB', 699.00, 10, 2),
('Motorola Edge 40', 'Pantalla curva, 256GB', 400.00, 2, 2), -- Stock bajo
('Huawei P60 Pro', 'Cámara XMAGE, 256GB', 850.00, 7, 2),
-- Accesorios (Cat 3)
('Mouse Logi Master 3S', 'Mouse inalámbrico ergonómico', 100.00, 30, 3),
('Teclado Mecánico Razer', 'Switches verdes clicky, RGB Chroma', 130.00, 18, 3),
('Cargador Anker GaN 65W', 'Carga rápida para Laptop y celular', 45.00, 40, 3),
('Hub USB-C Baseus 8 en 1', 'Salida HDMI 4K, ranura SD, USB 3.0', 35.00, 50, 3),
('Tapete de Mouse Extra Grande', 'Superficie de tela micro-texturizada', 20.00, 100, 3),
('Soporte de Laptop Aluminio', 'Diseño plegable y ergonómico', 25.00, 1, 3), -- Stock bajo
-- Audio (Cat 4)
('Audífonos Sony WH-1000XM5', 'Cancelación de ruido líder en la industria', 350.00, 11, 4),
('Apple AirPods Pro 2', 'Audio espacial, estuche MagSafe USB-C', 249.00, 16, 4),
('Bocina JBL Flip 6', 'Altavoz portátil resistente al agua IP67', 110.00, 22, 4),
('Barra de Sonido Samsung', '2.1 Canales con Subwoofer inalámbrico', 180.00, 9, 4),
('Micrófono HyperX QuadCast', 'Micrófono de condensador USB para streaming', 120.00, 13, 4),
('Audífonos Logitech G733', 'Audífonos inalámbricos gaming RGB', 150.00, 4, 4), -- Stock bajo
-- Componentes (Cat 5)
('Tarjeta Gráfica RTX 4070', 'NVIDIA 12GB GDDR6X', 650.00, 5, 5),
('Procesador AMD Ryzen 9 7900X', '12 núcleos, 24 hilos, Socket AM5', 420.00, 8, 5),
('Memoria RAM Corsair 32GB', 'DDR5 6000MHz (2x16GB)', 115.00, 20, 5),
('Disco SSD Kingston 1TB', 'NVMe PCIe 4.0 M.2', 75.00, 35, 5),
('Fuente de Poder EVGA 750W', 'Certificación 80 Plus Gold Modular', 95.00, 14, 5),
('Enfriamiento Líquido NZXT', 'Radiador de 240mm con pantalla LCD', 160.00, 6, 5);

-- 4. POBLAR PEDIDOS (20 registros)
INSERT INTO Pedidos (id_cliente, fecha, estado) VALUES
(1, '2026-07-01 10:00:00', 'entregado'),
(2, '2026-07-02 11:30:00', 'entregado'),
(3, '2026-07-03 14:15:00', 'enviado'),
(4, '2026-07-04 09:00:00', 'pendiente'),
(5, '2026-07-04 16:45:00', 'pendiente'),
(6, '2026-07-05 12:00:00', 'entregado'),
(7, '2026-07-05 18:20:00', 'enviado'),
(8, '2026-07-06 10:10:00', 'pendiente'),
(9, '2026-07-06 15:30:00', 'entregado'),
(10, '2026-07-07 11:00:00', 'pendiente'),
(11, '2026-07-07 13:00:00', 'pendiente'),
(12, '2026-07-07 17:00:00', 'entregado'),
(1, '2026-07-08 09:30:00', 'pendiente'), -- Cliente 1 tiene otro pedido
(2, '2026-07-08 14:00:00', 'pendiente'), -- Cliente 2 tiene otro pedido
(13, '2026-07-08 16:15:00', 'pendiente'),
(14, '2026-07-09 10:00:00', 'pendiente'),
(15, '2026-07-09 12:45:00', 'entregado'),
(3, '2026-07-09 15:00:00', 'pendiente'), -- Cliente 3 tiene otro pedido
(4, '2026-07-10 11:15:00', 'pendiente'), -- Cliente 4 tiene otro pedido
(5, '2026-07-10 14:30:00', 'pendiente'); -- Cliente 5 tiene otro pedido

-- 5. POBLAR DETALLES DE PEDIDO (30 registros)
INSERT INTO Detalle_Pedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 750.00),   -- Pedido 1 compró Laptop Asus
(1, 13, 1, 100.00),  -- Pedido 1 compró Mouse
(2, 2, 1, 1199.00),  -- Pedido 2 compró MacBook
(2, 20, 1, 249.00),  -- Pedido 2 compró AirPods
(3, 7, 1, 1099.00),  -- Pedido 3 compró iPhone 15
(4, 3, 1, 950.00),
(5, 14, 1, 130.00),
(6, 8, 1, 899.00),   -- Pedido 6 compró Galaxy S24
(6, 19, 1, 350.00),  -- Pedido 6 compró Audífonos Sony
(7, 9, 2, 250.00),
(8, 25, 1, 650.00),
(9, 15, 2, 45.00),   -- Pedido 9 compró Cargadores Anker
(10, 21, 1, 110.00),
(11, 4, 1, 450.00),
(12, 10, 1, 699.00), -- Pedido 12 compró Google Pixel
(12, 16, 1, 35.00),  -- Pedido 12 compró Hub USB-C
(13, 27, 2, 115.00),
(14, 12, 1, 850.00),
(15, 22, 1, 180.00),
(16, 5, 1, 680.00),
(17, 6, 1, 1400.00), -- Pedido 17 compró Laptop MSI Gaming
(17, 23, 1, 120.00), -- Pedido 17 compró Micrófono HyperX
(18, 26, 1, 420.00),
(19, 28, 1, 75.00),
(20, 30, 1, 160.00),
(4, 17, 1, 20.00),   -- Agregando más líneas para llegar a 30 detalles
(5, 18, 1, 25.00),
(9, 24, 1, 150.00),
(13, 29, 1, 95.00),
(15, 11, 1, 400.00);

-- 6. POBLAR RESEÑAS (10 registros válidos en base a compras reales anteriores)
INSERT INTO Resenas (id_producto, id_cliente, calificacion, comentario) VALUES
(1, 1, 5, 'Excelente laptop para la universidad, vuela con el SSD.'),
(13, 1, 4, 'Muy ergonómico, la batería dura meses.'),
(2, 2, 5, 'La MacBook Air M2 es una obra de arte. Silenciosa y potente.'),
(20, 2, 5, 'La cancelación de ruido de los AirPods es increíble.'),
(8, 6, 4, 'Gran teléfono, la pantalla AMOLED se ve de maravilla.'),
(19, 6, 5, 'Los mejores audífonos del mercado, sonido espectacular.'),
(15, 9, 5, 'Carga mi laptop y mi celular al mismo tiempo sin calentarse.'),
(24, 9, 3, 'Buen audio, pero el plástico se siente un poco frágil.'),
(10, 12, 4, 'La cámara pura del Pixel toma fotos increíbles de noche.'),
(6, 15, 5, 'Una bestia para los juegos. Corre todo en ultra.');

-- 4. PROCEDIMIENTOS ALMACENADOS
DELIMITER //

-- 1. Registrar un nuevo pedido (verifica límite de 5 pendientes y stock)
CREATE PROCEDURE sp_RegistrarPedido(IN p_id_cliente INT, IN p_id_producto INT, IN p_cantidad INT)
BEGIN
    DECLARE v_pendientes INT;
    DECLARE v_stock_actual INT;
    DECLARE v_precio DECIMAL(10,2);
    DECLARE v_id_pedido INT;
    
    SELECT COUNT(*) INTO v_pendientes FROM Pedidos WHERE id_cliente = p_id_cliente AND estado = 'pendiente';
    SELECT stock, precio INTO v_stock_actual, v_precio FROM Productos WHERE id_producto = p_id_producto;
    
    IF v_pendientes >= 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Límite alcanzado: El cliente tiene 5 pedidos pendientes.';
    ELSEIF v_stock_actual < p_cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente para realizar el pedido.';
    ELSE
        -- Crea el pedido y el detalle si pasa las validaciones
        INSERT INTO Pedidos (id_cliente, estado) VALUES (p_id_cliente, 'pendiente');
        SET v_id_pedido = LAST_INSERT_ID();
        INSERT INTO Detalle_Pedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES (v_id_pedido, p_id_producto, p_cantidad, v_precio);
        -- Llama al SP de actualizar stock (Requisito 3)
        CALL sp_ActualizarStock(p_id_producto, p_cantidad);
    END IF;
END //

-- 2. Registrar una reseña (verifica compra previa)
CREATE PROCEDURE sp_RegistrarResena(IN p_id_cliente INT, IN p_id_producto INT, IN p_calificacion INT, IN p_comentario TEXT)
BEGIN
    DECLARE v_comprado INT;
    SELECT COUNT(*) INTO v_comprado FROM Pedidos p 
    JOIN Detalle_Pedidos dp ON p.id_pedido = dp.id_pedido 
    WHERE p.id_cliente = p_id_cliente AND dp.id_producto = p_id_producto;
    
    IF v_comprado = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Solo se pueden reseñar productos comprados.';
    ELSE
        INSERT INTO Resenas (id_producto, id_cliente, calificacion, comentario) VALUES (p_id_producto, p_id_cliente, p_calificacion, p_comentario);
    END IF;
END //

-- 3. Actualizar el stock de un producto después de un pedido
CREATE PROCEDURE sp_ActualizarStock(IN p_id_producto INT, IN p_cantidad_descontar INT)
BEGIN
    UPDATE Productos SET stock = stock - p_cantidad_descontar WHERE id_producto = p_id_producto;
END //

-- 4. Cambiar el estado de un pedido
CREATE PROCEDURE sp_CambiarEstadoPedido(IN p_id_pedido INT, IN p_nuevo_estado VARCHAR(20))
BEGIN
    UPDATE Pedidos SET estado = p_nuevo_estado WHERE id_pedido = p_id_pedido;
END //

-- 5. Eliminar reseñas de un producto y mostrar el nuevo promedio
CREATE PROCEDURE sp_EliminarResena(IN p_id_resena INT)
BEGIN
    DECLARE v_id_producto INT;
    DECLARE v_nuevo_promedio DECIMAL(3,2);
    
    SELECT id_producto INTO v_id_producto FROM Resenas WHERE id_resena = p_id_resena;
    DELETE FROM Resenas WHERE id_resena = p_id_resena;
    
    SELECT AVG(calificacion) INTO v_nuevo_promedio FROM Resenas WHERE id_producto = v_id_producto;
    SELECT v_id_producto AS Producto, v_nuevo_promedio AS Nuevo_Promedio;
END //

-- 6. Agregar un nuevo producto (verifica duplicados)
CREATE PROCEDURE sp_AgregarProducto(IN p_nombre VARCHAR(150), IN p_desc TEXT, IN p_precio DECIMAL(10,2), IN p_stock INT, IN p_id_categoria INT)
BEGIN
    DECLARE v_existe INT;
    SELECT COUNT(*) INTO v_existe FROM Productos WHERE nombre = p_nombre AND id_categoria = p_id_categoria;
    
    IF v_existe > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El producto ya existe en esta categoría.';
    ELSE
        INSERT INTO Productos (nombre, descripcion, precio, stock, id_categoria) VALUES (p_nombre, p_desc, p_precio, p_stock, p_id_categoria);
    END IF;
END //

-- 7. Actualizar la información de un cliente
CREATE PROCEDURE sp_ActualizarCliente(IN p_id_cliente INT, IN p_direccion TEXT, IN p_telefono VARCHAR(20))
BEGIN
    UPDATE Clientes SET direccion = p_direccion, telefono = p_telefono WHERE id_cliente = p_id_cliente;
END //

-- 8. Generar un reporte de productos con stock bajo (< 5)
CREATE PROCEDURE sp_ReporteStockBajo()
BEGIN
    SELECT p.id_producto, p.nombre, p.stock, c.nombre AS categoria
    FROM Productos p
    JOIN Categorias c ON p.id_categoria = c.id_categoria
    WHERE p.stock < 5;
END //

DELIMITER ;

-- 5. CONSULTAS ANALÍTICAS (Tus 3 consultas)
-- Consulta 1
SELECT c.nombre AS Categoria, p.nombre AS Producto, p.precio, p.stock
FROM Productos p
JOIN Categorias c ON p.id_categoria = c.id_categoria
WHERE p.stock > 0
ORDER BY c.nombre, p.precio ASC;
-- Consulta 2
SELECT cl.nombre, cl.correo, COUNT(DISTINCT p.id_pedido) AS Pedidos_Pendientes, 
       IFNULL(SUM(dp.cantidad * dp.precio_unitario), 0) AS Total_Compras
FROM Clientes cl
JOIN Pedidos p ON cl.id_cliente = p.id_cliente
LEFT JOIN Detalle_Pedidos dp ON p.id_pedido = dp.id_pedido
WHERE p.estado = 'pendiente'
GROUP BY cl.id_cliente, cl.nombre, cl.correo;
-- Consulta 3
SELECT p.nombre, AVG(r.calificacion) AS Promedio_Calificacion, COUNT(r.id_resena) AS Total_Resenas
FROM Productos p
JOIN Resenas r ON p.id_producto = r.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY Promedio_Calificacion DESC
LIMIT 5;