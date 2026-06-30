以下の3つのテーブルを作成してください。

1. **usersテーブル**（ユーザー情報）
    mysql> CREATE TABLE users (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(50) NOT NULL,
    ->     email VARCHAR(100) UNIQUE,
    ->     created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    ->     updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    -> );
Query OK, 0 rows affected (0.07 sec)

2. **productsテーブル**（商品情報）
    mysql> CREATE TABLE products (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(100) NOT NULL,
    ->     price INT,
    ->     stock INT,
    ->     created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    ->     updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    -> );
Query OK, 0 rows affected (0.04 sec)

3. **ordersテーブル**（注文情報）
    mysql> CREATE TABLE orders (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     user_id INT,
    ->     product_id INT,
    ->     quantity INT,
    ->     order_date  DATETIME DEFAULT CURRENT_TIMESTAMP,
    ->      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    ->     updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ->
    ->     FOREIGN KEY (user_id) REFERENCES users(id),
    ->     FOREIGN KEY (product_id) REFERENCES products(id)
    -> );
Query OK, 0 rows affected (0.05 sec)

以下のデータをSQLを使って挿入してください。

※`created_at` と`updated_at` については、作成日と更新日が挿入されるようにする

- **usersテーブル**:
INSERT INTO users (name,email)VALUES('田中太郎','tanaka@example.com');
INSERT INTO users (name,email)VALUES('佐藤花子','sato@example.com');
INSERT INTO users (name,email)VALUES('山本次郎','yamamoto@example.com');

- **productsテーブル**:
INSERT INTO products (name,price,stock)VALUES('ノートパソコン', 120000,20);
INSERT INTO products (name,price,stock)VALUES('スマートフォン',80000,15);
INSERT INTO products (name,price,stock)VALUES('タブレット',60000,30);

- **ordersテーブル**:
INSERT INTO orders (user_id, product_id, quantity)
VALUES (
    (SELECT id FROM users WHERE name = '田中太郎'),
    (SELECT id FROM products WHERE name = 'ノートパソコン'),
    2
);
INSERT INTO orders (user_id, product_id, quantity)
VALUES (
    (SELECT id FROM users WHERE name = '佐藤花子'),
    (SELECT id FROM products WHERE name = 'スマートフォン'),
    1
);
INSERT INTO orders (user_id, product_id, quantity)
VALUES (
    (SELECT id FROM users WHERE name = '山本次郎'),
    (SELECT id FROM products WHERE name = 'タブレット'),
    3
);

**3. クエリの作成**

以下の内容を取得するSQL文を作成してください。

1. 全ユーザーの情報を取得する。
SELECT *FROM users;

2. すべての商品とその在庫を取得する。
SELECT name, stock
FROM products;

3. 注文履歴を`ユーザー名`, `商品名`, `購入数量`の形式で取得する。
SELECT
  u.name AS user_name,
  p.name AS product_name,
  o.quantity
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN products p ON o.product_id = p.id;

4. 在庫が不足している商品を取得する（在庫が10以下）。
SELECT name, stock
FROM products
WHERE stock <= 10;

5. 各商品の累計売上を計算して取得する。
SELECT
  p.name AS product_name,
  SUM(o.quantity) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.id
GROUP BY p.name;
