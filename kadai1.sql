mysql> DROP TABLE project;
ERROR 1051 (42S02): Unknown table 'demo.project'
mysql> CREATE TABLE employee (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(50) NOT NULL,
    ->     age INT NOT NULL,
    ->     job VARCHAR(50),
    ->     sal INT,
    ->     department_id INT
    -> );
ERROR 1050 (42S01): Table 'employee' already exists
mysql> DROP TABLE employee;
Query OK, 0 rows affected (0.07 sec)

mysql> CREATE TABLE employee (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(50) NOT NULL,
    ->     age INT NOT NULL,
    ->     job VARCHAR(50),
    ->     sal INT,
    ->     department_id INT
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> DROP TABLE department;
Query OK, 0 rows affected (0.06 sec)

mysql> CREATE TABLE department (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     department_name VARCHAR(50) NOT NULL
    -> );
Query OK, 0 rows affected (0.08 sec)

mysql> CREATE TABLE project (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     project_name VARCHAR(100) NOT NULL,
    ->     employee_id INT,
    ->     FOREIGN KEY (employee_id) REFERENCES employee(id)
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> INSERT INTO employee (name, age, job, sal, department_id) VALUES
    -> ('松田', 65, '社長', 950000, 1),
    -> ('山田', 43, '部長', 680000, 2),
    -> ('北條', 30, '営業マネージャー', 600000, 3),
    -> ('佐藤', 28, 'エンジニア', 500000, 2),
    -> ('鈴木', 35, 'エンジニア', 550000, 2);
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO department (department_name) VALUES
    -> ('経営管理部'),
    -> ('技術部'),
    -> ('営業部');
Query OK, 3 rows affected (0.04 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO project (project_name, employee_id) VALUES
    -> ('新規開発プロジェクト', 4),
    -> ('マーケティングキャンペーン', 3),
    -> ('製品改善プロジェクト', 5);
Query OK, 3 rows affected (0.05 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SHOW TABLES;
+----------------+
| Tables_in_demo |
+----------------+
| department     |
| employee       |
| project        |
+----------------+
3 rows in set (0.00 sec)

mysql> DESCRIBE employee;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| id            | int         | NO   | PRI | NULL    | auto_increment |
| name          | varchar(50) | NO   |     | NULL    |                |
| age           | int         | NO   |     | NULL    |                |
| job           | varchar(50) | YES  |     | NULL    |                |
| sal           | int         | YES  |     | NULL    |                |
| department_id | int         | YES  |     | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+
6 rows in set (0.00 sec)

mysql> DESCRIBE department;
+-----------------+-------------+------+-----+---------+----------------+
| Field           | Type        | Null | Key | Default | Extra          |
+-----------------+-------------+------+-----+---------+----------------+
| id              | int         | NO   | PRI | NULL    | auto_increment |
| department_name | varchar(50) | NO   |     | NULL    |                |
+-----------------+-------------+------+-----+---------+----------------+
2 rows in set (0.01 sec)

mysql> DESCRIBE project;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| id           | int          | NO   | PRI | NULL    | auto_increment |
| project_name | varchar(100) | NO   |     | NULL    |                |
| employee_id  | int          | YES  | MUL | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
3 rows in set (0.00 sec)

mysql> SELECT * FROM employee;
+----+--------+-----+--------------------------+--------+---------------+
| id | name   | age | job                      | sal    | department_id |
+----+--------+-----+--------------------------+--------+---------------+
|  1 | 松田   |  65 | 社長                      | 950000 |             1 |
|  2 | 山田   |  43 | 部長                      | 680000 |             2 |
|  3 | 北條   |  30 | 営業マネージャー           | 600000 |             3 |
|  4 | 佐藤   |  28 | エンジニア                | 500000 |             2 |
|  5 | 鈴木   |  35 | エンジニア                | 550000 |             2 |
+----+--------+-----+--------------------------+--------+---------------+
5 rows in set (0.00 sec)

mysql> SELECT * FROM department;
+----+-----------------+
| id | department_name |
+----+-----------------+
|  1 | 経営管理部      |
|  2 | 技術部          |
|  3 | 営業部          |
+----+-----------------+
3 rows in set (0.00 sec)

mysql> SELECT * FROM project;
+----+-----------------------------------------+-------------+
| id | project_name                            | employee_id |
+----+-----------------------------------------+-------------+
|  1 | 新規開発プロジェクト                      |           4 |
|  2 | マーケティングキャンペーン                 |           3 |
|  3 | 製品改善プロジェクト                      |           5 |
+----+-----------------------------------------+-------------+

**課題8.1**
**SELECT文: 全データ取得**
問題: employeeテーブルの全データを取得するSQL文を書いてください。
mysql> SELECT *FROM employee;


**特定の列を取得**
問題: employeeテーブルからnameとsal列のみを取得するSQL文を書いてください。
SELECT name, sal FROM employee;

**WHERE句: 条件付き取得**
問題: employeeテーブルからsalが500,000以上のデータを取得してください。
SELECT * FROM employee WHERE sal >= 500000;

**ORDER BY句: 並び替え**
問題: employeeテーブルをsalの降順で並べ替えてください。
SELECT * FROM employee ORDER BY sal DESC;

**INSERT文: データの追加**
問題: employeeテーブルに以下のデータを追加するSQL文を書いてください。
| name | age | job | sal |
| --- | --- | --- | --- |
| 佐藤 | 35 | 営業 | 550,000 |
INSERT INTO employee (name, age, job, sal) VALUES ('佐藤', 35, '営業', 550000);

**UPDATE文: データの更新**
問題: employeeテーブルの松田さんの月給を1,000,000に更新するSQL文を書いてください。
UPDATE employee SET sal = 1000000 WHERE name = '松田';

**DELETE文: データの削除**
問題: employeeテーブルから北條さんのデータを削除するSQL文を書いてください。
DELETE FROM employee WHERE name = '北條';

**COUNT関数: データ件数の取得**
問題: employeeテーブルのデータ件数を取得してください。
SELECT COUNT(*) FROM employee;

**DISTINCT文: 重複の排除job**
問題: employeeテーブルのjob列に含まれる重複を排除して取得してください。
SELECT DISTINCT job FROM employee;

**GROUP BY文: データのグループ化**
問題: employeeテーブルをjobごとにグループ化し、各jobごとの社員数を取得してください。
SELECT job, COUNT(*) FROM employee GROUP BY job;

**課題8.2**
**HAVING文: グループ条件**
問題: 各jobごとの社員数を取得し、社員数が2人以上のjobだけを表示してください。
SELECT job, COUNT(*) AS cnt
FROM employee
GROUP BY job
HAVING COUNT(*) >= 2;

**INNER JOIN文: テーブルの結合**
問題: employeeテーブルとdepartmentテーブルをdepartment_idで結合し、社員名と所属部署名を取得してください。
SELECT e.name, d.department_name
FROM employee e
INNER JOIN department d
ON e.department_id = d.id;


**LEFT JOIN文: 左結合**
問題: employeeテーブルのすべての社員と、その部署を左結合で取得してください。
SELECT e.name, d.department_name
FROM employee e
LEFT JOIN department d
ON e.department_id = d.id;

**サブクエリ: 条件の入れ子**
問題: 月給が全社員の平均月給より高い社員を取得してください。
SELECT *
FROM employee
WHERE sal > (
  SELECT AVG(sal) FROM employee
);

**ORDER BYとLIMITの組み合わせ**
問題: employeeテーブルから月給の高い順に3人を取得してください。
SELECT *
FROM employee
ORDER BY sal DESC
LIMIT 3;

**ウィンドウ関数: 行番号の付与**
問題: employeeテーブルに対し、salの降順で行番号を付与して表示してください。
SELECT 
  name,
  sal,
  ROW_NUMBER() OVER (ORDER BY sal DESC) AS row_num
FROM employee;

**トランザクション: データ操作**
問題: 以下の操作をトランザクションで管理してください。

- 社員山田の月給を50,000減額する。
- 社員鈴木の月給を50,000増額する。
START TRANSACTION;

UPDATE employee
SET sal = sal - 50000
WHERE name = '山田';

UPDATE employee
SET sal = sal + 50000
WHERE name = '鈴木';

COMMIT;

**CASE文: 条件による値の変更**
問題: employeeテーブルのsalが600,000以上なら"高給", それ未満なら"普通"と表示してください。
SELECT
  name,
  sal,
  CASE
    WHEN sal >= 600000 THEN '高給'
    ELSE '普通'
  END AS salary_level
FROM employee;

**複雑なサブクエリ: 最大値の取得**
問題: 月給が各部署内で最大の社員を取得してください。
SELECT *
FROM employee e
WHERE sal = (
  SELECT MAX(sal)
  FROM employee
  WHERE department_id = e.department_id
);

**FULLOUTERJOIN文: 全結合**
問題: employeeテーブルとdepartmentテーブルを全結合し、どちらかに存在しないデータをNULLで補完して取得してください。
SELECT e.name, d.department_name
FROM employee e
LEFT JOIN department d
ON e.department_id = d.id

UNION

SELECT e.name, d.department_name
FROM employee e
RIGHT JOIN department d
ON e.department_id = d.id;